select top(10) * from dbperf.dba_Filestats where database_name = 'WellHealth_0' 
and snapshot_date between '2013-11-21 12:00:00.000' and '2013-11-21 14:00:00.000'

select top(10) * from dbperf.dba_Filestats where database_name = 'WellHealth_0' 
and snapshot_date between '2013-11-22 12:00:00.000' and '2013-11-22 14:00:00.000'

select top(100) * from dbadmin.dba_blockinfo 
where snapshot_dt between '2013-11-21 12:00:00.000' and '2013-11-21 14:00:00.000'

select top(100) * from dbadmin.dba_blockinfo 
where snapshot_dt between '2013-11-22 12:00:00.000' and '2013-11-22 14:00:00.000'

select min(snapshot_dt) from dbadmin.dba_blockinfo 


select top(10) 
snapshot_date, 
database_name, 
num_of_reads, 
num_of_writes, 
--num_of_bytes_read, 
--num_of_bytes_written, 
cumulative_num_of_reads, 
cumulative_num_of_writes 
--cumulative_num_of_bytes_read,
--cumulative_num_of_bytes_written 
from dbperf.dba_Filestats where database_name = 'WellHealth_0' 
and snapshot_date between '2013-11-21 12:00:00.000' and '2013-11-21 14:00:00.000'

select top(10) snapshot_date, 
database_name, 
num_of_reads, 
num_of_writes, 
--num_of_bytes_read, 
--num_of_bytes_written, 
cumulative_num_of_reads, 
cumulative_num_of_writes 
--cumulative_num_of_bytes_read,
--cumulative_num_of_bytes_written 
from dbperf.dba_Filestats where database_name = 'WellHealth_0' 
and snapshot_date between '2013-11-22 12:00:00.000' and '2013-11-22 14:00:00.000'

--select MAX(snapshot_date) from dbperf.dba_Filestats


--- number of locks
SELECT top (10) * FROM sys.dm_tran_locks


DECLARE @cntr_value bigint

SELECT @cntr_value = cntr_value
FROM sys.dm_os_performance_counters
WHERE counter_name LIKE 'Transactions/sec%'
AND instance_name LIKE '_Total%'

WAITFOR DELAY '00:00:01'

SELECT cntr_value - @cntr_value
FROM sys.dm_os_performance_counters
WHERE counter_name LIKE 'Transactions/sec%'
AND instance_name LIKE '_Total%'

select top(100) * from sys.dm_os_performance_counters 
where counter_name like 'Transactions/sec%'
and instance_name = 'WellHealth_0'


--------------------------------------------------------------------------------
