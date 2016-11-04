select @@servername
GO

sp_spaceused [BlueStem.DailyPortfolio]
GO

sp_spaceused [BlueStem.DailyPortfolioNonSCUSA]
GO

-- dba is NOT yet converted to varchar(25)
-- dev1 is converted to varchar(25)
-- lod is NOT yet converted to varchar(25)
-- tst1 is converted to varchar(25)
-- UAT is converted but we can drop the newly created table and run the script again


SELECT DB_NAME() AS DbName, 
name AS FileName, 
size/128.0 AS CurrentSizeMB,  
size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)/128.0 AS FreeSpaceMB 
FROM sys.database_files; 

