@echo off
Title "Stopping Data Links and Deleting FTLD & PIBUFQ Files"
net stop ftld1
net stop pibufss
del /q /f c:\progra~1\rockwe~1\factor~1\pipc\interfaces\ftld*
del /q /f c:\progra~2\rockwe~1\factor~2\pipc\interfaces\ftld*
if not exist "c:\progra~1\rockwe~1\factor~1\pipc\pibufq_Backup" mkdir "c:\progra~1\rockwe~1\factor~1\pipc\pibufq_Backup"
if not exist "c:\progra~2\rockwe~1\factor~2\pipc\pibufq_Backup" mkdir "c:\progra~2\rockwe~1\factor~2\pipc\pibufq_Backup"
forfiles /p c:\progra~1\rockwe~1\factor~1\pipc\dat /m pibufq_*.* /d -%1% /c "cmd /c del @file"
forfiles /p c:\progra~1\rockwe~1\factor~1\pipc\pibufq_Backup /m pibufq_*.* /c "cmd /c del @file"
forfiles /p c:\progra~1\rockwe~1\factor~1\pipc\dat /m pibufq_*.* /c "cmd /c move @file ..\pibufq_Backup\@file"
forfiles /p c:\progra~2\rockwe~1\factor~2\pipc\dat /m pibufq_*.* /d -%1% /c "cmd /c del @file"
forfiles /p c:\progra~2\rockwe~1\factor~2\pipc\pibufq_Backup /m pibufq_*.* /c "cmd /c del @file"
forfiles /p c:\progra~2\rockwe~1\factor~2\pipc\dat /m pibufq_*.* /c "cmd /c move @file ..\pibufq_Backup\@file"
