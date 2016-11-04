-- run this command from your comand line
-- this will generate MyData.csv file for you 

C:\>bcp "select top(100) * from CARS_Net.dbo.ActionType" queryout "C:\Users\doza\Desktop\INC999806\MyData.csv" -c -t"," -r"\n" -S DAC30144TSQL01\ORIGINATIONS -T


-- or use this one
C:\>sqlcmd -S DAC30144TSQL01\ORIGINATIONS -d Cars_net -E -Q "Select top(100) * from dbo.ActionType" -o "C:\Users\doza\Desktop\INC999806\MyData.csv"  -s"," -w 700

-- if you need result set in your output...
C:\>sqlcmd -S DENDWVCRPSQL04\Reporting01 -d Cars_net -E -Q "Select top(100) * from dbo.ActionType" -o "C:\Users\doza\Desktop\INC999806\MyData.csv" -h-1 -s"," -w 700

sqlcmd -s DENDWVCRPSQL04\REPORTING01 -e -d Salesforce -s ", "Select * from dbo.Exceltest" -o "C:\Users\doza\Desktop\INC999806\MyData.csv" -h -l -w 700


C:\>sqlcmd -S DENDWVCRPSQL04\Reporting01 -d Salesforce -E -Q "Select * from dbo.Exceltest" -o "C:\Users\doza\Desktop\MyData.csv" -h-1 -s"," -w 700
select * from [dbo].[ExcelTest]