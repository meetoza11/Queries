:connect RCHPWVMGMSQL01.prod.corpint.net\MANAGEMENT01

USE DBA

select 
'New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\MSSQLServer\Client\ConnectTo" -Name "' + [alias] + '" -PropertyType String -Value "DBMSSOCN,' + [instance_name] + ',' + [port] + '"'
from vw_CurrentInstances 

--- Note 1: Make sure you have HKLM:\SOFTWARE\Wow6432Node\Microsoft\MSSQLServer\Client\ConnectTo path in your registry (REGEDIT)
--- Note 2: Copy result and run into powershell