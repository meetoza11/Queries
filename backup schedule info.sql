--select database_name,type,backup_start_date,backup_finish_date,physical_device_name 
--from msdb.dbo.backupset bs join msdb.dbo.backupmediafamily bmf 
--on bs.media_set_id = bmf.media_set_id
--where type ='d'
--order by backup_finish_date desc

select database_name,type,backup_start_date,backup_finish_date,physical_device_name 
from msdb.dbo.backupset bs join msdb.dbo.backupmediafamily bmf 
on bs.media_set_id = bmf.media_set_id
where --database_name = 'WellHealth_0' and 
backup_start_date > getdate() -1
and type = 'L'
and physical_device_name like '%legato%'
order by backup_finish_date desc


SELECT  [rs].[destination_database_name] ,
        [rs].[restore_date] ,
        [bs].[backup_start_date] ,
        [bs].[backup_finish_date] ,
        [bs].[database_name] AS [source_database_name] ,
        [bmf].[physical_device_name] AS [backup_file_used_for_restore]
FROM    msdb..restorehistory rs
        INNER JOIN msdb..backupset bs ON [rs].[backup_set_id] = [bs].[backup_set_id]
        INNER JOIN msdb..backupmediafamily bmf ON [bs].[media_set_id] = [bmf].[media_set_id]
WHERE rs.destination_database_name like '%WellHealth_integration_litespeed%'
ORDER BY [rs].[restore_date] DESC



--- backup completion percentage 
SELECT session_id as SPID, command, a.text AS Query, start_time, percent_complete, dateadd(second,estimated_completion_time/1000, getdate()) as estimated_completion_time 
FROM sys.dm_exec_requests r CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) a 
WHERE r.command in ('BACKUP DATABASE','RESTORE DATABASE')

--- restore completion percentage
SELECT percent_complete, *
FROM sys.dm_exec_requests
WHERE command In ( 'RESTORE DATABASE', 'BACKUP DATABASE' )

--- Backup using Litespeed software
--EXECUTE [dbo].[DatabaseBackup] @Databases = 'WellHealth_Monitor', @Directory = N'N:\MSSQLDATA\Backup', @BackupType = 'FULL', @Verify = 'Y', @CleanupTime = 336, @CheckSum = 'Y', @LogToTable = 'Y'" -b

EXECUTE [dbo].[DatabaseBackup] @Databases = 'WellHealth_Monitor', @Directory = N'H:\litespeed test, I:\litespeed test, N:\litespeed test', @BackupType = 'FULL', @BackupSoftware = 'LITESPEED', @Compress = 'Y', @NumberOfFiles = 3, @Verify = 'Y', @CheckSum = 'Y', @LogToTable = 'Y'

EXECUTE [dbo].[DatabaseBackup] @Databases = 'xadmindb', @Directory = N'R:\backup, V:\backup, W:\backup', @BackupType = 'FULL', @BackupSoftware = 'LITESPEED', @Compress = 'Y', @NumberOfFiles = 3, @Verify = 'Y', @CheckSum = 'Y', @LogToTable = 'Y'

--select database_name,type,backup_start_date,backup_finish_date,physical_device_name 
--from msdb.dbo.backupset bs join msdb.dbo.backupmediafamily bmf 
--on bs.media_set_id = bmf.media_set_id JOIN master.dbo.sysdatabases sd 
--on sd.name = bs.database_name
--where backup_start_date >=   DateAdd(Day, Datediff(Day,0, GetDate() -1), 0) and backup_start_date < DateAdd(Day, Datediff(Day,0, GetDate()), 0)
--and physical_device_name like 'Legato%'


----type
----D is full backup for both
----I is diff for only for native
----L is incremental only for native

----Begin Tran
----USE xadmindb
--IF OBJECT_ID(N'tempdb..#temp_LegatobackupCheck') IS NOT NULL
--DROP TABLE tempdb..#temp_LegatobackupCheck
----ELSE
--Create table #temp_LegatobackupCheck
--(
--database_name varchar(30) null,
--backuptype varchar (1) null,
--backupStartDate datetime,
--backupFinishDate datetime,
--physicalDeviceName varchar(100) null
--)
--insert into #temp_LegatobackupCheck
--select database_name,type,backup_start_date,backup_finish_date,physical_device_name 
--from msdb.dbo.backupset bs join msdb.dbo.backupmediafamily bmf 
--on bs.media_set_id = bmf.media_set_id 
--where backup_start_date > getdate()-1
--and physical_device_name like 'Legato%'
--Declare @QueryValue int
--select @queryValue = count(*) from #temp_LegatobackupCheck

--IF @QueryValue < 20
--BEGIN	
--EXEC msdb.dbo.sp_send_dbmail
--    @profile_name = 'DBA Profile' 
--   ,@recipients = 'deven.oza@walgreens.com;'      
--   ,@subject = 'Check Legato Backup'; 
--END
--ELSE
--	PRINT 'NO NEED TO SEND EMAIL'
----Rollback




--DECLARE @query_result_separator CHAR(1) = char(9);
--EXEC msdb.dbo.sp_send_dbmail
--    @profile_name = 'DBA Profile' 
--   ,@recipients = 'deven.oza@walgreens.com;'      
--   ,@query = 'select database_name,type,backup_start_date,backup_finish_date,physical_device_name 
--from msdb.dbo.backupset bs join msdb.dbo.backupmediafamily bmf 
--on bs.media_set_id = bmf.media_set_id 
--where backup_start_date >= getdate()-2
--and physical_device_name like ''Legato%'''
--   ,@subject = 'Server Connections' 
--   ,@query_result_separator = @query_result_separator
--   ,@query_attachment_filename= 'Report.CSV'
--   ,@attach_query_result_as_file = 1 ;   
--GO



--select getdate()-1



--select  DateAdd(Day, Datediff(Day,0, GetDate()), 0)

----and database_name in ('WellHealth_0', 'WellHealth_1', 'WellHealth_2')
--and sd.database_id > 4
----order by database_name, backup_finish_date desc

--CONVERT(VARCHAR(8), GETDATE()-1, 1)
--SELECT CONVERT(VARCHAR(8), GETDATE(), 1) AS [MM/DD/YY]

--select * from msdb.dbo.backupset

--select * from msdb.dbo.sysdatabases 
--Select * 
--From sys.databases 
--Where database_id > 5

--Select * 
--From sys.databases 
--Where len(owner_sid)>1

----SELECT * FROM msdb.dbo.backupset

--select database_name,type,backup_start_date,backup_finish_date,physical_device_name 
--from msdb.dbo.backupset bs join msdb.dbo.backupmediafamily bmf 
--on bs.media_set_id = bmf.media_set_id
--where backup_start_date > '2014-07-22 12:46:17.000'
----and physical_device_name like 'Legato%'
--and database_name = 'wellhealth_blob'
--and type = 'D'
--order by database_name, backup_finish_date desc


----select distinct type
----from msdb.dbo.backupset bs join msdb.dbo.backupmediafamily bmf 
----on bs.media_set_id = bmf.media_set_id
----where backup_start_date > '2014-07-24 12:46:17.000'
------and physical_device_name like 'Legato%'
----and database_name = 'wellhealth_blob'
----order by database_name, backup_finish_date desc


--select * from sys.databases

--select database_name,type,backup_start_date,backup_finish_date,physical_device_name 
--from msdb.dbo.backupset bs join msdb.dbo.backupmediafamily bmf 
--on bs.media_set_id = bmf.media_set_id
--where 
----type ='d'
--backup_finish_date > '2014-01-21 23:59:00.000' 
----and database_name = 'wellhealth_blob'
----and 
--physical_device_name like 'Legato%'
----order by backup_finish_date desc
--order by database_name 


--select bs.backup_finish_date as recovery_point,database_name , * from msdb.dbo.restorehistory bh
--join msdb.dbo.backupset bs
--on bh.backup_set_id = bs.backup_set_id
--order by restore_date desc


--select name, backup_start_date, backup_finish_date, type,
--* from msdb.dbo.backupset b where name like '%well%' and type in ('i', 'l', 'd')
--order by b.backup_start_date


----sp_readerrorlog 6,1, 'connection pooling'

--select bs.backup_finish_date as recovery_point,database_name , * from msdb.dbo.restorehistory bh
--join msdb.dbo.backupset bs
--on bh.backup_set_id = bs.backup_set_id

--order by restore_date desc


--select name, backup_start_date, backup_finish_date, type,
--* from msdb.dbo.backupset b where name like '%well%' and type in ('i', 'l', 'd')
--order by b.backup_start_date


----sp_readerrorlog 6,1, 'connection pooling'
