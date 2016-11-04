USE [Credit]
GO

/****** Object:  DdlTrigger [TR_DDL_CT]    Script Date: 8/14/2015 9:20:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE trigger [TR_DDL_CT]
on database
for create_table, alter_table
as
declare @x xml
set @x = EVENTDATA()

Insert into staging.dbo.Newtbllog(cdbname,ctblname,cddlcmd,createdt,createdby,bReviewed,xevent)
values ( @x.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(256)'),
	@x.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(256)'),
	@x.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)'),
	getdate(),
	@x.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(256)'),
	0,
	@x)


GO

ENABLE TRIGGER [TR_DDL_CT] ON DATABASE
GO


