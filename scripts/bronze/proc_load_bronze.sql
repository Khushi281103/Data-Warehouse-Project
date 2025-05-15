/*
=====================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)=====================================================================================
=====================================================================================
Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	It perfoms the follwoing actions:
	- Truncates the bronze tables before loading data.
	- Uses the 'BULK INSERT' command to load data from csvFiles to broz tables.

Paramters:
	None.
	This stored procedure does not accept any parameters or return any values.
Usage Example:
	EXEC bronze.load_bronze;
=====================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		print '=================================================================';
		print 'Loading Bronze Layer';
		print '=================================================================';

		print '-----------------------------------------------------------------';
		print 'Loading CRM Tables';
		print '-----------------------------------------------------------------';

		SET @start_time = GETDATE();
		print '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		print '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\bhavs\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>----------------'

		SET @start_time = GETDATE();
		print '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		print '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\bhavs\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>----------------'

		SET @start_time = GETDATE();
		print '>> Truncating Table: bronze.sales_details';
		TRUNCATE TABLE bronze.sales_details;

		print '>> Inserting Data Into: bronze.sales_details';
		BULK INSERT bronze.sales_details
		FROM 'C:\Users\bhavs\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>----------------'

		print '-----------------------------------------------------------------';
		print 'Loading ERP Tables';
		print '-----------------------------------------------------------------';

		SET @start_time = GETDATE();
		print '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		print '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\bhavs\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>----------------'

		SET @start_time = GETDATE();
		print '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		print '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\bhavs\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>----------------'

		SET @start_time = GETDATE();
		print '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		print '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\bhavs\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		print '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>----------------'

		SET @batch_end_time = GETDATE();
		print '=================================================================';
		print 'Loading Bronze Layer is Completed';
		print '  - Total Load Duration: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
		print '=================================================================';
	END TRY
	BEGIN CATCH
		print '=================================================================';
		print 'ERROR OCCURED DUNG LOADING BRONZE LAYER';
		print 'Error Message' + ERROR_MESSAGE();
		print 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		print 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		print '=================================================================';
	END CATCH
END
