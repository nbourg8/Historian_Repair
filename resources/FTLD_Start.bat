@echo off
set LogFile=c:\HISTREP.txt
Title "%computername% : Restarting Data Links"

for /f "tokens=3" %%a in ('reg query hkey_users\.default /v imageversion ^|findstr /ri "REG_SZ"') do (set image=%%a)
for /f "tokens=14" %%a in ('ipconfig ^|findstr /ri "IPv4"') do (set network=%%a)

echo.________________________________________________________>%LogFile%
echo.%network% - %computername% - %image% - %date% %time%>>%LogFile%

echo.Starting FTLDint1>>%LogFile%
net start ftldint1
