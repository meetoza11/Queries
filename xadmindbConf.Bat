::batch script
:: first variable is server
:: second variable is job log location
:: third is the local backup directory
:: example
::		 xadmindbConf.bat it-s8mp-archdev F:\mssqladmin\jobs F:\mssqldata\10.0 backup
::
@ECHO OFF
For /f %%I IN ('dir /b I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\schemas\dbadmin.sql') DO sqlcmd -S %1 -i I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\schemas\%%I -d xadmindb -b
::IF  ERRORLEVEL 1  GOTO failure
For /f %%I IN ('dir /b I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\tables\*.sql') DO   sqlcmd -S %1 -i I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\tables\%%I -d xadmindb -b
::IF  ERRORLEVEL 1  GOTO failure
For /f %%I IN ('dir /b I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Constraints\*.sql') DO sqlcmd -S %1 -i I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Constraints\%%I -d xadmindb -b
::IF  ERRORLEVEL 1  GOTO failure
For /f %%I IN ('dir /b I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Indexes\*.sql') DO sqlcmd -S %1 -i I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Indexes\%%I -d xadmindb -b
::IF  ERRORLEVEL 1  GOTO failure
For /f %%I IN ('dir /b I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Views\*.sql') DO  sqlcmd -S %1 -i I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Views\%%I -d xadmindb -b
::IF  ERRORLEVEL 1  GOTO failure
For /f %%I IN ('dir /b I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Functions\*.sql') DO sqlcmd -S %1 -i I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Functions\%%I -d xadmindb -b
::IF  ERRORLEVEL 1  GOTO failure
For /f %%I IN ('dir /b I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Stored_Procedures\*.sql') DO  sqlcmd -S %1 -i I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Stored_Procedures\%%I -d xadmindb -b
::IF  ERRORLEVEL 1  GOTO failure
For /f %%I IN ('dir /b I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Alerts\*.sql') DO sqlcmd -S %1 -i I:\INF\DataArch\Projects\DBAMSSQL\ADMIN\admindb2005\Alerts\%%I -d xadmindb -b
::IF  ERRORLEVEL 1  GOTO failure
:: setup full backup job
::sqlcmd -S %1 -i DBAMSSQL\ADMIN\admindb2005\Jobs\Job_Daily_Backup_all.sqlcmd -v BackupDirectory="%2" JobLogFile="%3"


