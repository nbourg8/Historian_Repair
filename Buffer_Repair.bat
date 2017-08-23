@echo off
Title "Buffer Repairing"
taskkill /f /im piartool.exe
net stop piarchss
net stop pisnapss
if not exist "c:\progra~1\rockwe~1\factor~1\server\evq" mkdir "c:\progra~1\rockwe~1\factor~1\server\evq"
forfiles /p c:\progra~1\rockwe~1\factor~1\server\dat /m pimq*.* /d -%1% /c "cmd /c del @file"
forfiles /p c:\progra~1\rockwe~1\factor~1\server\evq /m pimq*.* /c "cmd /c del @file"
forfiles /p c:\progra~1\rockwe~1\factor~1\server\dat /m pimq*.* /c "cmd /c move @file ..\evq\@file"
net start pisnapss
net start piarchss
