USE [xadmindb]
GO

/****** Object:  StoredProcedure [dbo].[usp_help_revserverrole]    Script Date: 02/05/2013 09:58:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usp_help_revserverrole]
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
		SELECT @maxid = @@ROWCOUNT
		 
		 
		----------------------------------------------
		--Grant Server Role to login 
		----------------------------------------------
		PRINT ''
		PRINT '----------------------------------------------'
		PRINT '--Grant Server Role to login '
		PRINT '----------------------------------------------'
		 
		IF OBJECT_ID('tempdb..#srvrole') IS NOT NULL
		DROP TABLE #srvrole
		 
		CREATE TABLE #srvrole(ServerRole sysname, MemberName sysname, MemberSID varbinary(85))  
		INSERT INTO [#srvrole] EXEC sp_helpsrvrolemember 
		 
		DECLARE @login_srvrole varchar(1000)
		SET @login_srvrole = ''
		IF EXISTS (SELECT 1 FROM #srvrole WHERE[MemberName] = @login) 
		BEGIN 
				  SELECT @login_srvrole = @login_srvrole + 'EXEC sp_addsrvrolemember '''+MemberName+''',
						'''+ServerRole+'''' FROM #srvrole 
				  WHERE [MemberName] = @login
				  PRINT @login_srvrole 
		END
		ELSE
		BEGIN 
				  PRINT '--Login ['+@login+'] is not a member of any server level role'
		END
		FETCH NEXT FROM login_curs INTO @login_sid,@login
	END

	CLOSE login_curs
	DEALLOCATE login_curs
	
END

GO


