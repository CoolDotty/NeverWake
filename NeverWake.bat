@echo off
cd %~dp0
powercfg -lastwake > %~dp0lastwake.temp
for /f "delims=" %%x in (%~dp0lastwake.temp) do set lastwake=%%x
:: Remove all spaces
set lastwake=%lastwake: =%
del %~dp0lastwake.temp
if "%lastwake%" == "PowerButton" (
	echo Good Wake
) ELSE (
	psshutdown -d -t 0 -accepteula
)
