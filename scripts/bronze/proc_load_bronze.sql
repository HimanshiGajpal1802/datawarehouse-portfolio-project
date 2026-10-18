/* Script Purpose - this stored procedure loads data into bronze schema from external CSV files.
it performs the following actions:
 1. truncate the bronze tables before loading the data.
 2. Uses the "BULK INSERT" Command to load the Data from CSV Files to Bronze tables.

Parameters -
None 
this stired procedure does not take any parameters or return any values.

Usage Example -
EXEC bronze.load_bronze; */

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
	    SET @batch_start_time = GETDATE();
		PRINT '============================================================'
		PRINT 'Loading Bronze Layer'
		PRINT '============================================================'
		PRINT'-------------------------------------------------------------'
		PRINT'Loading CRM tables'
		PRINT'-------------------------------------------------------------'

		SET @start_time = GETDATE();
		PRINT'>> Truncating bronze.crm_cust_info Table'
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT'>> Inserting Data Into bronze.crm_cust_info Table'
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\himan\OneDrive\Desktop\SQL Databases\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		   FIRSTROW = 2,
		   FIELDTERMINATOR =',',
		   TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + 'seconds';
		PRINT'**********************************'


		SET @start_time = GETDATE();
		PRINT'>> Truncating bronze.crm_prd_info Table'
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT'>> Inserting Data Into bronze.crm_prd_info Table'
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\himan\OneDrive\Desktop\SQL Databases\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		   FIRSTROW = 2,
		   FIELDTERMINATOR =',',
		   TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + 'seconds';
		PRINT'**********************************'

		SET @start_time = GETDATE();
		PRINT'>> Truncating bronze.crm_sales_details Table'
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT'>> Inserting Data Into bronze.crm_sales_details Table'
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\himan\OneDrive\Desktop\SQL Databases\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		   FIRSTROW = 2,
		   FIELDTERMINATOR =',',
		   TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + 'seconds';
		PRINT'**********************************'



		PRINT'---------------------------------------------------------'
		PRINT'Loading ERP Tables'
		PRINT'---------------------------------------------------------'
		SET @start_time = GETDATE();
		PRINT'>> Truncating bronze.erp_cust_az12 Table'
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT'>> Inserting Data Into bronze.erp_cust_az12 Table'
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\himan\OneDrive\Desktop\SQL Databases\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		   FIRSTROW = 2,
		   FIELDTERMINATOR =',',
		   TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + 'seconds';
		PRINT'**********************************'


		SET @start_time = GETDATE();
		PRINT'>> Truncating bronze.erp_loc_a101 Table'
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT'>> Inserting Data Into bronze.erp_loc_a101 Table'
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\himan\OneDrive\Desktop\SQL Databases\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		   FIRSTROW = 2,
		   FIELDTERMINATOR =',',
		   TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + 'seconds';
		PRINT'**********************************'


		SET @start_time = GETDATE();
		PRINT'>> Truncating bronze.erp_px_cat_g1v2 Table'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT'>> Inserting Data Into bronze.erp_px_cat_g1v2 Table'
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\himan\OneDrive\Desktop\SQL Databases\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		   FIRSTROW = 2,
		   FIELDTERMINATOR =',',
		   TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(50)) + 'seconds';
		PRINT'**********************************'

	    SET @batch_end_time = GETDATE();
		PRINT'Loading Bronze layer is completed'
	    PRINT'>> Total duration of Bronze layer: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR(50)) + 'seconds';
	    PRINT'**********************************'

	END TRY
	BEGIN CATCH
	END CATCH
END
