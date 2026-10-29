/*
=================================================================================
DDL Scrpt: Create Gold Views
=================================================================================
Script purpose: 
	this script createview for gold layer in the data warehouse.
	The Gold layer represents the final dimension and fact table (Star Schema)

	each view performs transformations and combine data from Silver layer 
	to produce a clean, and business-ready dataset.

Usage:
	These views can be queried directlyfor analytic and reporting.
=================================================================================
*/

-- ==============================================================================
-- Create Dimension: gold dim_customer
-- ==============================================================================
IF OBJECT_ID('gold.dim_customer', 'v') IS NOT NULL
	DROP VIEW gold.dim_customer;
GO

CREATE VIEW gold.dim_customer AS 
	SELECT 
	ROW_NUMBER() OVER(ORDER BY customer_id) customer_key,
	customer_id,
	customer_name,
	age,
	city,
	state,
	pincode,
	phone,
	email,
	registration_date
	FROM silver.customer_info

-- ==============================================================================
-- Create Dimension: gold dim_customer
-- ==============================================================================
IF OBJECT_ID('gold.dim_product', 'v') IS NOT NULL
	DROP VIEW gold.dim_product;
GO

CREATE VIEW gold.dim_product AS 
	SELECT 
	ROW_NUMBER() OVER(ORDER BY product_id) product_key,
	product_id,
	product_name,
    category,
	subcategory,
	brand,
	unit_price,
	cost_price
	FROM silver.product_info

-- ==============================================================================
-- Create Dimension: gold.dim_store 
-- ==============================================================================
IF OBJECT_ID('gold.dim_store', 'v') IS NOT NULL
	DROP VIEW gold.dim_store;
GO

CREATE VIEW gold.dim_store AS
	SELECT 
	ROW_NUMBER() OVER(ORDER BY store_id) store_key,
	store_id,
	store_type,
	store_name,
	city,
	state,
	pincode,
	opening_date
	FROM silver.stores_info

-- ==============================================================================
-- Create Dimension: gold.dim_store 
-- ==============================================================================
IF OBJECT_ID('gold.fact_sales', 'v') IS NOT NULL
	DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
	SELECT
	sl.sale_id,
	cu.customer_key,
	pu.product_key,
	st.store_key,
	sl.sale_date,
	sl.payment_method,
	sl.quantity,
	sl.unit_price,
	sl.discount_percent
	FROM silver.sales_info sl
	LEFT JOIN gold.dim_customer cu
	ON  sl.customer_id = cu.customer_id 
	LEFT JOIN gold.dim_product pu
	ON  sl.product_id = pu.product_id
	LEFT JOIN gold.dim_store st
	ON  sl.store_id = st.store_id
