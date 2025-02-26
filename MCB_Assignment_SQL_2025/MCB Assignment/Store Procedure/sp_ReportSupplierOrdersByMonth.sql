USE [MCB_Assignment_2025]
GO
/****** Object:  StoredProcedure [dbo].[sp_ReportSupplierOrdersByMonth]    Script Date: 23/02/2025 22:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ReportSupplierOrdersByMonth]
AS
BEGIN
    SET NOCOUNT ON;

    --------------------------------------------------------------------------------------------
    -- sp_ReportSupplierOrdersByMonth
    --
    -- This stored procedure returns a monthly summary report of supplier orders.
    --
    -- Report Fields:
    --
    -- Month:
    --   - Derived from OrderDate.
    --   - Formatted as 'Month Year' (e.g., 'January 2024').
    --
    -- SupplierName:
    --   - The supplier's name.
    --
    -- SupplierContactName:
    --   - The supplier's contact person.
    --
    -- SupplierContactNumber1:
    --   - The first contact number.
    --   - Spaces are replaced with hyphens.
    --
    -- SupplierContactNumber2:
    --   - The second contact number.
    --   - Spaces are replaced with hyphens.
    --
    -- TotalOrders:
    --   - Total number of orders for the supplier in the month.
    --
    -- OrderTotalAmount:
    --   - Sum of the order total amounts for the supplier in that month.
    --   - Formatted to two decimal places.
    --------------------------------------------------------------------------------------------
    SELECT 
       DATENAME(month, O.OrderDate) + ' ' + CAST(YEAR(O.OrderDate) AS VARCHAR(4)) AS [Month],
       S.SupplierName,
       S.SupplierContactName,
       REPLACE(S.SupplierContactNumber1, ' ', '-') AS SupplierContactNumber1,
       REPLACE(S.SupplierContactNumber2, ' ', '-') AS SupplierContactNumber2,
       COUNT(*) AS TotalOrders,
       FORMAT(SUM(O.OrderTotalAmount), 'N2') AS OrderTotalAmount
    FROM dbo.Orders O
    INNER JOIN dbo.Suppliers S ON O.SupplierID = S.SupplierID
    WHERE O.OrderDate BETWEEN '2024-01-01' AND '2024-08-31'
    GROUP BY DATENAME(month, O.OrderDate), YEAR(O.OrderDate),
             S.SupplierName, S.SupplierContactName, S.SupplierContactNumber1, S.SupplierContactNumber2
    ORDER BY TotalOrders DESC;
END;
