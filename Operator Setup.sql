USE [msdb]
GO

IF EXISTS (SELECT * FROM msdb.dbo.sysoperators where name = 'DBAMSSQL')
EXEC msdb.dbo.sp_update_operator @name=N'DBAMSSQL', 
		@enabled=1, 
		@weekday_pager_start_time=20000, 
		@weekday_pager_end_time=220000, 
		@saturday_pager_start_time=20000, 
		@saturday_pager_end_time=220000, 
		@sunday_pager_start_time=20000, 
		@sunday_pager_end_time=220000, 
		@pager_days=127, 
		@email_address=N'DBAMSSQL-Lincolnshire@walgreens.com', 
		@pager_address=N'MSSQLDBsupport@walgreens.com', 
		@netsend_address=N''
ELSE	
	EXEC msdb.dbo.sp_add_operator @name=N'DBAMSSQL', 
		@enabled=1, 
		@weekday_pager_start_time=20000, 
		@weekday_pager_end_time=220000, 
		@saturday_pager_start_time=20000, 
		@saturday_pager_end_time=220000, 
		@sunday_pager_start_time=20000, 
		@sunday_pager_end_time=220000, 
		@pager_days=127, 
		@email_address=N'DBAMSSQL-Lincolnshire@walgreens.com', 
		@pager_address=N'MSSQLDBsupport@walgreens.com', 
		@netsend_address=N''
GO

USE msdb 

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Critical:SQL Page Life')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Critical:SQL Page Life', @operator_name=N'DBAMSSQL', @notification_method = 1
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Critical:SQL Page Life', @operator_name=N'DBAMSSQL', @notification_method = 1
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Backup Failed')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Backup Failed', @operator_name=N'DBAMSSQL', @notification_method = 1
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Backup Failed', @operator_name=N'DBAMSSQL', @notification_method = 1
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Critical:High SQL IO')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Critical:High SQL IO', @operator_name=N'DBAMSSQL', @notification_method = 1
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Critical:High SQL IO', @operator_name=N'DBAMSSQL', @notification_method = 1
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Warning:High SQL IO')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Warning:High SQL IO', @operator_name=N'DBAMSSQL', @notification_method = 1
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Warning:High SQL IO', @operator_name=N'DBAMSSQL', @notification_method = 1
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Critical:High Wait Time')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Critical:High Wait Time', @operator_name=N'DBAMSSQL', @notification_method = 1
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Critical:High Wait Time', @operator_name=N'DBAMSSQL', @notification_method = 1
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Critical:SQL CPU Alert')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Critical:SQL CPU Alert', @operator_name=N'DBAMSSQL', @notification_method = 1
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Critical:SQL CPU Alert', @operator_name=N'DBAMSSQL', @notification_method = 1
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Fatal Error:Allocating Resource')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Fatal Error:Allocating Resource', @operator_name=N'DBAMSSQL', @notification_method = 3
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Fatal Error:Allocating Resource', @operator_name=N'DBAMSSQL', @notification_method = 3
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Fatal Error:In Database Process')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Fatal Error:In Database Process', @operator_name=N'DBAMSSQL', @notification_method = 3
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Fatal Error:In Database Process', @operator_name=N'DBAMSSQL', @notification_method = 3
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Fatal Error:In Resource')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Fatal Error:In Resource', @operator_name=N'DBAMSSQL', @notification_method = 3
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Fatal Error:In Resource', @operator_name=N'DBAMSSQL', @notification_method = 3
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Fatal Error:in SQL Server')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Fatal Error:in SQL Server', @operator_name=N'DBAMSSQL', @notification_method = 3
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Fatal Error:in SQL Server', @operator_name=N'DBAMSSQL', @notification_method = 3
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Fatal Error:Database Integrity Suspect')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Fatal Error:Database Integrity Suspect', @operator_name=N'DBAMSSQL', @notification_method = 3
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Fatal Error:Database Integrity Suspect', @operator_name=N'DBAMSSQL', @notification_method = 3
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Fatal Error:Hardware Error')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Fatal Error:Hardware Error', @operator_name=N'DBAMSSQL', @notification_method = 3
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Fatal Error:Hardware Error', @operator_name=N'DBAMSSQL', @notification_method = 3
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Fatal Error:Table Integrity Suspect')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Fatal Error:Table Integrity Suspect', @operator_name=N'DBAMSSQL', @notification_method = 3
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Fatal Error:Table Integrity Suspect', @operator_name=N'DBAMSSQL', @notification_method = 3
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Fatal:SQL CPU Alert')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Fatal:SQL CPU Alert', @operator_name=N'DBAMSSQL', @notification_method = 3
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Fatal:SQL CPU Alert', @operator_name=N'DBAMSSQL', @notification_method = 3
GO

IF EXISTS (select SA.id from msdb.dbo.sysalerts SA inner join msdb.dbo.sysnotifications SN
ON SA.id = SN.alert_id and sa.name = 'Warning:Low Disk Space')
EXEC msdb.dbo.sp_update_notification @alert_name=N'Warning:Low Disk Space', @operator_name=N'DBAMSSQL', @notification_method = 3
ELSE
EXEC msdb.dbo.sp_add_notification @alert_name=N'Warning:Low Disk Space', @operator_name=N'DBAMSSQL', @notification_method = 3
GO

