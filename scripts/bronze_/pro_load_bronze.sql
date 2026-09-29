/*
==================================================================================
Store Procedure: Load Bronze Layer (source -> Bronze)
==================================================================================
SCRIPT PURPOSE:
		This stored procedure load data into 'Bronze' cahema from externalcsv files.
    It performes the folowing actions:
    * Truncate the bronze table before loading data.
    * Use Bulk insert command to load data from csv files to bronze table .

Parameter:
  None.
  this store procedure does not accept any parameter or return any value.

usage Example: 
	EXEC bronze.load_bronze;
==================================================================================

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @Start_time DATETIME ,@end_time DATETIME;
	BEGIN TRY
		PRINT '===============================================================================';
		PRINT ' Loading Bronze Layer';
		PRINT '===============================================================================';

		SET @Start_time = GETDATE();
		print '>> Truncating Table: bronze.customer_info'
		TRUNCATE TABLE bronze.customer_info;

		print '>> Inserting Table: bronze.customer_info';
		BULK INSERT bronze.customer_info
		FROM 'C:\Users\sanjayprajapati\Downloads\retail_sale DATAWREHOUSE\customer_info.csv'
		WITH (	
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @Start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '>> ---------------------';

		SET @Start_time = GETDATE();
		print '>> Truncating Table: bronze.product_info'
		TRUNCATE TABLE bronze.product_info;

		print '>> Inserting Table: bronze.product_info';
		BULK INSERT bronze.product_info
		FROM 'C:\Users\sanjayprajapati\Downloads\retail_sale DATAWREHOUSE\product_info.csv'
		WITH (	
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @Start_time, @end_time) AS VARCHAR) + 'seconds'
		PRINT '>> ---------------------'

		SET @Start_time = GETDATE();
		print '>> Truncating Table: bronze.sales_info'
		TRUNCATE TABLE bronze.sales_info;

		print '>> Inserting Table: bronze.sales_info';
		BULK INSERT bronze.sales_info
		FROM 'C:\Users\sanjayprajapati\Downloads\retail_sale DATAWREHOUSE\sales_info.csv'
		WITH (	
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @Start_time, @end_time) AS VARCHAR) + 'seconds'
		PRINT '>> ---------------------'

		SET @Start_time = GETDATE();
		print '>> Truncating Table: bronze.stores_info'
		TRUNCATE TABLE bronze.stores_info ;

		print '>> Inserting Table: bronze.stores_info';
		BULK INSERT bronze.stores_info
		FROM 'C:\Users\sanjayprajapati\Downloads\retail_sale DATAWREHOUSE\stores_info.csv'
		WITH (	
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @Start_time, @end_time) AS VARCHAR) + 'seconds'
		PRINT '>> ---------------------'

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
