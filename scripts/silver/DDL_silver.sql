/*
====================================================================================================
DDL SCRIPT: CREATE TABLES IN SILVER LAYER (STORE  DATA)
====================================================================================================
SCRIPT PURPOSE :
      TO CREATE TABLES customer table, product table, sales table 
      and stores table in SILVER LAYER or IN SILVER SCHEMA.
WARNING: 
      This scrip drop your existing schema table confirmed table name
====================================================================================================
*/

-- CREATE CUSTOMER TABLE IN SILVER LAYER 
DROP TABLE IF EXISTS  silver.customer_info;
CREATE TABLE silver.customer_info (
   customer_id 	VARCHAR(50),
   customer_name NVARCHAR(50),	
   gender VARCHAR(20),
   age INT,
   city	VARCHAR(50),
   state VARCHAR(50),	
   pincode VARCHAR(10),
   phone VARCHAR(20),	
   email VARCHAR(100),	
   registration_date DATE,
   dwh_create_date DATETIME2 DEFAULT GETDATE()
); 

-- CREATE PRODUCT TABLE IN SILVER LAYER
DROP TABLE IF EXISTS  silver.product_info;
CREATE TABLE silver.product_info (
    product_id VARCHAR(50),
    product_name VARCHAR(50),
    category VARCHAR(50),
    subcategory	VARCHAR(50),
    brand VARCHAR(50),	
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- CREATE SALES TABLE IN SILVER LAYER
DROP TABLE IF EXISTS  silver.sales_info;
CREATE TABLE silver.sales_info (
    sale_id	VARCHAR(50),
    sale_date DATE,
    customer_id	VARCHAR(50),
    product_id	VARCHAR(50),
    store_id VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),	
    payment_method VARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);


-- CREATE STORES TABLE IN SILVER LAYER
DROP TABLE IF EXISTS  silver.stores_info;
CREATE TABLE silver.stores_info (
    store_id VARCHAR(50),
    store_name	VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),	
    pincode	VARCHAR(10),
    store_type	VARCHAR(50),
    opening_date DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);


