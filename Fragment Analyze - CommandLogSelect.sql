SELECT DatabaseName,
       SchemaName,
       ObjectName,
       CASE WHEN ObjectType = 'U' THEN 'USER_TABLE' WHEN ObjectType = 'V' THEN 'VIEW' END AS ObjectType,
       IndexName,
       CASE WHEN IndexType = 1 THEN 'CLUSTERED' WHEN IndexType = 2 THEN 'NONCLUSTERED' WHEN IndexType = 3 THEN 'XML' WHEN IndexType = 4 THEN 'SPATIAL' END AS IndexType,
       PartitionNumber,
       ExtendedInfo.value('(ExtendedInfo/PageCount)[1]','int') AS [PageCount],
       ExtendedInfo.value('(ExtendedInfo/Fragmentation)[1]','float') AS Fragmentation,
       CommandType,
       Command,
       StartTime,
       EndTime,
       CASE WHEN DATEDIFF(ss,StartTime, EndTime)/(24*3600) > 0 THEN CAST(DATEDIFF(ss,StartTime, EndTime)/(24*3600) AS nvarchar) + '.' ELSE '' END + RIGHT(CONVERT(nvarchar,EndTime - StartTime,121),12) AS Duration,
       ErrorNumber,
       ErrorMessage
FROM dbo.CommandLog
WHERE CommandType = 'ALTER_INDEX'
ORDER BY StartTime ASC