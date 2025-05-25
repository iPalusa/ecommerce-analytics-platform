#!/bin/bash
export PGPASSWORD=admin@123
export PGCLIENTENCODING=UTF8  # Set client encoding for MINGW64
echo "Checking if database schema exists..."
if ! psql -U postgres -d ecommerce -t -c "SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'customers')"; then
    echo "Setting up database schema..."
    psql -U postgres -d ecommerce -f ../src/database/schema.sql
    echo "Database schema created."
else
    echo "Database schema already exists, skipping creation."
fi
echo "Loading data into database..."
python -c "
import pandas as pd
from sqlalchemy import create_engine
# Load cleaned CSV
df_clean = pd.read_csv(r'../data/processed/cleaned_transactions.csv')
engine = create_engine('postgresql+psycopg2://postgres:admin%40123@localhost:5432/ecommerce')
# Customers table
customers_df = df_clean[['CustomerID', 'Country']].drop_duplicates(subset=['CustomerID'])
customers_df.columns = customers_df.columns.str.lower()
customers_df.to_sql('customers', engine, if_exists='append', index=False)
# Products table
products_df = df_clean[['StockCode', 'Description']].drop_duplicates()
products_df.columns = products_df.columns.str.lower()
products_df.to_sql('products', engine, if_exists='append', index=False)
# Time table
time_df = df_clean[['InvoiceDate']].drop_duplicates()
time_df['Year'] = pd.to_datetime(time_df['InvoiceDate']).dt.year
time_df['Month'] = pd.to_datetime(time_df['InvoiceDate']).dt.month
time_df['Day'] = pd.to_datetime(time_df['InvoiceDate']).dt.day
time_df['Hour'] = pd.to_datetime(time_df['InvoiceDate']).dt.hour
time_df.columns = time_df.columns.str.lower()
time_df.to_sql('time', engine, if_exists='append', index=False)
# Transactions table
transactions_df = df_clean[['InvoiceNo', 'CustomerID', 'StockCode', 'Quantity', 'UnitPrice', 'InvoiceDate', 'TotalSpend']]
transactions_df.columns = transactions_df.columns.str.lower()
transactions_df.to_sql('transactions', engine, if_exists='append', index=False)
print('Database populated.')
"
echo "Data loaded successfully."