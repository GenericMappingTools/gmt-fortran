@echo off
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
gmt gmtmath -T0/6.283185/0.00006283185 T 6.283185 %1 MUL %2 DIV ADD SIN = | psxy -JX15c/10c -R0/7/-1/1 -Bx1+lx -By0.5+ly -BWS+t"time = %1 of %2" -Sc0.15c -N > %FILEPS%
: gmt gmtmath -T0/6.283185/0.00006283185 T 6.283185 %1 MUL %2 DIV ADD SIN = > %FILEDAT%
: gmt psxy %FILEDAT% -JX15c/10c -R0/7/-1/1 -Bx1+lx -By0.5+ly -BWS+t"time = %1 of %2" -Sc0.15c -N > %FILEPS%
: gmt ps2raster %FILEPS% -P
goto :eof
