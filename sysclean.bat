@echo off
REM ==================================================
REM ==================================================
REM ==                                              ==
REM ==                  @21.11.2016                 ==
REM ==                                              ==
REM ==      Created by GxGL (George Stamate)        ==
REM ==                                              ==
REM ==    The contents of this file is free to use  ==
REM == and distribute.                              ==
REM ==    This script was created to help the user  ==
REM == to run or do multiple tasks from one sigle   == 
REM == click.                                       ==
REM ==    With this idea in mind comes more good!   ==
REM ==                                              ==
REM ==    As a note: You need to run this file as   ==
REM == administrator if you want to get all done.   ==
REM ==                                              ==
REM ==================================================
REM ================================================== 

setlocal
cd /d %~dp0
cls
echo[
echo Detecting if you run this script as admin...
REM We use an alternative PAUSE since this is not recognized on some windows versions
ping 127.0.0.1 -n 5 -w 1000 >nul

NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO Administrator PRIVILEGES Detected!
	ping 127.0.0.1 -n 5 -w 1000 >nul goto Start
) ELSE (
    ECHO NOT AN ADMIN! Please run this script as administrator.
	ping 127.0.0.1 -n 5 -w 1000 >nul && GOTO END
)

:Start
cls
echo[
echo Cleaning up PreWindows10 Floders
echo ex. $Windows.~BT and $Windows.~WS
echo also Windows.old if you agree :)
echo[
ping 127.0.0.1 -n 5 -w 1000 >nul
cls

IF EXIST "C:\$Windows.~BT" (goto needtodelete) else (goto checkWindows.old)
IF EXIST "C:\$Windows.~WS" (goto needtodelete) else (goto checkWindows.old)


:checkWindows.old
IF EXIST "C:\Windows.old" (goto optional) else (goto notneedtodelete)

:optional
echo[
SET /P AREYOUSURE=Windows 10 downloaded files have been found. You want to delete them? (Y/[N])
IF /I "%AREYOUSURE%" NEQ "Y" GOTO notneedtodelete

:needtodelete
echo[
echo Cleaning up Windows 10 downloaded files...
FOR /D %%d IN ("C:\Windows.old\") DO @rd /s /q "%%d"
del C:\Windows.old\*.* /f /s /q
FOR /D %%d IN ("C:\$Windows.~BT\") DO @rd /s /q "%%d"
del C:\$Windows.~BT\*.* /f /s /q
FOR /D %%d IN ("C:\$Windows.~WS\") DO @rd /s /q "%%d"
del C:\$Windows.~WS\*.* /f /s /q
echo[
echo Done!
ping 127.0.0.1 -n 5 -w 1000 >nul
cls

:notneedtodelete
echo[
echo Windows 10 Downloaded files not found 
echo or You have selected not to delete them.
ping 127.0.0.1 -n 5 -w 1000 >nul
cls
echo[
echo Continuing... 
ping 127.0.0.1 -n 5 -w 1000 >nul
cls
echo[
echo Cleaning up Windows Updates
echo ==========================================
echo[
net stop wuauserv
echo[
rmdir %windir%\softwaredistribution /s /q
net start wuauserv
cls
echo[
echo Cleaning up Windows\Temp
echo ==========================================
echo[
FOR /D %%d IN ("%windir%\Temp\") DO @rd /s /q "%%d"
del %windir%\Temp\*.* /f /s /q
echo[
echo Done!
ping 127.0.0.1 -n 5 -w 1000 >nul
cls
echo[
echo Cleaning up User Temp and 
echo Temporary Internet Files directories
echo ==========================================
IF EXIST "%SystemDrive%\Users\" (
    for /D %%x in ("%SystemDrive%\Users\*") do ( 
        rd /s /q "%%x\AppData\Local\Temp" 
        md "%%x\AppData\Local\Temp" 
        rd /s /q "%%x\AppData\Local\Microsoft\Windows\Temporary Internet Files" 
        md "%%x\AppData\Local\Microsoft\Windows\Temporary Internet Files"
    )
)
echo[
echo Done!
ping 127.0.0.1 -n 5 -w 1000 >nul
cls
echo[
echo Cleaning up System Logs and Temps
echo ==========================================
del %SystemDrive%\*.log /a /s /q /f
del %SystemDrive%\*.tmp /a /s /q /f
del %SystemRoot%\*.log /a /s /q /f
del %SystemRoot%\*.tmp /a /s /q /f
del %SystemRoot%\System32\*.log /a /s /q /f
del %SystemRoot%\System32\*.tmp /a /s /q /f
del %SystemRoot%\System32\drivers\*.log /a /s /q /f
del %SystemRoot%\System32\drivers\*.tmp /a /s /q /f
del %SystemRoot%\System32\LogFiles\*.* /a /s /q /f
echo[
cls
echo[
echo Cleaning up Memory Dumps
echo ==========================================
FOR /D %%d IN ("%SystemRoot%\Minidump\") DO @rd /s /q "%%d"
del %SystemRoot%\Minidump\*.* /f /s /q
del %SystemRoot%\MEMORY.DMP
echo[
cls
echo[
echo Cleaning up all Internet Explorer
echo ==========================================
echo[
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 4351
ping 127.0.0.1 -n 5 -w 1000 >nul
cls
echo[
cls
echo[
echo Cleaning up Oldest Shadow Copies
echo ==========================================
echo[
vssadmin delete shadows /for=c: /Oldest /Quiet
vssadmin delete shadows /for=d: /Oldest /Quiet
ping 127.0.0.1 -n 5 -w 1000 >nul
cls
echo[
echo Done!
echo The script will now exit...
ping 127.0.0.1 -n 5 -w 1000 >nul

:END
echo[
cls
exit