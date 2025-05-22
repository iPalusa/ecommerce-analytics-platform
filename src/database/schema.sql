-- Star Schema for E-Commerce Analytics

-- Dimension Table: Customers
CREATE TABLE customers (
    CustomerID INTEGER PRIMARY KEY,
    Country VARCHAR(100) NOT NULL
);

-- Dimension Table: Products
CREATE TABLE products (
    StockCode VARCHAR(50) PRIMARY KEY,
    Description TEXT
);

-- Dimension Table: Time
CREATE TABLE time (
    InvoiceDate TIMESTAMP PRIMARY KEY,
    Year INTEGER NOT NULL,
    Month INTEGER NOT NULL,
    Day INTEGER NOT NULL,
    Hour INTEGER NOT NULL
);

-- Fact Table: Transactions
CREATE TABLE transactions (
    TransactionID SERIAL PRIMARY KEY,
    InvoiceNo VARCHAR(50) NOT NULL,
    CustomerID INTEGER NOT NULL,
    StockCode VARCHAR(50) NOT NULL,
    Quantity INTEGER NOT NULL,
    UnitPrice DOUBLE PRECISION NOT NULL,
    InvoiceDate TIMESTAMP NOT NULL,
    TotalSpend DOUBLE PRECISION NOT NULL,
    CONSTRAINT fk_customer FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
    CONSTRAINT fk_product FOREIGN KEY (StockCode) REFERENCES products(StockCode),
    CONSTRAINT fk_time FOREIGN KEY (InvoiceDate) REFERENCES time(InvoiceDate)
);

-- Indexes for faster queries
CREATE INDEX idx_customerid ON transactions(CustomerID);
CREATE INDEX idx_invoicedate ON transactions(InvoiceDate);