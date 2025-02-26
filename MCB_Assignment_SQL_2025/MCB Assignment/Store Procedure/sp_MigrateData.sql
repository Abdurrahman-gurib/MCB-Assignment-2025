USE [MCB_Assignment_2025]
GO
/****** Object:  StoredProcedure [dbo].[sp_MigrateData]    Script Date: 25/02/2025 12:27:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_MigrateData]
AS
BEGIN
    SET NOCOUNT ON;

    --------------------------------------------------------------------------------------------
    -- 1. Insert distinct Suppliers
    --
    -- For each distinct supplier from BCM_ORDER_MGT:
    --   - SupplierTown is extracted as the second last token from the address.
    --     (Reversing the address, taking the substring between the first two commas in the reversed string, then reversing back.)
    --   - The primary contact number is extracted from the text before the comma.
    --     It is cleaned by removing periods and returned only if it contains exclusively digits and spaces.
    --   - The secondary contact number is extracted from the text after the comma.
    --     It is similarly cleaned and returned only if it contains exclusively digits and spaces.
    --   - GROUP BY is used to merge duplicate rows with minor variations.
    --------------------------------------------------------------------------------------------
    INSERT INTO dbo.Suppliers 
         (SupplierName, SupplierContactName, SupplierAddress, SupplierTown, SupplierContactNumber1, SupplierContactNumber2, SupplierEmail)
    SELECT
         SUPPLIER_NAME,
         SUPP_CONTACT_NAME,
         SUPP_ADDRESS,
         LTRIM(RTRIM(
             REVERSE(
                 SUBSTRING(
                     REVERSE(SUPP_ADDRESS), 
                     CHARINDEX(',', REVERSE(SUPP_ADDRESS)) + 1, 
                     CHARINDEX(',', REVERSE(SUPP_ADDRESS), CHARINDEX(',', REVERSE(SUPP_ADDRESS)) + 1)
                     - CHARINDEX(',', REVERSE(SUPP_ADDRESS)) - 1
                 )
             )
         )) AS SupplierTown,
         MAX(
            CASE 
                WHEN (PATINDEX('%[^0-9 ]%', LTRIM(RTRIM(
                    REPLACE(
                        CASE 
                           WHEN CHARINDEX(',', SUPP_CONTACT_NUMBER) > 0 
                              THEN LEFT(SUPP_CONTACT_NUMBER, CHARINDEX(',', SUPP_CONTACT_NUMBER)-1)
                           ELSE SUPP_CONTACT_NUMBER
                        END, '.', '')
                ))) = 0)
                THEN LTRIM(RTRIM(
                     REPLACE(
                        CASE 
                           WHEN CHARINDEX(',', SUPP_CONTACT_NUMBER) > 0 
                              THEN LEFT(SUPP_CONTACT_NUMBER, CHARINDEX(',', SUPP_CONTACT_NUMBER)-1)
                           ELSE SUPP_CONTACT_NUMBER
                        END, '.', '')
                ))
                ELSE NULL 
            END
         ) AS SupplierContactNumber1,
         MAX(
            CASE 
                WHEN CHARINDEX(',', SUPP_CONTACT_NUMBER) > 0 
                     AND (PATINDEX('%[^0-9 ]%', LTRIM(RTRIM(
                        REPLACE(
                           SUBSTRING(SUPP_CONTACT_NUMBER, CHARINDEX(',', SUPP_CONTACT_NUMBER)+1, LEN(SUPP_CONTACT_NUMBER)), 
                           '.', ''
                        )
                     ))) = 0)
                THEN LTRIM(RTRIM(
                     REPLACE(
                        SUBSTRING(SUPP_CONTACT_NUMBER, CHARINDEX(',', SUPP_CONTACT_NUMBER)+1, LEN(SUPP_CONTACT_NUMBER)), 
                        '.', ''
                     )
                ))
                ELSE NULL 
            END
         ) AS SupplierContactNumber2,
         SUPP_EMAIL
    FROM BCM_ORDER_MGT
    GROUP BY SUPPLIER_NAME, SUPP_CONTACT_NAME, SUPP_ADDRESS, SUPP_EMAIL;

    --------------------------------------------------------------------------------------------
    -- 2. Insert Orders (Header rows - Orders without a hyphen in ORDER_REF)
    --
    -- For header rows (where ORDER_REF does not contain a hyphen):
    --   - OrderDate is converted from text to DATE using TRY_CONVERT with style 106.
    --   - OrderTotalAmount is converted to DECIMAL after removing commas.
    --   - SupplierID is determined by a case-insensitive lookup from Suppliers using SupplierName and SupplierAddress.
    --------------------------------------------------------------------------------------------
    INSERT INTO dbo.Orders 
         (OriginalOrderRef, OrderDate, SupplierID, OrderTotalAmount, OrderDescription, OrderStatus)
    SELECT
         ORDER_REF,
         TRY_CONVERT(DATE, ORDER_DATE, 106),
         (SELECT TOP 1 SupplierID 
          FROM dbo.Suppliers S 
          WHERE UPPER(S.SupplierName) = UPPER(B.SUPPLIER_NAME)
            AND S.SupplierAddress = B.SUPP_ADDRESS),
         TRY_CONVERT(DECIMAL(15,2), REPLACE(ORDER_TOTAL_AMOUNT, ',', '')),
         ORDER_DESCRIPTION,
         ORDER_STATUS
    FROM BCM_ORDER_MGT B;

    --------------------------------------------------------------------------------------------
    -- 3. Insert Invoices (Detail rows - Orders with invoice references)
    --
    -- For each row in BCM_ORDER_MGT with a non-null invoice reference:
    --   - The corresponding order is determined by matching the base order reference 
    --     (text before any hyphen).
    --   - InvoiceDate is converted from text to DATE using TRY_CONVERT with style 106.
    --   - InvoiceAmount is converted to DECIMAL after removing commas.
    --------------------------------------------------------------------------------------------
    INSERT INTO dbo.Invoices 
         (OrderID, InvoiceReference, InvoiceDate, InvoiceStatus, InvoiceHoldReason, InvoiceAmount, InvoiceDescription)
    SELECT
         O.OrderID,
         B.INVOICE_REFERENCE,
         TRY_CONVERT(DATE, B.INVOICE_DATE, 106),
         B.INVOICE_STATUS,
         B.INVOICE_HOLD_REASON,
         TRY_CONVERT(DECIMAL(15,2), REPLACE(B.INVOICE_AMOUNT, ',', '')),
         B.INVOICE_DESCRIPTION
    FROM BCM_ORDER_MGT B
    INNER JOIN dbo.Orders O 
       ON O.OriginalOrderRef = 
          CASE 
             WHEN CHARINDEX('-', B.ORDER_REF) > 0 
                THEN LEFT(B.ORDER_REF, CHARINDEX('-', B.ORDER_REF)-1)
             ELSE B.ORDER_REF 
          END
    WHERE B.INVOICE_REFERENCE IS NOT NULL;

    PRINT 'Data migration completed successfully.';
END;
