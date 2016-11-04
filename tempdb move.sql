--USE tempdb
--Go
--EXEC sp_helpfile
--GO

USE master
GO
ALTER Database TempDB Modify File
(Name = tempdev, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdb.mdf')
GO

ALTER Database TempDB Modify File
(Name = tempdev2, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev2.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev3, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev3.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev4, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev4.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev5, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev5.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev6, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev6.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev7, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev7.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev8, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev8.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev9, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev9.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev10, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev10.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev11, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev11.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev12, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev12.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev13, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev13.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev14, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev14.ndf')
GO

ALTER Database TempDB Modify File
(Name = tempdev15, FILENAME = 'x:\MSSQLDATA\10.5\System\tempdev15.ndf')
GO

ALTER Database TempDB Modify File
(Name = templog, FILENAME = 'x:\MSSQLDATA\10.5\System\templog.ldf')
GO

-----------------------------------------------------
/*

USE [tempdb]
GO
DBCC SHRINKFILE (N'templog2' , EMPTYFILE)
GO

USE [tempdb]
GO
ALTER DATABASE [tempdb]  REMOVE FILE [templog2]
GO


*/
