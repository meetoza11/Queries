

set nocount on
declare 
       @errordate           datetime
,      @SQLStr                    varchar(8000)
,      @eMailBody           varchar(2000)
,      @email_string varchar(2000)

-- table to house cq data
create table #CQueue
(
Courier varchar(50)
,Pending int
,Errors int
,Stuck int
)

create table #threshold
(
Courier varchar(50)
,Pending int
,Errors int
,Stuck int
)

create table #Alert
(
Courier varchar(50)
,Pending int
,Errors int
,Stuck int
)

set @errordate = dateadd(hour, -1,getdate()) --  will pull 1 hour prior

-- This will hold all existing alert assignments; could be a table -- maybe after development
insert into #threshold
select 
       cTableAffix
       , case when ((cTableAffix = 'mail') and (CONVERT(CHAR(10),GETDATE(),108)between '07:00:00' and '09:00:00'))   
              then 4000 else nPendingThreshold end as 'nPendingThreshold'
       , nErrorThreshold
       , 1  -- Need to add column at some point to CourierSettings to handle dynamically
       from [dbo].[CourierSettings]
       where cTableAffix <> 'NotSet'


--union all select 'TalxTheWorkNumberUnitTestProfile', 50,1

-- loads  cq data into temp table

DECLARE @List VARCHAR(MAX)

SELECT @List =  COALESCE( @List + ' UNION ', ' ') + VAL
FROM
(
SELECT VAL = ' SELECT Courier=''' + SUBSTRING(name,8,LEN(name) -14) + '''
,Pending=(SELECT COUNT(*) FROM ' + name + ' WHERE cError IS NULL AND dProcessed IS NULL AND dActive < getdate() )
,Errors=(SELECT COUNT(*) FROM ' + name + ' WHERE cError IS NOT NULL ) 
,Stuck=(SELECT COUNT(*) FROM ' + name + ' WHERE dProcessed IS NOT NULL AND cError IS NULL AND DATEDIFF(hour, dcreated, getdate()) <= 1 AND DATEDIFF(MINUTE, dprocessed, getdate()) > 2)'
FROM sys.objects WHERE name like 'Courier%Message'
) AS A


insert into #CQueue
EXEC(@List)

--exec [dbo].[pr_view]


-- DISABLE ALERTS, 02/28/2011, Brian

-- Updating as per request from Steve Youmans
--DELETE #CQueue WHERE Courier = 'LexisNexisMVR'
DELETE #CQueue WHERE Courier IN('LexisNexisMVR', 'O2BCheckUploader')

-- Step two: Identify initial alerts
-- the errors alerts could be aged and not valid.. add a step to valiadte errors
insert into #Alert
select 
       q.Courier
       , q.Pending
       , q.Errors
       , q.Stuck
from #CQueue q
left outer join (--y 
              select 
                     Courier
              ,      Pending
              ,      Errors
              ,   Stuck
              from #threshold
              union all 
              select
              Courier, 50, 1, 1
              from ( --x
                     select 
                           q.Courier
                     from #CQueue q
                     except select 
                                  Courier
                           from #Threshold )x
                                         )y
on q.courier = y.courier
where (q.Pending >= y.Pending) -- pending alerts
       or ((q.Errors >= y.Errors) and (q.errors is not null)) -- errors 
       or (q.Stuck >= y.Stuck) -- stuck

select @SQLStr = COALESCE( @SQLStr + '; ', ' ') + 'update #Alert set errors = (select count(cError) from [dbo].[Courier'+ courier 
       + 'Message] where dCreated >=''' + cast(@errordate as varchar(25))+ ''') where courier = ''' + courier + ''''
from #Alert
where errors > 0

exec(@SQLStr)

select 
       a.Courier
,      a.Pending
,      a.Errors 
,   a.Stuck
into ##EmailAlerts
from #Alert a
inner join #threshold t
on a.courier = t.courier
where (a.Pending >= t.Pending) -- pending alerts
       or ((a.Errors >= t.Errors) and (a.errors is not null)) -- errors 
       or (a.Stuck >= t.Stuck) -- stuck


--set nocount on ; 

select courier, pending, errors, stuck from ##emailalerts

---- final body of email
---- eMail logic 
--if exists (select * from ##emailalerts)
--begin
--       print  ''
--       print  'FAILURE - CourierQueues exceed their threshold '
--       print  ''
--       set           @emailbody = '                    '+ char(13)  
--       set           @emailbody = @emailbody + 'THRESHOLD ALERTS: '  
--       select @email_string = 'CourierAlerts@santanderconsumerusa.com'
--       exec   [msdb].[dbo].[sp_send_dbmail]
--                     @recipients = @email_string,
--                     @subject='ALERT:  CourierQueue Count Exceeded Threshold',
--                     @body = @emailbody, 
--                     @query = 'set nocount on ; select courier, pending, errors, stuck from ##emailalerts'
--end 
--else
--begin
--       print  ''
--       print  'SUCCESS - CourierQueues remain within their threshold'
--       print  ''
--------------------------------TEMPORARY CHANGE---------------------------------------------------
----ADDING EMAIL ALERT FOR SUCCESS AS REQUEST FROM CLAY JENKINS ON 04/23/14 AT 10:36
---------------------------------------------------------------------------------------------------
--       --set           @emailbody = '                    '+ char(13)  
--       --set           @emailbody = @emailbody + 'THRESHOLD ALERTS: '  
--       --select @email_string = 'CourierAlerts@santanderconsumerusa.com'
--       --exec   [msdb].[dbo].[sp_send_dbmail]
--       --              @recipients = @email_string,
--       --              @subject='INFORMATIONAL MESSAGE:  CourierQueue Count',
--       --              @body = @emailbody, 
--       --              @query = 'set nocount on ; select courier, pending, errors, stuck from ##emailalerts'
--end

-- clean-up
if object_id('[tempdb].[dbo].[#CQueue]')is not null
drop table #CQueue
if object_id('[tempdb].[dbo].[#threshold]')is not null
drop table #threshold
if object_id('[tempdb].[dbo].[#Alert]')is not null
drop table #Alert
if object_id('[tempdb].[dbo].[##EmailAlerts]')is not null
drop table ##EmailAlerts
