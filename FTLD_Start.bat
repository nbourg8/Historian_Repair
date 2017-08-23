@echo off
Title "Restarting Historian"

net start ftldint1
net start ftld1
echo test start to log file > %1