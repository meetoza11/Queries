USE [Credit]
GO

/****** Object:  DdlTrigger [tr_db_archive_table_alert]    Script Date: 8/14/2015 9:19:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [tr_db_archive_table_alert] 
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE 
AS 

declare @Eventtype nvarchar(100),
		@SqlCommand nvarchar(max),
		@ObjectName nvarchar(max),
		@ObjectType nvarchar(max),
		@Msg varchar(1000),
		@Subject varchar(1000)
    
SELECT  
		@Eventtype = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'), 
		@SqlCommand = EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)'),
		@ObjectName = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(max)'),
		@ObjectType = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'nvarchar(max)')  
		
		select @msg =  db_name() + '..' + @ObjectName + ' -- ' + @SqlCommand
		select @Subject =  ltrim(rtrim(@@SERVERNAME)) + ' - Archived table being Altered/Dropped in ' + ltrim(rtrim(DB_NAME()))
		
		if exists
		(
		select * from archive.sys.tables where charindex(@ObjectName,name)>0
		) 
		and @ObjectType = 'TABLE' 
		and not (charindex('ADD',@SqlCommand) > 0 and charindex('Constraint',@SqlCommand) > 0)  --ignore add constraint
		and not (charindex('DROP',@SqlCommand) > 0 and charindex('Constraint',@SqlCommand) > 0) --ignore drop constraint 
		and not (charindex('CHECK',@SqlCommand) > 0 and charindex('Constraint',@SqlCommand) > 0) --ignore check constraint 

		EXEC msdb.dbo.sp_send_dbmail
			@recipients = 'it_dba@santanderconsumerusa.com',
--			@recipients = 'szhong@santanderconsumerusa.com',
			@body = @msg,
			@subject = @Subject;
			
			




GO

ENABLE TRIGGER [tr_db_archive_table_alert] ON DATABASE
GO


