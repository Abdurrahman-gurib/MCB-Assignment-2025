
-------------------------------------------------------
-- Create the Suppliers Table
-------------------------------------------------------
CREATE TABLE dbo.Suppliers (
    SupplierID                INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName              NVARCHAR(100) NOT NULL,
    SupplierContactName       NVARCHAR(100) NULL,
    SupplierAddress           NVARCHAR(200) NULL,
    SupplierTown              NVARCHAR(50) NULL,  -- Extracted from full address for town/village info
    SupplierContactNumber1    NVARCHAR(20) NULL,
    SupplierContactNumber2    NVARCHAR(20) NULL,
    SupplierEmail             NVARCHAR(100) NULL
);
GO

-------------------------------------------------------
-- Create the Orders Table
-------------------------------------------------------
CREATE TABLE dbo.Orders (
    OrderID                   INT IDENTITY(1,1) PRIMARY KEY,
    OriginalOrderRef          NVARCHAR(20) NOT NULL,  -- e.g. 'PO001'; used later to extract numeric value
    OrderDate                 DATE NULL,
    SupplierID                INT NULL,
    OrderTotalAmount          DECIMAL(15,2) NULL,
    OrderDescription          NVARCHAR(200) NULL,
    OrderStatus               NVARCHAR(20) NULL,
    CONSTRAINT FK_Orders_Suppliers FOREIGN KEY (SupplierID)
        REFERENCES dbo.Suppliers(SupplierID)
);
GO

-------------------------------------------------------
-- Create the Invoices Table
-------------------------------------------------------
CREATE TABLE dbo.Invoices (
    InvoiceID                 INT IDENTITY(1,1) PRIMARY KEY,
    OrderID                   INT NOT NULL,  -- Relates to the Order in Orders table
    InvoiceReference          NVARCHAR(50) NULL,
    InvoiceDate               DATE NULL,
    InvoiceStatus             NVARCHAR(20) NULL,
    InvoiceHoldReason         NVARCHAR(200) NULL,
    InvoiceAmount             DECIMAL(15,2) NULL,
    InvoiceDescription        NVARCHAR(200) NULL,
    CONSTRAINT FK_Invoices_Orders FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID)
);
GO
