USE [MCB_Assignment_2025]
GO
/****** Object:  StoredProcedure [dbo].[sp_ReportMedianOrder]    Script Date: 25/02/2025 09:25:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ReportMedianOrder]
AS
BEGIN
    SET NOCOUNT ON;

    --------------------------------------------------------------------------------------------
    -- CTE: OrderedOrders (Only selects rows with non-null OrderTotalAmount)
    -- Assigns a row number and total count for median calculation.
    --------------------------------------------------------------------------------------------
    ;WITH OrderedOrders AS
    (
        SELECT 
            O.OrderID,                        
            O.OriginalOrderRef,               
            O.OrderDate,                      
            O.OrderTotalAmount,               
            O.OrderStatus,                    
            S.SupplierName,                   
            ROW_NUMBER() OVER (ORDER BY O.OrderTotalAmount) AS rn,  
            COUNT(*) OVER () AS cnt          
        FROM dbo.Orders O
        INNER JOIN dbo.Suppliers S ON O.SupplierID = S.SupplierID
        WHERE O.OrderTotalAmount IS NOT NULL -- Exclude NULL values
    )
    
    --------------------------------------------------------------------------------------------
    -- Find the Median Order
    --------------------------------------------------------------------------------------------
    SELECT TOP 1
        CAST(SUBSTRING(O.OriginalOrderRef, 3, LEN(O.OriginalOrderRef) - 2) AS NVARCHAR(10)) AS OrderReference,
        CONVERT(VARCHAR(11), O.OrderDate, 106) AS OrderDate, -- Ensure date format '01-JAN-2024'
        UPPER(O.SupplierName) AS SupplierName,
        FORMAT(O.OrderTotalAmount, 'N2') AS OrderTotalAmount,
        O.OrderStatus,
        -- Retrieve invoice references, using XML PATH to avoid duplicates
        ISNULL(
            STUFF((
                SELECT DISTINCT '|' + I.InvoiceReference
                FROM dbo.Invoices I
                WHERE I.OrderID = O.OrderID AND I.InvoiceReference IS NOT NULL
                FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, ''
            ), 'N/A') AS InvoiceReferences
    FROM OrderedOrders O
   WHERE  rn = (cnt / 2) + 1 OR rn = (cnt / 2)
    ORDER BY O.OrderTotalAmount; 
END;
