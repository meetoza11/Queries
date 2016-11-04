--USE master
--GO
 
--CREATE TABLE [dbo].[t_logon_authentication_ids](LoginAllowedID varchar(50));
--GO

--GRANT SELECT ON [dbo].[t_logon_authentication_dbs] TO public;
--GO


--SELECT authenticating_database_id FROM sys.dm_exec_sessions
--SELECT * FROM sys.dm_exec_sessions where session_id = 

--INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('sa');
--INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('QuestLogin');
--INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('WALGREENS\qstadmin');
--INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('WALGREENS\nafplid1');
--INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('QuestLogin');
--INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('WALGREENS\ozadeven');
--INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('WALGREENS\dixitsan');

--SELECT login_name FROM sys.dm_exec_sessions where session_id = @@spid
--select * from [dbo].[t_logon_authentication_ids] 


--DROP TRIGGER trig_logon_db_authentication
--ON ALL SERVER
--SELECT host_name FROM sys.dm_exec_sessions where session_id = @@spid 
--select * from sys.server_triggers

--CREATE TRIGGER trig_logon_db_authentication
--ON ALL SERVER
--FOR LOGON
--AS
--BEGIN
 
 
--DECLARE @LoginPermittedID Varchar(50);
--SELECT @LoginPermittedID = login_name FROM sys.dm_exec_sessions WHERE session_id = @@spid;
--DECLARE @HostID Varchar(50);
--SELECT @HostID = host_name FROM sys.dm_exec_sessions where session_id = @@spid
  
----   IF NOT (EXISTS(SELECT * FROM [dbo].[t_logon_authentication_ids] WHERE AllowedLoginID = @LoginPermittedID ))
----   BEGIN
----       ROLLBACK;
----   END

--IF (@LoginPermittedID = 'walgreens\ozadeven' AND 
--		NOT (EXIST(SELECT * FROM [dbo].[t_logon_authentication_ids] WHERE AllowedHostName = @HostID))  
--	BEGIN
--		ROLLBACK;	
--	END;
--GO