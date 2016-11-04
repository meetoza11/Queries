CREATE VIEW  dbo.vw_Application_status AS
SELECT 1 AS Test


CREATE PROC dbo.pr_ZipCodeToDemoGraphy AS
SELECT 1 AS Test


CREATE TABLE [dbo].[DevenTest] (
    [col1] varchar(10) NOT NULL, 
    [col2] varchar(10) NOT NULL, 
    [col3] varchar(10) NOT NULL, 
    [col4] varchar(10) NOT NULL
)

Insert into dbo.DevenTest
Values ('Hell01', 'Hell02', 'Hell03', 'Hell04')

-- SELECT * INTO dbo.DevenTestBackup from dbo.DevenTest

-- select * from dbo.DevenTest


--- (1) Column/Delete (Drop) – From Table
--- CTAS to _NEW with desired columns only.	
	CREATE Table dbo.DevenTest_NEW with (
	DISTRIBUTION = HASH (col1))
	AS SELECT col1,col2,col3 FROM dbo.DevenTest

--- RENAME existing to YYYYMMDD_HHMM
	RENAME OBJECT [DevenTest] TO [DevenTest20150923_0846] 
		
--- Rename _NEW to Existing.	 
	RENAME OBJECT [DevenTest_NEW] TO [DevenTest] 

	
--- (2) Column/Create (Add) - To Table
--- CTAS to _NEW with desired columns and new columns
	CREATE Table dbo.DevenTest_AddColumn with (
	DISTRIBUTION = HASH (col1))
	AS SELECT *, NULL as col5 FROM dbo.DevenTest

--- RENAME existing to YYYYMMDD_HHMM
	RENAME OBJECT [DevenTest] TO [DevenTest20150923_0859] 

--- Rename _NEW to Existing.	
	RENAME OBJECT [DevenTest_AddColumn] TO [DevenTest] 

--- (3) Column/Rename – 
--- CTAS to _NEW with desired columns and new columns.
	CREATE Table dbo.DevenTest_New with (
	DISTRIBUTION = HASH (col1))
	AS SELECT col1,col2,col3,col5 as col5Renamed FROM dbo.DevenTest

--- RENAME existing to YYYYMMDD_HHMM
	RENAME OBJECT [DevenTest] TO [DevenTest20150923_0905]

--- Rename _NEW to Existing
	RENAME OBJECT [DevenTest_New] TO [DevenTest] 

	


	-- (b) Drop column (following query would come from requester)
	ALTER TABLE dbo.DevenTest
	DROP COLUMN col1


	CREATE Table dbo.DevenTestBackup with (
	[col1] varchar(10) NOT NULL, 
    [col2] varchar(10) NOT NULL, 
    [col3] varchar(10) NOT NULL)
	AS SELECT * FROM dbo.DevenTest


	

--- (3) Rename the column from DevenTest table	
CREATE TABLE [dbo].[DevenTestAnotherBackup] with (    
	[col5] varchar(10) NULL
)
	AS SELECT * FROM dbo.DevenTest
--- Getting following error if distribution is not mentioned in CTAS 
--- 'Distribution' option must be explicitly specified in "CREATE TABLE AS SELECT" statements.
	
	RENAME OBJECT [DevenTest].[col4] TO [Col4New] 
	alter table [DevenTest] 
	rename column [col4], [col4New] varchar(10) -- not working 
	rename object [col4] [col4New] varchar(10) -- not working 

