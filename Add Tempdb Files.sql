USE MASTER
GO

-- Step 01 Modify size of first data file already at the right place
ALTER DATABASE TEMPDB 
MODIFY FILE
(
NAME		=TEMPDEV,
SIZE 		= 1024MB,
MAXSIZE 	= 1024MB,
FILEGROWTH 	= 1024MB
)
GO

-- Step 02 Modify size of the log file already in the right place
ALTER DATABASE TEMPDB 
MODIFY FILE
(
NAME		=TEMPLOG,
SIZE 		= 1024MB,
MAXSIZE 	= 1024MB,
FILEGROWTH 	= 1024MB
)
GO

-- Step03, Step04,... add Tempfile tempdev<nn> with nn = 02, 03 etc.
ALTER DATABASE TEMPDB
MODIFY FILE 
(
NAME 	= TEMPDEV_##,
FILENAME	= '< path > \TEMPDB_##.NDF',
SIZE		= 1024MB,
MAXSIZE	= 1024MB,
FILEGROWTH = 1024MB
)
GO
