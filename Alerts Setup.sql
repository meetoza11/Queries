-- this is to correct alerts name from Critical to Critical
Use msdb
Begin Tran
--select * from msdb.dbo.sysalerts where name like '%SQL Page Life%'
Update msdb.dbo.sysalerts
SET name = 'Critical:SQL Page Life'
where name = 'Crirical:SQL Page Life'
--select * from msdb.dbo.sysalerts where name like '%SQL Page Life%'
commit


/*Backup Failed*/
USE msdb ;
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Backup Failed')	
EXEC msdb.dbo.sp_update_alert @name=N'Backup Failed', 
		@message_id=3041, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=7200, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
EXEC msdb.dbo.sp_add_alert @name=N'Backup Failed', 
		@message_id=3041, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=7200, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO


/* Critical:SQL Page Life*/
USE msdb
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Critical:SQL Page Life')
EXEC msdb.dbo.sp_update_alert @name=N'Critical:SQL Page Life', 
		@message_id=0, 
		@severity=0, 
		@enabled=0, 
		@delay_between_responses=7200, 
		@include_event_description_in=1, 
		@notification_message=N'Page Life', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 4|<|100', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
		
ELSE
		EXEC msdb.dbo.sp_add_alert @name=N'Critical:SQL Page Life', 
		@message_id=0, 
		@severity=0, 
		@enabled=0, 
		@delay_between_responses=7200, 
		@include_event_description_in=1, 
		@notification_message=N'Page Life', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 4|<|100', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

/* Critical:High SQL IO*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Critical:High SQL IO')
EXEC msdb.dbo.sp_update_alert @name=N'Critical:High SQL IO', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, -- disable it for all servers execept Awaya and Well Health
		@delay_between_responses=1800, 
		@include_event_description_in=1, 
		@notification_message=N'High SQL IO Percentage', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 3|>|15', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Critical:High SQL IO', 
			@message_id=0, 
			@severity=0, 
			@enabled=1, -- disable it for all servers execept Awaya and Well Health
			@delay_between_responses=1800, 
			@include_event_description_in=1, 
			@notification_message=N'High SQL IO Percentage', 
			@category_name=N'[Uncategorized]', 
			@performance_condition=N'SQLServer:User Settable|Query|User counter 3|>|15', 
			@job_id=N'00000000-0000-0000-0000-000000000000'			
GO		

/*Critical:High Wait Time*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Critical:High Wait Time')
EXEC msdb.dbo.sp_update_alert @name=N'Critical:High Wait Time', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=1, 
		@notification_message=N'Critical:High Wait Time', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 2|>|10000', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Critical:High Wait Time', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=1, 
		@notification_message=N'Critical:High Wait Time', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 2|>|10000', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
	GO	

/*Critical:SQL CPU Alert*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Critical:SQL CPU Alert')
EXEC msdb.dbo.sp_update_alert @name=N'Critical:SQL CPU Alert', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=7200, 
		@include_event_description_in=3, 
		@notification_message=N'Critical:CPU Utilization', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 1|>|65', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
		EXEC msdb.dbo.sp_add_alert @name=N'Critical:SQL CPU Alert', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=7200, 
		@include_event_description_in=3, 
		@notification_message=N'Critical:CPU Utilization', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 1|>|65', 
		@job_id=N'00000000-0000-0000-0000-000000000000'		
GO

/*Fatal Error:Allocating Resource*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Fatal Error:Allocating Resource')
EXEC msdb.dbo.sp_update_alert @name=N'Fatal Error:Allocating Resource', 
		@message_id=0, 
		@severity=17, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Fatal Error:Allocating Resource', 
		@message_id=0, 
		@severity=17, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

/*Fatal Error:Database Integrity Suspect*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Fatal Error:Database Integrity Suspect')
	EXEC msdb.dbo.sp_update_alert @name=N'Fatal Error:Database Integrity Suspect', 
		@message_id=0, 
		@severity=23, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Fatal Error:Database Integrity Suspect', 
		@message_id=0, 
		@severity=23, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

/*Fatal Error:Hardware Error*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Fatal Error:Hardware Error')
EXEC msdb.dbo.sp_update_alert @name=N'Fatal Error:Hardware Error', 
		@message_id=0, 
		@severity=24, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Fatal Error:Hardware Error', 
		@message_id=0, 
		@severity=24, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

/*Fatal Error:In Current Process*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Fatal Error:In Current Process')
EXEC msdb.dbo.sp_update_alert @name=N'Fatal Error:In Current Process', 
		@message_id=0, 
		@severity=20, 
		@enabled=0, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Fatal Error:In Current Process', 
		@message_id=0, 
		@severity=20, 
		@enabled=0, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

/* Fatal Error:In Database Process*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Fatal Error:In Database Process')
EXEC msdb.dbo.sp_update_alert @name=N'Fatal Error:In Database Process', 
		@message_id=0, 
		@severity=21, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Fatal Error:In Database Process', 
		@message_id=0, 
		@severity=21, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

/*Fatal Error:In Resource*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Fatal Error:In Resource')
	EXEC msdb.dbo.sp_update_alert @name=N'Fatal Error:In Resource', 
		@message_id=0, 
		@severity=19, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Fatal Error:In Resource', 
		@message_id=0, 
		@severity=19, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
	
/*Fatal Error:In SQL Server*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Fatal Error:In SQL Server')
EXEC msdb.dbo.sp_update_alert @name=N'Fatal Error:In SQL Server', 
		@message_id=0, 
		@severity=25, 
		@enabled=1, 
		@delay_between_responses=10, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Fatal Error:In SQL Server', 
		@message_id=0, 
		@severity=25, 
		@enabled=1, 
		@delay_between_responses=10, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
	
/*Fatal Error:Table Integrity Suspect*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Fatal Error:Table Integrity Suspect')
EXEC msdb.dbo.sp_update_alert @name=N'Fatal Error:Table Integrity Suspect', 
		@message_id=0, 
		@severity=22, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
		EXEC msdb.dbo.sp_add_alert @name=N'Fatal Error:Table Integrity Suspect', 
		@message_id=0, 
		@severity=22, 
		@enabled=1, 
		@delay_between_responses=1800, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

/*Fatal:SQL CPU Alert*/
USE [msdb]
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Fatal:SQL CPU Alert')
EXEC msdb.dbo.sp_update_alert @name=N'Fatal:SQL CPU Alert', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=3, 
		@notification_message=N'Fatal:CPU Utilization', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 1|>|95', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Fatal:SQL CPU Alert', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=3, 
		@notification_message=N'Fatal:CPU Utilization', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 1|>|95', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
	
/*Warning:Database Used Pct High*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Warning:Database Used Pct High')
EXEC msdb.dbo.sp_update_alert @name=N'Warning:Database Used Pct High', 
		@message_id=900001, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=7200, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Warning:Database Used Pct High', 
		@message_id=900001, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=7200, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO
	
/*Warning:High SQL IO*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Warning:High SQL IO')
EXEC msdb.dbo.sp_update_alert @name=N'Warning:High SQL IO', 
		@message_id=0, 
		@severity=0, 
		@enabled=0, 
		@delay_between_responses=1800, 
		@include_event_description_in=1, 
		@notification_message=N'High SQL IO Percentage', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 3|>|10', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Warning:High SQL IO', 
		@message_id=0, 
		@severity=0, 
		@enabled=0, 
		@delay_between_responses=1800, 
		@include_event_description_in=1, 
		@notification_message=N'High SQL IO Percentage', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 3|>|10', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

/*Warning:High Wait Time*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Warning:High Wait Time')
EXEC msdb.dbo.sp_update_alert @name=N'Warning:High Wait Time', 
		@message_id=0, 
		@severity=0, 
		@enabled=0, 
		@delay_between_responses=1800, 
		@include_event_description_in=1, 
		@notification_message=N'Warning:High Wait Time', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 2|>|4000', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Warning:High Wait Time', 
		@message_id=0, 
		@severity=0, 
		@enabled=0, 
		@delay_between_responses=1800, 
		@include_event_description_in=1, 
		@notification_message=N'Warning:High Wait Time', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 2|>|4000', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

/*Warning:Low Disk Space*/		
USE [msdb]
GO
                    if (select count(*)
                         from sys.messages
                        where message_id = 900000) <1
                    begin
						exec master.dbo.sp_addmessage 
                            @msgnum = 900000
                        ,   @severity = 16 
                        ,   @msgtext = 'Disk space is lower than %d percent.
%s'
                        ,   @lang = 'us_english'
                        ,   @with_log = 'TRUE'
                    end
/****** Object:  Alert [Warning: Low Disk Space]    Script Date: 08/10/2010 18:29:25 ******/
IF (EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name = N'Warning:Low Disk Space'))
 ---- Delete the alert with the same name.
  EXECUTE msdb.dbo.sp_delete_alert @name = N'Warning:Low Disk Space' 
BEGIN 
EXEC msdb.dbo.sp_add_alert @name=N'Warning:Low Disk Space', 
		@message_id=900000, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=7200, 
		@include_event_description_in=3, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
end



/*Warning:SQL CPU Alert*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Warning:SQL CPU Alert')
EXEC msdb.dbo.sp_update_alert @name=N'Warning:SQL CPU Alert', 
		@message_id=0, 
		@severity=0, 
		@enabled=0, 
		@delay_between_responses=1800, 
		@include_event_description_in=1, 
		@notification_message=N'Warning:CPU Utilization', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 1|>|40', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Warning:SQL CPU Alert', 
			@message_id=0, 
			@severity=0, 
			@enabled=0, 
			@delay_between_responses=1800, 
			@include_event_description_in=1, 
			@notification_message=N'Warning:CPU Utilization', 
			@category_name=N'[Uncategorized]', 
			@performance_condition=N'SQLServer:User Settable|Query|User counter 1|>|40', 
			@job_id=N'00000000-0000-0000-0000-000000000000'
	GO

/*Warning:SQL Page Life*/
USE [msdb]
GO
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts where name = 'Warning:SQL Page Life')
EXEC msdb.dbo.sp_update_alert @name=N'Warning:SQL Page Life', 
		@message_id=0, 
		@severity=0, 
		@enabled=0, 
		@delay_between_responses=300, 
		@include_event_description_in=3, 
		@notification_message=N'Page Life Expectancy', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 4|<|300', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
ELSE
	EXEC msdb.dbo.sp_add_alert @name=N'Warning:SQL Page Life', 
		@message_id=0, 
		@severity=0, 
		@enabled=0, 
		@delay_between_responses=300, 
		@include_event_description_in=3, 
		@notification_message=N'Page Life Expectancy', 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'SQLServer:User Settable|Query|User counter 4|<|300', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO












