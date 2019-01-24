@echo off 

rem %1 = process
rem %2 = out

rem dump filename: <server>-<timestamp>-<process>

for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%%ldt:~4,2%%ldt:~6,2%-%ldt:~8,2%%ldt:~10,2%

set base=%cd%\%computername%-%ldt%-%1

powershell.exe "Get-Process '%1' | %% { .\procdump.exe $_.Id '%base%' }"
