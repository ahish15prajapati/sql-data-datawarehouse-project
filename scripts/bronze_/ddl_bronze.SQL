/*
====================================================================================================
DDL SCRIPT: CREATE TABLES IN BRONZE LAYER (STORE ROW DATA)
====================================================================================================
SCRIPT PURPOSE :
      TO CREATE TABLES customer table, product table, sales table 
      and stores table in BRONZE LAYER or IN BRONZE SCHEMA.
WARNING: 
      This scrip drop your existing schema table confirmed table name
====================================================================================================
*/

-- CREATE CUSTOMER TABLE IN BRONZE LAYER 
DROP TABLE IF EXISTS  bronze.customer_info;
CREATE TABLE bronze.customer_info (
   customer_id 	VARCHAR(50),
   customer_name NVARCHAR(50),	
   gender VARCHAR(20),
   age INT,
   city	VARCHAR(50),
   state VARCHAR(50),	
   pincode VARCHAR(10),
   phone VARCHAR(20),	
   email VARCHAR(100),	
   registration_date DATE
); 

-- CREATE PRODUCT TABLE IN BRONZE LAYER
DROP TABLE IF EXISTS  bronze.product_info;
CREATE TABLE bronze.product_info (
    product_id VARCHAR(50),
    product_name VARCHAR(50),
    category VARCHAR(50),
    subcategory	VARCHAR(50),
    brand VARCHAR(50),	
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2)
);

-- CREATE SALES TABLE IN BRONZE LAYER
DROP TABLE IF EXISTS  bronze.sales_info;
CREATE TABLE bronze.sales_info (
    sale_id	VARCHAR(50),
    sale_date DATE,
    customer_id	VARCHAR(50),
    product_id	VARCHAR(50),
    store_id VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),	
    payment_method VARCHAR(50)
);


-- CREATE STORES TABLE IN BRONZE LAYER
DROP TABLE IF EXISTS  bronze.stores_info;
CREATE TABLE bronze.stores_info (
    store_id VARCHAR(50),
    store_name	VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),	
    pincode	VARCHAR(10),
    store_type	VARCHAR(50),
    opening_date DATE
);
