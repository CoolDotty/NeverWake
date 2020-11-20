@echo off
cd %~dp0
powercfg -lastwake > %~dp0lastwake.temp
for /f "delims=" %%x in (%~dp0lastwake.temp) do set lastwake=%%x
:: Remove all spaces
set lastwake=%lastwake: =%
del %~dp0lastwake.temp
if "%lastwake%" == "PowerButton" (
	echo Good Wake
	exit 0
) ELSE (
	if "%lastwake:~0,15%" == "WakeSourceCount" (
		:: Hibernate wakeup fires a troubleshooter event
		:: But clears the wakeup reasons instead of logging a new one
		echo Hibernate Wake
		exit 0
	)
	psshutdown -d -t 0 -accepteula
	exit 1
)
