@echo off
if not "%username%"=="canrigadmin" (goto failed_username)
Title Repairing Historian
color 2
cls
if not exist "c:\Canrig" mkdir "c:\Canrig"
if not exist "c:\Canrig\LogFolder" mkdir "c:\Canrig\LogFolder"
set LogFile="c:\Canrig\LogFolder\Historian_Repair_Log.txt"
for /f "tokens=3" %%a in ('reg query hkey_users\.default /v imageversion ^|findstr /ri "REG_SZ"') do (set image=%%a)
echo.********************************************************>>%LogFile% 2>&1
echo.Historian Repair tool running from %computername% Image %image%>>%LogFile% 2>&1
echo.Tool Location: %~dp0 >>%LogFile% 2>&1
echo.********************************************************>>%LogFile% 2>&1
echo. |time |find "current" >>%LogFile% 2>&1
echo. |date |find "current" >>%LogFile% 2>&1
echo.>>%LogFile% 2>&1
if "%1"=="" (set /p daysback="Enter how many days to keep: ") else (set daysback=%1)
echo.
echo.>>%LogFile% 2>&1
echo.Cleaning Primary HMI Server 192.168.1.13...
echo.Cleaning Primary HMI Server 192.168.1.13...>>%LogFile% 2>&1
psexec \\192.168.1.13 -c FTLD_Stop_and_Delete.bat %daysback%
echo.Cleaning Secondary HMI Server 192.168.1.20...
echo.Cleaning Secondary HMI Server 192.168.1.20...>>%LogFile% 2>&1
psexec \\192.168.1.20 -c FTLD_Stop_and_Delete.bat %daysback%
echo.Cleaning Historian 192.168.1.14...
echo.Cleaning Historian 192.168.1.14...>>%LogFile% 2>&1
echo.
echo.Deleting files older than %daysback% days from today
echo.Deleting files older than %daysback% days from today>>%LogFile% 2>&1
psexec \\192.168.1.14 -c Buffer_Repair.bat %daysback%
echo.
echo.>>%LogFile% 2>&1
echo.Starting FTDL Services on Primary HMI 192.168.1.13
echo.Starting FTDL Services on Primary HMI 192.168.1.13>>%LogFile% 2>&1
psexec \\192.168.1.13 -c FTLD_Start.bat
echo.Starting FTDL Services on Secondary HMI 192.168.1.20
echo.Starting FTDL Services on Secondary HMI 192.168.1.20>>%LogFile% 2>&1
psexec \\192.168.1.20 -c FTLD_Start.bat
echo.All Finished.
echo.All Finished.>>%LogFile% 2>&1
Title "All Finished"
echo.********************************************************
echo.********************************************************>>%LogFile% 2>&1
echo.>>%LogFile% 2>&1
echo.>>%LogFile% 2>&1
echo.>>%LogFile% 2>&1
echo.>>%LogFile% 2>&1
goto program_end
:failed_username
echo.Must be logged in as CanrigAdmin
:program_end
pause
