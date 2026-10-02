/*
==================================================================================
Store Procedure: Load Silver Layer (Bronze -> silver)
==================================================================================
SCRIPT PURPOSE:
		This stored procedure performs the ETL (Extract, Transform, Load) process topopulate the 'silver' schema table  from bronze schema.
    It performes the folowing actions:
    * Truncate the silver table before loading data.
    * Inserts transformed and cleansed data from bronze table to silver table .

Parameter:
  None.
  this store procedure does not accept any parameter or return any value.

usage Example: 
	EXEC silver.load_silver;
==================================================================================

*/

CREATE OR ALTER PROCEDURE silver.load_silver AS 
BEGIN
	BEGIN TRY
		DECLARE @start_time DATETIME
		DECLARE @end_time DATETIME

		PRINT '=======================================================';
		PRINT 'Loading Silver Layer ';
		PRINT '=======================================================';

		PRINT'==========================================';
		PRINT '>> Truncating table silver.customer_info';
		PRINT'==========================================';
		TRUNCATE TABLE silver.customer_info
		SET @start_time = GETDATE();

		PRINT '>>Inserting Into silver.customer_info';

		INSERT INTO silver.customer_info (
			customer_id,
			customer_name,
			gender,
			age,
			city,
			state,
			pincode,
			phone,
			email,
			registration_date)

		SELECT 
		customer_id,
		TRIM(customer_name) customer_name,
			CASE UPPER(TRIM(gender))
				WHEN 'M' THEN 'Male'
				WHEN 'F' THEN 'Female'
				ELSE 'N/A'
			END AS gender,
		age,
			CASE TRIM(city) 
				WHEN 'Aurangabad' THEN 'Chhatrapati sambhajinagar'
				WHEN 'Gurgaon' THEN 'Gurugram'
				WHEN 'Mangalore' THEN 'Mangaluru'
				WHEN 'Mysore' THEN 'Mysuru'
				ELSE TRIM(city)
			END AS city,
		CASE 
			WHEN UPPER(TRIM(state)) IN  ('ANDHRA PRADESH', 'AP') THEN 'Andhra Pradesh'
			WHEN UPPER(TRIM(state)) IN ('BIHAR', 'BR') THEN 'Bihar'
			WHEN UPPER(TRIM(state)) IN ('CHANDIGARH', 'CH') THEN 'Chandigarh'
			WHEN UPPER(TRIM(state)) IN ('DELHI', 'DL') THEN 'Delhi'
			WHEN UPPER(TRIM(state)) IN ('GUJARAT', 'GJ') THEN 'Gujarat'
			WHEN UPPER(TRIM(state)) IN ('HARYANA', 'HR') THEN 'Haryana'
			WHEN UPPER(TRIM(state)) IN ('HIMACHAL PRADESH', 'HP') THEN 'Himachal Pradesh'
			WHEN UPPER(TRIM(state)) IN ('JHARKHAND', 'JH') THEN 'Jharkhand'
			WHEN UPPER(TRIM(state)) IN ('KARNATAKA', 'KA') THEN 'Karnataka'
			WHEN UPPER(TRIM(state)) IN ('KERALA', 'KL') THEN 'Kerala'
			WHEN UPPER(TRIM(state)) IN ('MADHYA PRADESH', 'MP') THEN 'Madhya Pradesh'
			WHEN UPPER(TRIM(state)) IN ('MAHARASHTRA', 'MH') THEN 'Maharashtra'
			WHEN UPPER(TRIM(state)) IN ('ODISHA', 'OD') THEN 'Odisha'
			WHEN UPPER(TRIM(state)) IN ('PUNJAB', 'PB') THEN 'Punjab'
			WHEN UPPER(TRIM(state)) IN ('RAJASTHAN', 'RJ') THEN 'Rajasthan'
			WHEN UPPER(TRIM(state)) IN ('TAMIL NADU', 'TN') THEN 'Tamil Nadu'
			WHEN UPPER(TRIM(state)) IN ('TELANGANA', 'TG') THEN 'Telangana'
			WHEN UPPER(TRIM(state)) IN ('UTTAR PRADESH', 'UP') THEN 'Uttar Pradesh'
			WHEN UPPER(TRIM(state)) IN ('UTTARAKHAND', 'UK') THEN 'Uttarakhand'
			WHEN UPPER(TRIM(state)) IN ('WEST BENGAL', 'WB') THEN 'West Bengal'
			ELSE TRIM(state)
		END AS state,
		pincode,
		ISNULL(TRIM(phone), 'N/A') AS phone,
		CASE 
			WHEN UPPER(TRIM(email)) IS NULL THEN 'N/A'  
			ELSE LOWER(TRIM(email)) 
		END AS email,
		registration_date
		FROM bronze.customer_info

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @Start_time, @end_time) AS VARCHAR) + 'seconds'

		SET @start_time = GETDATE();
		PRINT '==========================================';
		PRINT '>> Truncating table silver.product_info';
		TRUNCATE TABLE silver.product_info
		
		PRINT '>> Inserting Into silver.product_info';
		INSERT INTO silver.product_info (
			product_id,
			product_name,
			category,
			subcategory,
			brand,
			unit_price,
			cost_price)

			SELECT 
			product_id,
			TRIM(product_name) product_name,
			CASE UPPER(TRIM(category))
				WHEN 'ACCESSORIES' THEN 'Accessories'
				WHEN 'APPLIANCES' THEN 'Appliances'
				WHEN 'BAGS' THEN 'Bags'
				WHEN 'BEAUTY' THEN 'Beauty'
				WHEN 'ELECTRONICS' THEN 'Electronics'
				WHEN 'FASHION' THEN 'Fashion'
				WHEN 'FOOTWEAR' THEN 'Footwear'
				WHEN 'GROCERY' THEN 'Grocery'
				WHEN 'HOME & FURNITURE' THEN 'Home & Furniture'
				WHEN 'HOME & KITCHEN' THEN 'Home & Kitchen'
				WHEN 'PERSONAL CARE' THEN 'Personal Care'
				WHEN 'STATIONERY' THEN 'Stationery'
				ELSE 'n/a'
			END AS category,
			subcategory,
			TRIM(brand), 
			unit_price,
			cost_price 
		FROM bronze.product_info

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @Start_time, @end_time) AS VARCHAR) + 'seconds'

		SET @start_time = GETDATE();
		PRINT'===========================';
		PRINT 'TRUNCATE TABLE silver.stores_info';
		
		PRINT '>> Inserting Into silver.stores_info';
		INSERT INTO silver.stores_info (
			store_id,
			store_name,
			city,
			state,
			pincode,
			store_type,
			opening_date)

		SELECT 
		store_id,
		TRIM(store_name) AS store_name,
		CASE UPPER(TRIM(city))
			WHEN 'BANGALORE' THEN 'Bengaluru'
			WHEN 'GURGAON' THEN 'Gurugram'
			WHEN 'MYSORE' THEN 'Mysuru'
			ELSE TRIM(city)
		END AS city,
		CASE UPPER(TRIM(state))
			WHEN 'MAHARASHTRA' THEN 'Maharashtra' 
			WHEN 'GUJARAT' THEN 'Gujarat'
			WHEN 'KARNATAKA' THEN 'Karnataka'
			WHEN 'TAMIL NADU' THEN 'Tamil Nadu'
			ELSE TRIM(state)
		END AS state,
		TRIM(pincode) AS pincode,
		TRIM(store_type) AS store_type,
		opening_date
		FROM bronze.stores_info

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @Start_time, @end_time) AS VARCHAR) + 'seconds'

		SET @start_time = GETDATE();
		PRINT '=================================';
		PRINT 'TRUNCATE TABLE silver.sales_info';
		TRUNCATE TABLE silver.sales_info
		
		PRINT '>> Inserting Into silver.sales_info';
		INSERT INTO silver.sales_info (
			sale_id,
			sale_date,
			customer_id,
			product_id,
			store_id,
			quantity,
			unit_price,
			discount_percent,
			payment_method)

		SELECT 
		sale_id,
		sale_date,
		customer_id,
		product_id,
		store_id,
		quantity,
		unit_price,
		discount_percent,
		CASE UPPEr(TRIM(payment_method))
			WHEN 'UPI' THEN 'UPI'
			WHEN 'Credit Card' THEN 'Credit Card'
			WHEN 'Debit Card' THEN 'Debit Card'
			WHEN 'Cash' THEN 'Cash'
		END AS payment_method
		FROM bronze.sales_info
		SET @start_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @Start_time, @end_time) AS VARCHAR) + 'seconds'

	END TRY
	BEGIN CATCH
		PRINT '========================================'
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS VARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS VARCHAR);
		PRINT '========================================'
	END CATCH 
END
