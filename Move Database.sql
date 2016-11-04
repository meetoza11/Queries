USE MASTER;
GO
-- Take database in single user mode -- if you are facing errors
-- This may terminate your active transactions for database
ALTER DATABASE wellHealth_2_UAT
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO
-- Detach DB
EXEC MASTER.dbo.sp_detach_db @dbname = N'wellHealth_2_UAT'
GO



ALTER DATABASE wellhealth_2_UAT SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
ALTER DATABASE wellhealth_2_UAT SET OFFLINE;

ALTER DATABASE [wellHealth_2_UAT] MODIFY FILE
(
	Name = wellhealth_2_UAT,
	Filename = 'Z:\MSSQLDATA\Database\wellhealth_2_UAT.mdf'
);
	
ALTER DATABASE [wellHealth_2_UAT] MODIFY FILE
(
	Name = wellhealth_2_UAT_1,
	Filename = 'K:\MSSQLDATA\Database\wellhealth_2_UAT_1.ldf'
);

ALTER DATABASE wellHealth_2_UAT SET ONLINE;
ALTER DATABASE wellHealth_2_UAT SET MULTI_USER;
