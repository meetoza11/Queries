use [DBA] ;
go

declare @who nvarchar(128) = '' ;		-- implemented by specific person (imp log format)
declare @since int         = 10608 ;	-- only shows imps greater than this one
declare @age int           = 4 ;		-- shows imps occuring within x days

if (@who = '') set @who = null ;
if (@who = 'me') set @who = Right(CURRENT_USER, CharIndex('\', CURRENT_USER) + 1) ;
if not exists (select 1 from dba.dbo.[vw_ImplementationLog] where [Requestor] = @who) set @who = null ;
if not exists (select 1 from dba.dbo.[vw_ImplementationLog] where [ImplementationID] = @since) set @since = null ;
declare @cutoff datetime = DateAdd(d, @age * -1, getdate()) ;
--select [Who] = @who ;

-- get imps
declare @imps table ([ImplementationID] int) ;
insert into @imps
select
	[ImplementationID]
from
	dba.dbo.[ImplementationLog]
where
	[dCreateDate] >= @cutoff
	and (@who is null or [cRequestor] = @who)
	and (@since is null or [ImplementationID] > @since) ;

-- requests with involvement
select
	*
from 
	dba.dbo.[vw_ImplementationLog]
where
	[ImplementationID] in (select [ImplementationID] from @imps)
order by
	[ImplementationID] asc ;

-- implementations performed
select
	*
from
	dba.dbo.[vw_Implementations]
where
	[date] >= @cutoff
	and (@who is null or [implementer] = @who)
	and Left([implementation], Len(Left([implementation], CharIndex('_', [implementation]) - 1))) in (select [ImplementationID] from @imps)
order by
	[date] desc,
	[time] desc ;

-- files involved
select
	[load_date],
	[file_name],
	[file_lastModified]
from
	dba.dbo.[imp_folderScan]
where
	Left(Right([directory_name], CharIndex('\', Reverse([directory_name])) - 1), CharIndex('_', Right([directory_name], CharIndex('\', Reverse([directory_name])) - 1)) - 1) in (select [ImplementationID] from @imps)
	and (@age is null or [file_lastModified] >= @cutoff)
order by
	[load_date] desc,
	[file_lastModified] desc,
	[file_name] asc ;
