
"`n"
write-Host "---------------------------------------------" -ForegroundColor Yellow
cd \\RCHPWVMGMSQL01.prod.corpint.net\sqlimplementations$\dba\run
#$filePath = Read-Host "Please Enter Folder Path to Search"  "For Ex. \\RCHPWVMGMSQL01.prod.corpint.net\sqlimplementations$\dba\run"
write-Host "---------------------------------------------" -ForegroundColor Green
$fileName = Read-Host "Please Enter Folder Name to Search"
write-Host "---------------------------------------------" -ForegroundColor Yellow
"`n"

Get-ChildItem -Recurse -Force $filePath -ErrorAction SilentlyContinue | Where-Object { ($_.PSIsContainer -eq $true) -and  ( $_.Name -like "*$fileName*") } | Select-Object Name,FullName | format-Table * -AutoSize

write-Host "------------END of Result--------------------" -ForegroundColor Magenta



