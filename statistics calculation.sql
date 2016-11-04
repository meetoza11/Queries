--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT 
	ss.name as schemaName
	, st.name as tableName
	, s.name as indexName
	, STATS_DATE(s.id, s.indid) as 'Statistics last Updated'
	, s.rowcnt as 'Row count'
	, s.rowmodctr as 'Number of Changes'
	, CAST((CAST(s.rowmodctr as DECIMAL(28,8))/CAST(s.rowcnt AS DECIMAL(28,2)) * 100.0)
			AS DECIMAL(28,2)) AS '% Row Changed'
	,GETDATE()
FROM sys.sysindexes s
INNER JOIN sys.tables st ON st.[object_id] = s.[id]
INNER JOIN sys.schemas ss ON ss.[schema_id] = st.[schema_id]
where s.id > 100
and s.indid > 0
and s.rowcnt > =500
order by schemaName, TableName, IndexName

