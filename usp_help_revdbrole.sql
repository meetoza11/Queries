USE [xadmindb]
GO

/****** Object:  StoredProcedure [dbo].[usp_help_revdbrole]    Script Date: 02/05/2013 09:58:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[usp_help_revdbrole]
	@login_name varchar(100) = NULL
AS
BEGIN
	SET NOCOUNT ON 
	
	DECLARE @login_sid varbinary(85)
	DECLARE @login varchar(100)
	IF (@login_name IS NULL)
	BEGIN
		DECLARE login_curs CURSOR FOR
		select sid,name from sys.server_principals where type IN ('G','U','S') and name <> 'sa'
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = @login_name AND type IN ('G','U','S'))
		BEGIN 
				  PRINT 'Invalid login ' + @login_name + 'Please input valid login name'
				  RETURN
		END
		
		DECLARE login_curs CURSOR FOR
		select sid,name from sys.server_principals where type IN ('G','U','S') and name <> 'sa' and name = @login_name
	END

	OPEN login_curs
	FETCH NEXT FROM login_curs INTO @login_sid,@login
	
	WHILE (@@FETCH_STATUS != -1)
	BEGIN 
	
		DECLARE @maxid int
		IF OBJECT_ID('tempdb..#db_users') is not null
		DROP TABLE #db_users 
		SELECT id = identity(int,1,1), sql_cmd = 'SELECT '''+name+''', * FROM ['+name+'].sys.database_principals' INTO #db_users FROM sys.sysdatabases 
		SET @maxid = @@ROWCOUNT
		 
		---------------------------------------------------
		--Find out list of db that the login has access to 
		---------------------------------------------------
		 
		IF OBJECT_ID('tempdb..#alldb_users') is not null
		DROP TABLE #alldb_users 
		 
		CREATE TABLE #alldb_users(
				  [dbname] [sysname] NOT NULL,
				  [name] [sysname] NOT NULL,
				  [principal_id] [int] NOT NULL,
				  [type] [char](1) NOT NULL,
				  [type_desc] [nvarchar](60) NULL,
				  [default_schema_name] [sysname] NULL,
				  [create_date] [datetime] NOT NULL,
				  [modify_date] [datetime] NOT NULL,
				  [owning_principal_id] [int] NULL,
				  [sid] [varbinary](85) NULL,
				  [is_fixed_role] [bit] NOT NULL
		) 
		 
		DECLARE @id int, @sqlcmd varchar(500)
		SET @id = 1 
		WHILE @id <=@maxid
		BEGIN 
				  SELECT @sqlcmd = sql_cmd FROM #db_users WHERE id = @id 
				  INSERT INTO #alldb_users EXEC (@sqlcmd)
				  SET @id = @id + 1 
		END
		 
		DELETE FROM #alldb_users WHERE sid is null 
		DELETE FROM #alldb_users WHERE sid <> @login_sid
		 
		--SELECT * FROM #alldb_users
		----------------------------------------------
		--granting database role to login 
		----------------------------------------------
		PRINT ''
		PRINT '----------------------------------------------'
		PRINT '--Grant database role to login ' + @login
		PRINT '----------------------------------------------'
		 
		 
		IF OBJECT_ID('tempdb..#dbrole') is not null
		DROP TABLE #dbrole
		 
		create table #dbrole (dbname varchar(100), dbrole varchar (100), dbrole_member varchar(100), 
			sid varbinary(85), default_schema_name varchar(100), login_name varchar(100), db_principal_id int)
		DECLARE @dbrole_sqlcmd varchar(max)
		SET @dbrole_sqlcmd = ''
		SELECT @dbrole_sqlcmd = @dbrole_sqlcmd + 
			'SELECT '''+dbname+''', c.name, b.name, b.sid, b.default_schema_name, d.name, b.principal_id as login_name 
		from ['+dbname+'].sys.database_role_members a 
		inner join ['+dbname+'].sys.database_principals b on a.member_principal_id = b.principal_id
		inner join ['+dbname+'].sys.database_principals c on a.role_principal_id = c.principal_id
		left join sys.server_principals d on b.sid = d.sid
		'
		from #alldb_users 
		--SELECT @dbrole_sqlcmd
		--PRINT @dbrole_sqlcmd
		INSERT INTO #dbrole exec(@dbrole_sqlcmd)
		--SELECT * FROM #dbrole
		 
		DELETE FROM #dbrole WHERE sid <> @login_sid
		 
		ALTER TABLE #dbrole ADD ID INT identity(1,1)
		 
		DECLARE @counter int, @maxid2 int, @login_dbrole varchar(max) 
		SELECT @maxid2 = MAX(ID) FROM #dbrole
		SET @counter = 1
		 
		--SELECT * FROM #dbrole 
		 
		IF NOT EXISTS (SELECT * FROM #dbrole )
		BEGIN 
				  PRINT '--Login ['+@login+'] is not a member of any database level role'
				  --return 
		END
		
		declare @dbname varchar(100) 
		declare @dbrole_member varchar(100) 
		declare @dbrole varchar(100) 
		declare @loginname varchar(100) 
		declare @default_schema_name varchar(100) 
		set @login_dbrole = ''

		declare roles_cursor cursor for 
		select dbname,dbrole,dbrole_member,login_name,default_schema_name from #dbrole
		open roles_cursor
		FETCH NEXT FROM roles_cursor INTO @dbname,@dbrole,@dbrole_member,@login_name,@default_schema_name
		
		while (@@fetch_status=0)
		begin
			print '
				USE ['+@dbname+']
				IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = '''+@dbrole_member+''')
				BEGIN 
						  CREATE USER ['+@dbrole_member+'] 
								FOR LOGIN ['+@login_name+']'+isnull(' WITH DEFAULT_SCHEMA=['+@default_schema_name+']','')+'
				END
				ALTER USER ['+@dbrole_member+'] WITH LOGIN = ['+@login_name+']
				EXEC sp_addrolemember '''+@dbrole+''','''+@dbrole_member+'''
				 
				'
			FETCH NEXT FROM roles_cursor INTO @dbname,@dbrole,@dbrole_member,@login_name,@default_schema_name
		end
		close roles_cursor
		deallocate roles_cursor
		--PRINT @login_dbrole
/*
		WHILE @counter <= @maxid2
		BEGIN 
		SELECT @login_dbrole  = 'USE ['+dbname+']
		IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = '''+dbrole_member+''')
		BEGIN 
				  CREATE USER ['+dbrole_member+'] 
						FOR LOGIN ['+login_name+']'+isnull(' WITH DEFAULT_SCHEMA=['+default_schema_name+']','')+'
		END
		ALTER USER ['+dbrole_member+'] WITH LOGIN = ['+login_name+']
		EXEC sp_addrolemember '''+dbrole+''','''+dbrole_member+'''
		 
		' FROM #dbrole WHERE ID = @counter
		  SET @counter = @counter + 1 
		  PRINT @login_dbrole 
		END 
*/		
		FETCH NEXT FROM login_curs INTO @login_sid,@login
	END -- WHILE
	CLOSE login_curs
	DEALLOCATE login_curs
END

GO


