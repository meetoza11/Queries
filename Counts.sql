with T(Courier,Pending,Error,stuck) AS
(
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
)

--BEGIN
--CREATE VIEW DevenTest
--as
select * from T
--END

