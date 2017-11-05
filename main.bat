@echo off
Title Repairing Historian
color 2
net use x: /delete /y
cls
set LogFile=log.txt

for /f "tokens=3" %%a in ('reg query hkey_users\.default /v imageversion ^|findstr /ri "REG_SZ"') do (set image=%%a)
echo.********************************************************>%LogFile%
echo.                 Historian Repair Tool>>%LogFile%
echo.Running from %computername% : Image Version %image%>>%LogFile%
echo.********************************************************>>%LogFile%
echo.Current Time is :%time%>>%LogFile%
echo.Current Date is :%Date%>>%LogFile%
echo.>>%LogFile%

if "%1"=="" (set /p daysback="Enter how many days to keep: ") else (set daysback=%1)
echo.Keeping PIBUFQ_* and PIMQ* Files Newer than %daysback% days old>>%LogFile%

net use x: \\192.168.1.13\C$
psexec \\192.168.1.13 -c -f resources\FTLD_Stop_and_Delete.bat %daysback%
copy x:\HISTREP.txt %~dp0
copy /b %LogFile%+HISTREP.txt %LogFile%
del x:\HISTREP.txt
net use x: /delete /y

net use x: \\192.168.1.20\C$
psexec \\192.168.1.20 -c -f resources\FTLD_Stop_and_Delete.bat %daysback%
copy x:\HISTREP.txt %~dp0
copy /b %LogFile%+HISTREP.txt %LogFile%
del x:\HISTREP.txt
net use x: /delete /y

net use x: \\192.168.1.14\C$
psexec \\192.168.1.14 -c -f resources\Buffer_Repair.bat %daysback%
copy x:\HISTREP.txt %~dp0
copy /b %LogFile%+HISTREP.txt %LogFile%
del x:\HISTREP.txt
net use x: /delete /y

net use x: \\192.168.1.13\C$
psexec \\192.168.1.13 -c -f resources\FTLD_Start.bat
copy x:\HISTREP.txt %~dp0
copy /b %LogFile%+HISTREP.txt %LogFile%
del x:\HISTREP.txt
net use x: /delete /y

net use x: \\192.168.1.20\C$
psexec \\192.168.1.20 -c -f resources\FTLD_Start.bat
copy x:\HISTREP.txt %~dp0
copy /b %LogFile%+HISTREP.txt %LogFile%
del x:\HISTREP.txt
net use x: /delete /y

del HISTREP.txt

Title "All Finished"
echo.All Finished.
echo.All Finished.>>%LogFile%
echo.********************************************************>>%LogFile%
echo.>>%LogFile%
echo.>>%LogFile%
echo.>>%LogFile%
echo.>>%LogFile%

pause
