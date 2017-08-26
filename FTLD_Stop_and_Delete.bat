@echo off
set LogFile=c:\HISTREP.txt
Title "%computername% : Stopping Data Links and Deleting FTLD & PIBUFQ Files"

for /f "tokens=3" %%a in ('reg query hkey_users\.default /v imageversion ^|findstr /ri "REG_SZ"') do (set image=%%a)
for /f "tokens=14" %%a in ('ipconfig ^|findstr /ri "IPv4"') do (set network=%%a)

echo.________________________________________________________>%LogFile%
echo.%network% - %computername% - %image% - %date% %time%>>%LogFile%

echo.Stopping FTLDint1>>%LogFile%
net stop ftldint1
echo.Stopping Pibufss>>%LogFile%
echo.>>%LogFile%
net stop pibufss

echo.Deleting:>>%LogFile%
if exist c:\progra~1\rockwe~1\factor~1\pipc\interfaces\ftld* (forfiles /p c:\progra~1\rockwe~1\factor~1\pipc\interfaces\ /m ftld* /d -%1% /c "cmd /c echo @file">>%LogFile% && del /q /f c:\progra~1\rockwe~1\factor~1\pipc\interfaces\ftld*)
if exist c:\progra~2\rockwe~1\factor~2\pipc\interfaces\ftld* (forfiles /p c:\progra~2\rockwe~1\factor~2\pipc\interfaces\ /m ftld* /d -%1% /c "cmd /c echo @file">>%LogFile% && del /q /f c:\progra~2\rockwe~1\factor~2\pipc\interfaces\ftld*)

echo.>>%LogFile%

if exist c:\progra~1\rockwe~1\factor~1\pipc\dat\pibufq_* (if not exist c:\progra~1\rockwe~1\factor~1\pipc\pibufq_Backup mkdir c:\progra~1\rockwe~1\factor~1\pipc\pibufq_Backup)
if exist c:\progra~2\rockwe~1\factor~2\pipc\dat\pibufq_* (if not exist c:\progra~2\rockwe~1\factor~2\pipc\pibufq_Backup mkdir c:\progra~2\rockwe~1\factor~2\pipc\pibufq_Backup)

echo.Deleting:>>%LogFile%
if exist c:\progra~1\rockwe~1\factor~1\pipc\dat\pibufq_* (forfiles /p c:\progra~1\rockwe~1\factor~1\pipc\dat\ /m pibufq_* /d -%1% /c "cmd /c echo @file">>%LogFile% && forfiles /p c:\progra~1\rockwe~1\factor~1\pipc\dat /m pibufq_* /d -%1% /c "cmd /c del @file" && forfiles /p c:\progra~1\rockwe~1\factor~1\pipc\pibufq_Backup /m pibufq_* /c "cmd /c del @file")
if exist c:\progra~2\rockwe~1\factor~2\pipc\dat\pibufq_* (forfiles /p c:\progra~2\rockwe~1\factor~2\pipc\dat\ /m pibufq_* /d -%1% /c "cmd /c echo @file">>%LogFile% && forfiles /p c:\progra~2\rockwe~1\factor~2\pipc\dat /m pibufq_* /d -%1% /c "cmd /c del @file" && forfiles /p c:\progra~2\rockwe~1\factor~2\pipc\pibufq_Backup /m pibufq_* /c "cmd /c del @file")
echo.>>%LogFile%

echo.Moving to ..\pibufq_Backup:>>%LogFile%
if exist c:\progra~1\rockwe~1\factor~1\pipc\dat\pibufq_* (forfiles /p c:\progra~1\rockwe~1\factor~1\pipc\dat\ /m pibufq_* /c "cmd /c echo @file">>%LogFile% && forfiles /p c:\progra~1\rockwe~1\factor~1\pipc\dat\ /m pibufq_* /c "cmd /c move @file ..\pibufq_Backup\@file")
if exist c:\progra~2\rockwe~1\factor~2\pipc\dat\pibufq_* (forfiles /p c:\progra~2\rockwe~1\factor~2\pipc\dat\ /m pibufq_* /c "cmd /c echo @file">>%LogFile% && forfiles /p c:\progra~2\rockwe~1\factor~2\pipc\dat\ /m pibufq_* /c "cmd /c move @file ..\pibufq_Backup\@file")
