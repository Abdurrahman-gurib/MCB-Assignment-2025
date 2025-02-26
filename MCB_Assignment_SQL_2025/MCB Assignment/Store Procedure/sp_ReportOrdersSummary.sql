USE [MCB_Assignment_2025]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ReportOrdersSummary]
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Extract Orders Data
    WITH OrderSummary AS (
        SELECT 
            S.SupplierTown AS Region,
            TRY_CAST(STUFF(O.OriginalOrderRef, 1, 2, '') AS INT) AS OrderReference,
            FORMAT(O.OrderDate, 'yyyy-MM') AS OrderPeriod,
            O.OrderTotalAmount,
            O.OrderStatus,
            O.OrderID,
            S.SupplierName
        FROM dbo.Orders O
        JOIN dbo.Suppliers S ON O.SupplierID = S.SupplierID
    ),
    -- Step 2: Extract Invoice Data and Aggregate
    InvoiceSummary AS (
        SELECT 
            I.OrderID,
            STRING_AGG(I.InvoiceReference, ', ') AS InvoiceReferences, 
            FORMAT(SUM(I.InvoiceAmount), 'N2') AS InvoiceTotalAmount, 
            CASE 
                WHEN SUM(CASE WHEN I.InvoiceStatus = 'Pending' THEN 1 ELSE 0 END) > 0 THEN 'To follow up'
                WHEN SUM(CASE WHEN I.InvoiceStatus IS NULL OR I.InvoiceStatus = '' THEN 1 ELSE 0 END) > 0 THEN 'To verify'
                ELSE 'No Action'
            END AS Action 
        FROM dbo.Invoices I
        GROUP BY I.OrderID
    )
    -- Step 3: Generate Final Output
    SELECT 
        OS.Region,
        OS.OrderReference,
        OS.OrderPeriod,
        OS.SupplierName,
        FORMAT(OS.OrderTotalAmount, 'N2') AS OrderTotalAmount,
        OS.OrderStatus,
        ISNULL(InvSummary.InvoiceReferences, 'N/A') AS InvoiceReference,
        ISNULL(InvSummary.InvoiceTotalAmount, '0.00') AS InvoiceTotalAmount,
        ISNULL(InvSummary.Action, 'No Action') AS Action
    FROM OrderSummary OS
    LEFT JOIN InvoiceSummary InvSummary ON OS.OrderID = InvSummary.OrderID
    WHERE ISNULL(InvSummary.InvoiceReferences, 'N/A') <> 'N/A'
    ORDER BY OS.Region DESC, OS.OrderTotalAmount DESC;
END;
