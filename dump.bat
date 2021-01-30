@echo off

rem %1 = process name

for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%%ldt:~4,2%%ldt:~6,2%-%ldt:~8,2%%ldt:~10,2%

set base=%cd%\%1-%computername%-%ldt%

set dmp=%base%.dmp
set mmp=%base%.mmp
set gcdmp=%base%.gcdump
set zip=%base%.zip
set log=%base%.log

%cd%\procdump.exe -accepteula -ma -a -r %1 -w %dmp%

rem -- VMMap ---
rem %cd%\vmmap.exe -accepteula -p %1 %mmp%

rem -- GC Dump ---
rem %cd%\PerfView.exe -accepteula HeapSnapshotFromProcessDump %dmp% %gcdmp% -logfile:%log%

rem -- zip the report files
rem zip.exe -1j %zip% %gcdmp% %mmp% %log%

rem -- looks like zip.exe doesn't support setting the output filename!
rem start zip.exe -1j %dmp%.zip %dmp%
