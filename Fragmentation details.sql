DBCC INDEXDEFRAG ('tablename', 'schema.indexname')
DBCC SHOWCONTIG ('dbo.tablename') with no_infomsgs

SELECT
B.name AS TableName
, C.name AS IndexName
, C.fill_factor AS IndexFillFactor
, D.rows AS RowsCount
, A.avg_fragmentation_in_percent
, A.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(),NULL,NULL,NULL,NULL) A
INNER JOIN sys.objects B with (nolock)
ON A.object_id = B.object_id
INNER JOIN sys.indexes C with (nolock)
ON B.object_id = C.object_id AND A.index_id = C.index_id
INNER JOIN sys.partitions D with (nolock)
ON B.object_id = D.object_id AND A.index_id = D.index_id
WHERE C.index_id > 0
and A.avg_fragmentation_in_percent > 30
--and A.OBJECT_ID = OBJECT_ID('dbo.LogAudit')

--select top (10) * from sys.dm_db_index_physical_stats (DB_ID(),NULL,NULL,NULL,NULL)
--select top (10) * from sys.objects
--select top (10) * from sys.indexes
--select top (10) * from sys.partitions
