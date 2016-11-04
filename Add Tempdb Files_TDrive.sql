USE MASTER
GO

-- Step 01 Modify size of first data file already at the right place
ALTER DATABASE TEMPDB 
MODIFY FILE
(
NAME		=TEMPDEV,
SIZE 		= 2048MB,
FILEGROWTH 	= 1024MB
)
GO

-- Step 02 Modify size of the log file already in the right place
ALTER DATABASE TEMPDB 
MODIFY FILE
(
NAME		=TEMPLOG,
SIZE 		= 2048MB,
FILEGROWTH 	= 1024MB
)
GO

-- Step03, Step04,... add Tempfile tempdev<nn> with nn = 02, 03 etc.
ALTER DATABASE TEMPDB
add FILE 
(
NAME 	= TEMPDEV_2,
FILENAME	= 'T:\MSSQLDATA\11.0\System\tempdb_2.mdf',
SIZE 		= 2048MB,
FILEGROWTH 	= 1024MB
)
GO
-- Step03, Step04,... add Tempfile tempdev<nn> with nn = 02, 03 etc.
ALTER DATABASE TEMPDB
add FILE 
(
NAME 	= TEMPDEV_3,
FILENAME	= 'T:\MSSQLDATA\11.0\System\tempdb_3.mdf',
SIZE 		= 2048MB,
FILEGROWTH 	= 1024MB
)
GO
ALTER DATABASE TEMPDB
add FILE 
(
NAME 	= TEMPDEV_4,
FILENAME	= 'T:\MSSQLDATA\11.0\System\tempdb_4.mdf',
SIZE 		= 2048MB,
FILEGROWTH 	= 1024MB
)
GO