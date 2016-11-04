--===============================
-- Create a new table and add keys and constraints
--===============================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TableName' AND TABLE_SCHEMA='dbo')
BEGIN
    CREATE TABLE [dbo].[TableName] 
    (
        [ColumnName1] INT NOT NULL, -- To have a field auto-increment add IDENTITY(1,1)
        [ColumnName2] INT NULL,
        [ColumnName3] VARCHAR(30) NOT NULL DEFAULT('')
    )
 
    -- Add the table's primary key
    ALTER TABLE [dbo].[TableName] ADD CONSTRAINT [PK_TableName] PRIMARY KEY NONCLUSTERED
    (
        [ColumnName1], 
        [ColumnName2]
    )
     
    -- Add a foreign key constraint
    ALTER TABLE [dbo].[TableName] WITH CHECK ADD CONSTRAINT [FK_Name] FOREIGN KEY
    (
        [ColumnName1], 
        [ColumnName2]
    )
    REFERENCES [dbo].[Table2Name] 
    (
        [OtherColumnName1], 
        [OtherColumnName2]
    )
     
    -- Add indexes on columns that are often used for retrieval
    CREATE INDEX IN_ColumnNames ON [dbo].[TableName]
    (
        [ColumnName2],
        [ColumnName3]
    )
     
    -- Add a check constraint
    ALTER TABLE [dbo].[TableName] WITH CHECK ADD CONSTRAINT [CH_Name] CHECK (([ColumnName] >= 0.0000))
END
 
--===============================
-- Add a new column to an existing table
--===============================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA='dbo'
    AND TABLE_NAME = 'TableName' AND COLUMN_NAME = 'ColumnName')
BEGIN
    ALTER TABLE [dbo].[TableName] ADD [ColumnName] INT NOT NULL DEFAULT(0)
     
    -- Add a description extended property to the column to specify what its purpose is.
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
        @value = N'Add column comments here, describing what this column is for.' , 
        @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
        @level1name = N'TableName', @level2type=N'COLUMN',
        @level2name = N'ColumnName'
END
 
--===============================
-- Drop a table
--===============================
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TableName' AND TABLE_SCHEMA='dbo')
BEGIN
    EXEC('DROP TABLE [dbo].[TableName]')
END
 
--===============================
-- Drop a view
--===============================
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'ViewName' AND TABLE_SCHEMA='dbo')
BEGIN
    EXEC('DROP VIEW [dbo].[ViewName]')
END
 
--===============================
-- Drop a column
--===============================
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA='dbo'
    AND TABLE_NAME = 'TableName' AND COLUMN_NAME = 'ColumnName')
BEGIN
 
    -- If the column has an extended property, drop it first.
    IF EXISTS (SELECT * FROM sys.fn_listExtendedProperty(N'MS_Description', N'SCHEMA', N'dbo', N'Table',
                N'TableName', N'COLUMN', N'ColumnName'))
    BEGIN
        EXEC sys.sp_dropextendedproperty @name=N'MS_Description', 
            @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',
            @level1name = N'TableName', @level2type=N'COLUMN',
            @level2name = N'ColumnName'
    END
 
    EXEC('ALTER TABLE [dbo].[TableName] DROP COLUMN [ColumnName]')
END
 
--===============================
-- Drop Primary key constraint
--===============================
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE='PRIMARY KEY' AND TABLE_SCHEMA='dbo'
        AND TABLE_NAME = 'TableName' AND CONSTRAINT_NAME = 'PK_Name')
BEGIN
    EXEC('ALTER TABLE [dbo].[TableName] DROP CONSTRAINT [PK_Name]')
END
 
--===============================
-- Drop Foreign key constraint
--===============================
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE='FOREIGN KEY' AND TABLE_SCHEMA='dbo'
        AND TABLE_NAME = 'TableName' AND CONSTRAINT_NAME = 'FK_Name')
BEGIN
    EXEC('ALTER TABLE [dbo].[TableName] DROP CONSTRAINT [FK_Name]')
END
 
--===============================
-- Drop Unique key constraint
--===============================
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE='UNIQUE' AND TABLE_SCHEMA='dbo'
        AND TABLE_NAME = 'TableName' AND CONSTRAINT_NAME = 'UNI_Name')
BEGIN
    EXEC('ALTER TABLE [dbo].[TableNames] DROP CONSTRAINT [UNI_Name]')
END
 
--===============================
-- Drop Check constraint
--===============================
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE='CHECK' AND TABLE_SCHEMA='dbo'
        AND TABLE_NAME = 'TableName' AND CONSTRAINT_NAME = 'CH_Name')
BEGIN
    EXEC('ALTER TABLE [dbo].[TableName] DROP CONSTRAINT [CH_Name]')
END
 
--===============================
-- Drop a column's Default value constraint
--===============================
DECLARE @ConstraintName VARCHAR(100)
SET @ConstraintName = (SELECT TOP 1 s.name FROM sys.sysobjects s JOIN sys.syscolumns c ON s.parent_obj=c.id
                        WHERE s.xtype='d' AND c.cdefault=s.id 
                        AND parent_obj = OBJECT_ID('TableName') AND c.name ='ColumnName')
 
IF @ConstraintName IS NOT NULL
BEGIN
    EXEC('ALTER TABLE [dbo].[TableName] DROP CONSTRAINT ' + @ConstraintName)
END
 
--===============================
-- Example of how to drop dynamically named Unique constraint
--===============================
DECLARE @ConstraintName VARCHAR(100)
SET @ConstraintName = (SELECT TOP 1 CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
                        WHERE CONSTRAINT_TYPE='UNIQUE' AND TABLE_SCHEMA='dbo'
                        AND TABLE_NAME = 'TableName' AND CONSTRAINT_NAME LIKE 'FirstPartOfConstraintName%')
 
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE='UNIQUE' AND TABLE_SCHEMA='dbo'
        AND TABLE_NAME = 'TableName' AND CONSTRAINT_NAME = @ConstraintName)
BEGIN
    EXEC('ALTER TABLE [dbo].[TableName] DROP CONSTRAINT ' + @ConstraintName)
END
 
--===============================
-- Check for and drop a temp table
--===============================
IF OBJECT_ID('tempdb..#TableName') IS NOT NULL DROP TABLE #TableName
 
--===============================
-- Drop a stored procedure
--===============================
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE='PROCEDURE' AND ROUTINE_SCHEMA='dbo' AND
        ROUTINE_NAME = 'StoredProcedureName')
BEGIN
    EXEC('DROP PROCEDURE [dbo].[StoredProcedureName]')
END
 
--===============================
-- Drop a UDF
--===============================
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE='FUNCTION' AND ROUTINE_SCHEMA='dbo' AND
        ROUTINE_NAME = 'UDFName')
BEGIN
    EXEC('DROP FUNCTION [dbo].[UDFName]')
END
 
--===============================
-- Drop an Index
--===============================
IF EXISTS (SELECT * FROM SYS.INDEXES WHERE name = 'IndexName')
BEGIN
    EXEC('DROP INDEX TableName.IndexName')
END
 
--===============================
-- Drop a Schema
--===============================
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'SchemaName')
BEGIN
    EXEC('DROP SCHEMA SchemaName')
END
 
--===============================
-- Drop a Trigger
--===============================
IF EXISTS (SELECT * FROM SYS.TRIGGERS WHERE NAME = 'TriggerName')
BEGIN
    EXEC('DROP TRIGGER TriggerName')
END