-- Get Drive Size and Drive Free Space
declare @Drive table(DriveName char,freespace decimal(9,2), totalspace decimal(9,2),percentfree decimal(9,2))

BEGIN 

    SET NOCOUNT ON;

    DECLARE @v_cmd nvarchar(255)
    ,@v_drive char(99)
    ,@v_sql nvarchar(255)
    ,@i int

    SELECT @v_cmd = 'fsutil volume diskfree %d%'
    SET @i = 1

    -- Creating temporary tables to retrive system space information.
    CREATE TABLE #Devendrives(iddrive smallint ,drive char(99))

    CREATE TABLE #Deventemp1(drive char(99),shellCmd nvarchar(500));

    CREATE TABLE #Devenresults(drive char(99),freespace decimal(9,2), totalspace decimal(9,2));


    INSERT #Devendrives (drive) 

    EXEC master..xp_cmdshell 'mountvol'

    DELETE #Devendrives WHERE drive not like '%:\%' or drive is null


    WHILE (@i <= (SELECT count(drive) FROM #Devendrives))

    BEGIN

         UPDATE #Devendrives 
         SET iddrive=@i
         WHERE drive = (SELECT TOP 1 drive FROM #Devendrives WHERE iddrive IS NULL)

         SELECT @v_sql = REPLACE(@v_cmd,'%d%',LTRIM(RTRIM(drive))) from #Devendrives where iddrive=@i

         INSERT #Deventemp1(shellCmd) 
         EXEC master..xp_cmdshell @v_sql

         UPDATE #Deventemp1 
         SET #Deventemp1.drive = d.drive
         FROM #Devendrives d
         WHERE #Deventemp1.drive IS NULL and iddrive=@i

        SET @i = @i + 1

    END


        INSERT INTO #Devenresults
        SELECT bb.drive
        ,CAST(CAST(REPLACE(REPLACE(SUBSTRING(shellCmd,CHARINDEX(':',shellCmd)+1,LEN(shellCmd)),SPACE(1),SPACE(0))
        ,char(13),SPACE(0)) AS NUMERIC(32,2))/1024/1024/1024 AS DECIMAL(9,2)) as freespace
        ,tt.titi as total
        FROM #Deventemp1 bb
        JOIN (SELECT drive
        ,CAST(CAST(REPLACE(REPLACE(SUBSTRING(shellCmd,CHARINDEX(':',shellCmd)+1,LEN(shellCmd)),SPACE(1),SPACE(0))
        ,char(13),SPACE(0)) AS NUMERIC(32,2))/1024/1024/1024 AS DECIMAL(9,2)) as titi
        FROM #Deventemp1
        WHERE drive IS NOT NULL
        AND shellCmd NOT LIKE '%free bytes%') tt
        ON bb.drive = tt.drive
        WHERE bb.drive IS NOT NULL
        AND bb.shellCmd NOT LIKE '%avail free bytes%'
        AND bb.shellCmd LIKE '%free bytes%';

    -- getting all system specific formatted data into @Drive table
    INSERT INTO @Drive
    SELECT LEFT(RTRIM(LTRIM(drive)),1) as drive
     ,freespace
     ,totalspace
     ,CAST((freespace/totalspace * 100) AS DECIMAL(5,2)) as [percent free]
    FROM #Devenresults
    ORDER BY drive

    -- Dropping temporary tables
    DROP TABLE #Devendrives
    DROP TABLE #Deventemp1
    DROP TABLE #Devenresults

    SELECT 
         @@Servername as Server,
         sd.name as Database_name,
        mas.name as File_Name, 
        mas.size * 8 / 1024 File_Size_MB,
        CASE [is_percent_growth]   
               WHEN 1 THEN CAST(mas.growth AS varchar(20)) + '%'  
                ELSE CAST(mas.growth*8/1024 AS varchar(20)) + ' MB'  
        END as Growth_rate,      
        drv.DriveName as Drive_Name, 
        drv.FreeSpace,
        drv.totalspace,
        CASE type
               WHEN 0 THEN 'Data'   
               WHEN 1 THEN 'Log'  
        END as File_type,  
        mas.physical_name as File_Location 
    FROM sys.master_files mas
    LEFT JOIN @Drive drv ON LEFT(mas.physical_name, 1) = drv.DriveName
    LEFT JOIN sys.databases sd ON mas.database_id = sd.database_id
    --WHERE sd.name IN ('db1','db2','db3') -- Specify the database name if this report is needed for specific databases
    --AND mas.growth <>0 -- Condition to retrive the record for growing files only.

END
