@echo off
set LONMIN=-158
set LONMAX=14
set LATMIN=21
set LATMAX=50
set NMAX=25
for /l %%N in (0,1,%NMAX%) do call :GMT %%N %NMAX%
goto :eof

:GMT
echo %1 of %2
set FILE=000%1
if %1 geq 10 (set FILE=00%1)
if %1 geq 100 (set FILE=0%1)
if %1 geq 1000 (set FILE=%1)
set FILEDAT=%FILE%.dat
set FILEPS=%FILE%.ps
set /a LON=%LONMIN%+(%LONMAX%-%LONMIN%)*%1/%2
set /a LAT=%LATMIN%+(%LATMAX%-%LATMIN%)*%1/%2
gmt pscoast -JG%LON%/%LAT%/10c -R0/360/-90/90 -Bxg30 -Byg15 -B+t"%1 of %2" -Dc -Gsandybrown -Slightskyblue -P -K > %FILEPS%
gmt psxy ex02-line.dat -J -R -W1p,blue -O -K >> %FILEPS%
gmt psxy ex02-line.dat -J -R -Gyellow -Sc7p -W1p,blue -O -K >> %FILEPS%
gmt pstext ex02-text.dat -J -R -D0.25c/-0.4c -O >> %FILEPS%
gmt ps2raster %FILEPS% -P
goto :eof
