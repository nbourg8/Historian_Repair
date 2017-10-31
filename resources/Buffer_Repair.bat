@echo off
set LogFile=c:\HISTREP.txt
Title "%computername% : Killing all running Piartool.exe processes"

for /f "tokens=3" %%a in ('reg query hkey_users\.default /v imageversion ^|findstr /ri "REG_SZ"') do (set image=%%a)
for /f "tokens=14" %%a in ('ipconfig ^|findstr /ri "IPv4"') do (set network=%%a)

echo.________________________________________________________>%LogFile%
echo.%network% - %computername% - %image% - %date% %time%>>%LogFile%

taskkill /f /im piartool.exe
echo.Stopping piarchss>>%LogFile%
net stop piarchss
echo.Stopping pisnapss>>%LogFile%
net stop pisnapss

if not exist "c:\progra~1\rockwe~1\factor~1\server\evq" mkdir "c:\progra~1\rockwe~1\factor~1\server\evq"
echo.>>%LogFile%

echo.Deleting:>>%LogFile%
if exist c:\progra~1\rockwe~1\factor~1\server\dat\pimq* (forfiles /p c:\progra~1\rockwe~1\factor~1\server\dat /m pimq* /d -%1% /c "cmd /c echo @file">>%LogFile%)
if exist c:\progra~1\rockwe~1\factor~1\server\dat\pimq* (forfiles /p c:\progra~1\rockwe~1\factor~1\server\dat /m pimq* /d -%1% /c "cmd /c del @file")
del /f /q c:\progra~1\rockwe~1\factor~1\server\evq\*
echo.>>%LogFile%

echo.Moving:>>%LogFile%
if exist c:\progra~1\rockwe~1\factor~1\server\dat\pimq* (forfiles /p c:\progra~1\rockwe~1\factor~1\server\dat /m pimq* /c "cmd /c echo @file">>%LogFile%)
if exist c:\progra~1\rockwe~1\factor~1\server\dat\pimq* (forfiles /p c:\progra~1\rockwe~1\factor~1\server\dat /m pimq* /c "cmd /c move @file ..\evq\@file")
echo.>>%LogFile%

echo.Starting pisnapss>>%LogFile%
net start pisnapss
echo.Starting piarchss>>%LogFile%
net start piarchss
