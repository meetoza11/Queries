-- These values will be in Threshold table
select 
       cTableAffix
       , case when ((cTableAffix = 'mail') and (CONVERT(CHAR(10),GETDATE(),108)between '07:00:00' and '09:00:00'))   
              then 4000 else nPendingThreshold end as 'nPendingThreshold'
       , nErrorThreshold
       , 1  -- Need to add column at some point to CourierSettings to handle dynamically
       from [dbo].[CourierSettings]
       where cTableAffix <> 'NotSet'

-- These values will be in Cqueue table
SELECT VAL = ' SELECT Courier=''' + SUBSTRING(name,8,LEN(name) -14) + '''
,Pending=(SELECT COUNT(*) FROM ' + name + ' WHERE cError IS NULL AND dProcessed IS NULL AND dActive < getdate() )
,Errors=(SELECT COUNT(*) FROM ' + name + ' WHERE cError IS NOT NULL ) 
,Stuck=(SELECT COUNT(*) FROM ' + name + ' WHERE dProcessed IS NOT NULL AND cError IS NULL AND DATEDIFF(hour, dcreated, getdate()) <= 1 AND DATEDIFF(MINUTE, dprocessed, getdate()) > 2)'
FROM sys.objects WHERE name like 'Courier%Message'

select * from sys.objects WHERE name like 'Courier%Message'

select count(*) from CourierRepoMessage WHERE cError IS NULL AND dProcessed IS NULL AND dActive < getdate() -- pending
select count(*) from CourierCAPMessage WHERE cError IS NOT NULL  -- Errors
select count(*) from CourierCAPMessage WHERE dProcessed IS NOT NULL AND cError IS NULL AND DATEDIFF(hour, dcreated, getdate()) <= 1 AND DATEDIFF(MINUTE, dprocessed, getdate()) > 2 -- stuck



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


select * from courierSettings

create view DevenTest
as
select 
       q.cTableAffix
       , case when ((q.cTableAffix = 'mail') and (CONVERT(CHAR(10),GETDATE(),108)between '07:00:00' and '09:00:00'))   
              then 4000 else q.nPendingThreshold end as 'nPendingThreshold'
       , q.nErrorThreshold
       , 1  -- Need to add column at some point to CourierSettings to handle dynamically
       from [dbo].[CourierSettings] q
       --where cTableAffix <> 'NotSet' 
		left Outer Join (
						select       cTableAffix
							  ,      nPendingThreshold
							  ,      nErrorThreshold
							  
						from [dbo].[CourierSettings]
						where cTableAffix <> 'NotSet'
			union all 
					  select
					  x.Courier as 'cTableAffix', 50, 1
					  from (
							SELECT  SUBSTRING(name,8,LEN(name) -14) as 'Courier' from sys.objects where name like 'Courier%Message' 
							except
							select cTableAffix from [dbo].[CourierSettings] where cTableAffix <> 'NotSet'
				) x ) y
on q.cTableAffix = y.cTableAffix
where (q.nPendingThreshold >= y.nPendingThreshold) -- pending alerts
       or ((q.nErrorThreshold >= y.nErrorThreshold) and (q.nErrorThreshold is not null)) -- errors 
       --or (q.Stuck >= y.Stuck) -- stuck
GO
