-- (step 1)
USE WellHealth_Integration
GO
sp_helpfile
GO

-- this is how it was before move
--name					fileid		filename												filegroup	size			maxsize			growth		usage
--GMTIntegration_Data	1			H:\MSSQLDATA\10.5\database\WellHealth_Integration.mdf	PRIMARY		358400000 KB	367001600 KB	1048576 KB	data only
--GMTIntegration_Log	2			J:\MSSQLDATA\10.5\database\WellHealth_Integration.ldf	NULL		19087360 KB		2068226048 KB	524288 KB	log only
--GMTIntegration_Data2	3			Y:\MSSQLDATA\10.5\Database\WellHealth_Integration2.ndf	PRIMARY		209715200 KB	Unlimited		524288 KB	data only

-- (step 2)
USE master
GO
ALTER DATABASE WellHealth_Integration
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO
ALTER DATABASE WellHealth_Integration
SET READ_ONLY
GO
ALTER DATABASE WellHealth_Integration
SET MULTI_USER;
GO

-- step 3
sp_detach_db 'WellHealth_Integration'
GO

-- (step 4)
--copy WellHealth_Integration log file from J:\MSSQLDATA\10.5\Database location to T:\MSSQLDATA\10.5\Database location 

-- (step 5)
USE master
GO
-- Now Attach the database
sp_attach_DB 'WellHealth_Integration', 
'H:\MSSQLDATA\10.5\database\WellHealth_Integration.mdf',
'Y:\MSSQLDATA\10.5\Database\WellHealth_Integration2.ndf',
'J:\MSSQLDATA\10.5\database\WellHealth_Integration.ldf'
GO

-- (step 5) verify the move has done properly
USE WellHealth_Integration
GO
sp_helpfile
GO

-- paste the result from above query