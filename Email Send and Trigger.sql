--CREATE Trigger [Trg_TrackLoginManagement]
--on ALL Server
--for DDL_LOGIN_EVENTS
--as
 
--set nocount on
--declare @data xml,
--              @EventType varchar(100),
--              @EventTime datetime,
--              @ServerName varchar(100),
--              @AffectedLoginName varchar(100),
--              @WhoDidIt varchar(100),
--              @EmailSubject varchar(500),
--              @EmailBody varchar(800),
--              @EmailRecipients varchar(300)
 
--set @EmailRecipients = 'deven.oza@walgreens.com'
 
--set @data = eventdata()
--set @EventType = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(100)')
--set @EventTime = @data.value('(/EVENT_INSTANCE/PostTime)[1]','datetime')
--set @ServerName = @data.value('(/EVENT_INSTANCE/ServerName)[1]','varchar(100)')
--set @AffectedLoginName = @data.value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(100)')
--set @WhoDidIt = @data.value('(/EVENT_INSTANCE/LoginName)[1]','varchar(100)')
 
--insert into msdb..TrackLoginManagement values (@EventType,@EventTime,@ServerName,@AffectedLoginName,@WhoDidIt)
 
--set @EmailSubject = 'ALERT: DDL_LOGIN_Event: ' + @EventType + ' occured by ' + @WhoDidIt + ' on ' + @ServerName
--set @EmailBody =  'DDL_Login_Event: ' + @EventType + char(10) +
--                     'Event Occured at: ' + convert(Varchar, @EventTime) + char(10) +
--                     'ServerName: ' + @ServerName + char(10) +
--                     'Affected Login Name:      ' + @AffectedLoginName + char(10) +
--                     'Event Done by: ' + @WhoDidIt
 
--EXEC msdb.dbo.sp_send_dbmail
--    @recipients = @EmailRecipients,
--    @body = @EmailBody,
--    @subject = @EmailSubject ;
 
--print @Eventtype + ' activity completed successfully.'
--GO

select * from TrackLoginManagement

--------------------------
SELECT SYSTEM_USER,USER, @@SPID,GETDATE(), @@SERVERNAME, original_login()

--/* Create Audit Table */
--CREATE TABLE ServerLogonHistory
--(SystemUser VARCHAR(512),
--DBUser VARCHAR(512),
--SPID INT,
--LogonTime DATETIME,
--OriginalLogin VARCHAR(512))
--GO

--/* Create Logon Trigger */
--CREATE TRIGGER Tr_ServerLogon
--ON ALL SERVER FOR LOGON
--AS
--BEGIN
--INSERT INTO ServerLogonHistory
--SELECT SYSTEM_USER,USER,@@SPID,
--DATEADD(minute, DATEDIFF(minute, '20000101', getdate()), '20000101'), 
--original_login() 
---- WHERE SYSTEM_USER LIKE '%walgreens%'
----WAITFOR DELAY '00:00:01'
--END
--GO

--DROP TRIGGER Tr_ServerLogon
--ON ALL SERVER


SELECT SYSTEM_USER,USER,@@SPID
,DATEADD(minute, DATEDIFF(minute, '20000101', getdate()), '20000101'), original_login() 
group by SYSTEM_USER,USER,@@SPID,GETDATE(), original_login() 
having count

select getdate()

select SystemUser, count(SPID) from ServerLogonHistory where systemUser like '%walgreen%' order by logontime desc

select SystemUser as UserName, count(SPID) as ConnNumber 
from ServerLogonHistory
--where systemuser like '%walgreens%'
where LogonTime <= getdate()
group by SystemUser



select convert(datetime, convert(char(16), '2014-01-09 14:15:24.713', 126))
select convert(datetime, convert(char(16), getdate(), 126))
select dateadd(second, -datepart(second, '2014-01-09 14:15:24.713'), '2014-01-09 14:15:24.713')
select getdate()
select DATEADD(minute, DATEDIFF(minute, '20000101', getdate()), '20000101')



select * from ServerLogonHistory SLH1 
left join ServerLogonHistory SLH2 
ON SLH1.SPID = SLH2.SPID


select  systemUser, spid, dbuser, LogonTime, originalLogin from serverlogonhistory

WAITFOR DELAY '00:00:05'

--delete from ServerLogonHistory

select * from sys.server_triggers

Tr_ServerLogon
Trg_TrackLoginManagement
---------------------------------------------------
--USE master
--GO
 
--CREATE TABLE [dbo].[t_logon_authentication_ids](LoginAllowedID varchar(50));
--GO

--GRANT SELECT ON [dbo].[t_logon_authentication_dbs] TO public;
--GO


SELECT authenticating_database_id FROM sys.dm_exec_sessions
SELECT * FROM sys.dm_exec_sessions where session_id = 

INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('sa');
INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('QuestLogin');
INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('WALGREENS\qstadmin');
INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('WALGREENS\nafplid1');
INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('QuestLogin');
INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('WALGREENS\ozadeven');
INSERT INTO [dbo].[t_logon_authentication_ids] VALUES ('WALGREENS\dixitsan');

SELECT login_name FROM sys.dm_exec_sessions where session_id = @@spid
select * from [dbo].[t_logon_authentication_ids] 


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
---------------------------------------------------------------
SELECT SYSTEM_USER,USER, @@SPID,GETDATE(), @@SERVERNAME, original_login()

select * from sys.dm_exec_sessions


user_name
USER_ID, 
SELECT COUNT(*) FROM sys.dm_exec_sessions
            WHERE is_user_process = 1 AND
              --  original_login_name = 'login_test'
              
select host_name, login_name, Original_login_name, login_time, nt_domain from sys.dm_exec_sessions
where session_id = @@spid




/* Create Audit Table */
--CREATE TABLE ServerLogonHistory
--(HostName VARCHAR(100),
--LoginName VARCHAR(50),
--OriginalLogiName VARCHAR(50),
--LoginTime Datetime,
--NT_Domain VARCHAR)
--GO


/* Create Logon Trigger */
--CREATE TRIGGER Tr_ServerLogon
--ON ALL SERVER AFTER LOGON
--AS
--BEGIN
--	INSERT INTO ServerLogonHistory
--	SELECT host_name, login_name, Original_login_name, login_time, nt_domain 
--	FROM sys.dm_exec_sessions WHERE session_id = @@spid
--END
--GO

SELECT * FROM ServerLogonHistory
SELECT * FROM ServerLogonHistory1
select * from sys.server_triggers


--DROP TRIGGER Tr_ServerLogon
--ON ALL SERVER
----------------------------------------------------

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'DBA Profile' 
   ,@recipients = 'deven.oza@walgreens.com;'      
   ,@query = 'select SystemUser as UserName, count(SPID) as ConnNumber from ServerLogonHistory 
				where LogonTime <= getdate() group by SystemUser'
   ,@subject = 'Encounter Counts' 
   --,@query_result_separator = '|'
   ,@query_result_width = 200
   ,@attach_query_result_as_file = 1 ;   
GO


----------------------------------------------------------------
-- Get a count of SQL connections by IP address
SELECT ec.client_net_address, es.[program_name], 
es.[host_name], es.login_name, 
COUNT(ec.session_id) AS [connection count] 
FROM sys.dm_exec_sessions  AS es WITH (NOLOCK) 
INNER JOIN sys.dm_exec_connections AS ec WITH (NOLOCK)
ON es.session_id = ec.session_id 
GROUP BY ec.client_net_address, es.[program_name], es.[host_name], es.login_name  
ORDER BY ec.client_net_address, es.[program_name] OPTION (RECOMPILE);

SELECT ec.client_net_address,es.[host_name], es.login_name ,
COUNT(ec.session_id) AS [connection count] 
FROM sys.dm_exec_sessions  AS es WITH (NOLOCK) 
INNER JOIN sys.dm_exec_connections AS ec WITH (NOLOCK)
ON es.session_id = ec.session_id 
GROUP BY ec.client_net_address, es.[host_name], es.login_name  
ORDER BY ec.client_net_address OPTION (RECOMPILE);


--- Create table
--CREATE TABLE ServerLoginHistory
--(ClientNetAddress VARCHAR(50),
--HostName VARCHAR(50),
--LoginName VARCHAR(50),
--ConneCount INT)
--GO

--Insert into Xadmindb.dbo.ServerLoginHistory
--SELECT ec.client_net_address,es.[host_name], es.login_name ,
--COUNT(ec.session_id) AS [connection count], getdate()
--FROM sys.dm_exec_sessions  AS es WITH (NOLOCK) 
--INNER JOIN sys.dm_exec_connections AS ec WITH (NOLOCK)
--ON es.session_id = ec.session_id 
--GROUP BY ec.client_net_address, es.[host_name], es.login_name 

--Delete from Xadmindb.dbo.ServerLoginHistory

select * from Xadmindb.dbo.ServerLoginHistory


--Insert into Xadmindb.dbo.ServerLoginHistory
--SELECT ec.client_net_address,es.[host_name], es.login_name , es.Original_login_name,
--COUNT(ec.session_id) AS [connection count], getdate()
--FROM sys.dm_exec_sessions  AS es WITH (NOLOCK) 
--INNER JOIN sys.dm_exec_connections AS ec WITH (NOLOCK)
--ON es.session_id = ec.session_id 
--GROUP BY ec.client_net_address, es.[host_name], es.login_name,  es.Original_login_name
----HAVING login_name like '%WellHealth%'

select ClientNetAddress, HostName, LoginName, Original_Login_name
FROM Xadmindb.dbo.ServerLoginHistory
WHERE ConnTime >= getdate()-1
GROUP BY ClientNetAddress, HostName, LoginName, Original_Login_name
Order BY LoginName Desc

select getdate()


DECLARE @query_result_separator CHAR(1) = char(9);
--execute as Login = 'sa'
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'DBA Profile' 
   ,@recipients = 'deven.oza@walgreens.com;'      
   ,@query = 'SELECT ClientNetAddress, HostName, LoginName, Original_Login_name
			FROM Xadmindb.dbo.ServerLoginHistory
			WHERE ConnTime >= getdate()-1 and LoginName like ''%WellHealth%''
			GROUP BY ClientNetAddress, HostName, LoginName, Original_Login_name
			Order BY LoginName Desc'
   ,@subject = 'Server Connections' 
   ,@query_result_separator = @query_result_separator
   --,@query_result_separator = 'char(9)'
   --,@query_result_width = 30000
	--,@Body_format = 'HTML'
   --,@query_result_no_padding = 1
   ,@query_attachment_filename= 'Report.csv'
   ,@attach_query_result_as_file = 1 ;   
GO
revert

SELECT * FROM Xadmindb.dbo.ServerLoginHistory
order by ConnTime desc


where ConnTime <=dateadd(d,7,getdate())
order by connTime desc

--DELETE FROM Xadmindb.dbo.ServerLoginHistory
--WHERE ConnTime <=dateadd(d,-4,getdate())


