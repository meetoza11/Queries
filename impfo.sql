:connect RCHPWVMGMSQL01.prod.corpint.net\MANAGEMENT01

-- enter a US#, a DE#, or an implementation #
declare @needle nvarchar(256) = '60304';

set nocount on ;
declare @ImpID int ;

-- find that needle
select
	top 1 @ImpID = [ImplementationID]
from
	dba.dbo.[vw_ImplementationLog]
where
	Convert(nvarchar(256), [ImplementationID]) = @needle
	or [UserStory] like '%' + @needle + '%'
order by
	[CreateDate] desc ;

-- implementation summary
select 'vw_ImplementationLog' as TableName, * from dba.dbo.[vw_ImplementationLog] where [ImplementationID] = @ImpID ;

-- current exceptions
select 'imp_exceptions' as TableName, * from dba.dbo.[imp_exceptions] where [cImpName] like '%' + Convert(varchar(8), @ImpID) + '%' ;

-- environment executions
select 'vw_ImplementationsAndRollbacks' as TableName, * from dba.dbo.[vw_ImplementationsAndRollbacks] where [implementation] like '%' + Convert(varchar(8), @ImpID) + '%' order by [date] desc, [time] desc ;

-- execution details
select 'ImplementList' as TableName, * from dba.dbo.[ImplementList] where [implementation] like '%' + Convert(varchar(8), @ImpID) + '%' ;

-- files modified
select 'imp_folderScan' as TableName,
	[load_date],
	[file_name],
	[file_lastModified]
from
	dba.dbo.[imp_folderScan]
where
	[directory_name] like '%' + Convert(varchar(8), @ImpID) + '%'
order by
	[load_date] desc,
	[file_lastModified] desc,
	[file_name] asc ;


-- select top 1 * from dba.dbo.ImplementationLog where [ImplementationName] like '%62510%'
-- select top 1 * from dba.dbo.ImplementList
-- select top 1 * from dba.dbo.Imp_folderscan
-- select top 1 * from dba.dbo.ImplementList
-- select top 1 * from dba.dbo.ImplementList
-- select top 1 * from dba.[dbo].[imp_exceptions]
-- select top 1 * from dba.[dbo].[imp_folderScan]
-- select top 1 * from dba.[dbo].[MailboxDBA]
-- select top 1 * from dba.[dbo].[Users]






