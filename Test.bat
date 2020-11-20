@echo off
:: Check for PsShutdown
WHERE psshutdown >nul 2>nul
if %ERRORLEVEL% neq 0 (
	echo PsShutdown wasn't found.
	echo Get it from Microsoft at https://docs.microsoft.com/en-us/sysinternals/downloads/psshutdown
	pause
	exit
) else (
	echo PsShutdown installed correctly
)
pause
:: Ensure proper wakeup is detected
Echo "Put your PC to sleep and wake it up as you usually do."
pause
cd %~dp0
powercfg -lastwake > %~dp0lastwake.temp
for /f "delims=" %%x in (%~dp0lastwake.temp) do set lastwake=%%x
:: Remove all spaces
set lastwake=%lastwake: =%
del %~dp0lastwake.temp
if "%lastwake%" == "PowerButton" (
	echo User wakeup detected. NeverWake should work without issue.
) ELSE (
	if "%lastwake:~0,15%" == "WakeSourceCount" (
		:: Hibernate wakeup fires a troubleshooter event
		:: But clears the wakeup reasons instead of logging a new one
		echo User wakeup detected. NeverWake should work without issue.
		goto END
	)
	echo Improper wakeup detected. Wakeup type "%lastwake%".
	echo If this type should be treated as correct, report it as an issue on Github.
)
:END
pause