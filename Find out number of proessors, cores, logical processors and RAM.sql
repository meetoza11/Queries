----- Find number of physical processors, cores, logical processors and RAM using T-SQL 
--SELECT ( cpu_count / hyperthread_ratio )AS NumberOfPhysicalCPUs
--, CASE
--WHEN hyperthread_ratio = cpu_count THEN cpu_count
--ELSE ( ( cpu_count - hyperthread_ratio ) / ( cpu_count / hyperthread_ratio ) )
--END AS NumberOfCoresInEachCPU
--, CASE
--WHEN hyperthread_ratio = cpu_count THEN cpu_count
--ELSE ( cpu_count / hyperthread_ratio ) * ( ( cpu_count - hyperthread_ratio ) / ( cpu_count / hyperthread_ratio ) )
--END AS TotalNumberOfCores
--, cpu_count AS NumberOfLogicalCPUs
--, CONVERT(MONEY, Round(physical_memory_in_bytes / 1073741824.0, 0)) AS TotalRAMInGB
--FROM

--sys.dm_os_sys_info

SELECT ( cpu_count / hyperthread_ratio )AS NumberOfPhysicalCPUs
, CASE
WHEN hyperthread_ratio = cpu_count THEN cpu_count
ELSE ( ( cpu_count - hyperthread_ratio ) / ( cpu_count / hyperthread_ratio ) )
END AS NumberOfCoresInEachCPU
, CASE
WHEN hyperthread_ratio = cpu_count THEN cpu_count
ELSE ( cpu_count / hyperthread_ratio ) * ( ( cpu_count - hyperthread_ratio ) / ( cpu_count / hyperthread_ratio ) )
END AS TotalNumberOfCores
, cpu_count AS NumberOfLogicalCPUs
--, CONVERT(MONEY, Round(physical_memory_in_bytes / 1073741824.0, 0)) AS TotalRAMInGB
FROM sys.dm_os_sys_info


SELECT cpu_count AS [Logical CPU Count], hyperthread_ratio AS Hyperthread_Ratio,
cpu_count/hyperthread_ratio AS Physical_CPU_Count,
physical_memory_in_bytes/1048576 AS Physical_Memory_in_MB,
sqlserver_start_time, affinity_type_desc -- (affinity_type_desc is only in 2008 R2)
FROM sys.dm_os_sys_info

select scheduler_id,cpu_id, status, is_online from sys.dm_os_schedulers where status='VISIBLE ONLINE'
select scheduler_id,cpu_id, status, is_online from sys.dm_os_schedulers where status='VISIBLE ONLINE' 

--- find node name in cluster
SELECT NodeName --, status_description, is_current_owner 
FROM sys.dm_os_cluster_nodes;


