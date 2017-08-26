@echo off
color 2
cls
set LogFile=C:\Users\nbourg8\Desktop\Nabors_Tools\Historian_Repair_Tool\test\test.txt

echo.********************************************************>%LogFile%
echo.                 Historian Repair Tool>>%LogFile%
echo.Running from %computername% : Image Version 2.0.1.0_C009>>%LogFile%
echo.********************************************************>>%LogFile%
echo.Current Time is: %time%>>%LogFile%
echo.Current Date is: %Date%>>%LogFile%
echo.>>%LogFile%

if "%1"=="" (set /p daysback="Enter how many days to keep: ") else (set daysback=%1)
echo.Keeping PIBUFQ_* and PIMQ* Files Newer than %daysback% days old>>%LogFile%

net use x: \\10.10.10.2\C$
psexec \\10.10.10.2 -c remote.bat %daysback%
copy x:\HISTREP.txt %~dp0
copy /b %LogFile%+HISTREP.txt %LogFile%
del x:\HISTREP.txt
net use x: /delete /y

del HISTREP.txt

pause