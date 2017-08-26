@echo off
set LogFile=c:\HISTREP.txt
Title "%computername% : Stopping Data Links and Deleting FTLD & PIBUFQ Files"

for /f "tokens=14" %%a in ('ipconfig ^|findstr /ri "IPv4"') do (set network=%%a)

echo.________________________________________________________>%LogFile%
echo.%network% - %computername% - image - %date% %time%>>%LogFile%

