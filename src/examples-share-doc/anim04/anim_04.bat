:               GMT ANIMATION 04
:               $Id$
:
: Purpose:      Make DVD-res Quicktime movie of NY to Miami flight
: GMT progs:    gmt gmtset, gmt gmtmath, gmt psbasemap, gmt pstext, gmt psxy, gmt ps2raster
: Unix progs:   awk, mkdir, rm, mv, echo, qt_export, cat
: Note:         Run with any argument to build movie; otherwise 1st frame is plotted only.

@echo off
setlocal enabledelayedexpansion
: path to ImageMagick's convert
set IMAGEMAGICK="C:\Program Files\ImageMagick-6.8.8-Q16"
: if not exist %IMAGEMAGICK%\convert.exe echo ImageMagick's convert not found
: input data file
set input=USEast_Coast.nc
if not exist %input% ( echo %0: Input file %input% not found & exit /b )

: 1. Initialization
: 1a) Assign movie parameters
set REGION=-Rg
set altitude=160.0
set tilt=55
set azimuth=210
set twist=0
set Width=36.0
set Height=34.0
set px=7.2
set py=4.8
set dpi=100
set name=anim_04
set ps=%name%.ps
: directory for saved frames
set dir=frames
: random name for temporary files
set $$=%RANDOM%

: Set up flight path
gmt project -C-73.8333/40.75 -E-80.133/25.75 -G5 -Q > %$$%.path.d
set frame=0
if not exist %dir%\nul mkdir %dir%
gmt grdgradient %input% -A90 -Nt1 -G%$$%_int.nc
gmt makecpt -Cglobe -Z > %$$%.cpt
for /f "tokens=1-3" %%i in (%$$%.path.d) do (
	set lon=%%i
	set lat=%%j
	set dist=%%k
	call :set_framename %name% !frame!
	call :set_ID !frame!
	gmt grdimage -JG!lon!/!lat!/!altitude!/!azimuth!/!tilt!/!twist!/!Width!/!Height!/7i+ %REGION% ^
		-P -Y0.1i -X0.1i %input% -I%$$%_int.nc -C%$$%.cpt --PS_MEDIA=%px%ix%py%i -K > %$$%.ps
	gmt psxy -R -J -O -K -W1p %$$%.path.d >> %$$%.ps
	echo 0 4.6 !ID! | gmt pstext -R0/%px%/0/%py% -Jx1i -F+f14p,Helvetica-Bold+jTL -O >> %$$%.ps
	if "%1"=="" (
		move %$$%.ps %ps% > nul
		del %$$%.path.d %$$%_int.nc %$$%.cpt %$$%.ps gmt.history
		echo %0: First frame plotted to %name%.ps
		echo To build a movie, run %0 with any argument
		exit /b
	)
	:	RIP to TIFF at specified dpi
	gmt ps2raster -E%dpi% -Tt %$$%.ps
	move /y %$$%.tif %dir%/!file!.tif > nul
	echo Frame !file! completed
	set /a frame=!frame!+1
)
: 3. Create a movie
: if exist %IMAGEMAGICK%\convert.exe (
:	%IMAGEMAGICK%\convert -delay 10 -loop 0 %dir%/%name%_*.tif %name%.gif
: )
: qt_export %$$%/anim_0_123456.tiff --video=h263,24,100, %name%_movie.m4v
call :makeHTML %name%.html
: 4. Clean up temporary files
del %$$%.path.d %$$%_int.nc %$$%.cpt %$$%.ps gmt.history
goto :eof

:cmd2var
for /f "delims=" %%s in ('%1') do set %2=%%s
goto :eof

:set_framename
set frame6=00000%2
if %2 geq 10 set frame6=0000%2
if %2 geq 100 set frame6=000%2
if %2 geq 1000 set frame6=00%2
if %2 geq 10000 set frame6=0%2
if %2 geq 100000 set frame6=%2
set file=%1_!frame6!
goto :eof

:set_ID
set ID=000%1
if %1 geq 10 set ID=00%1
if %1 geq 100 set ID=0%1
if %1 geq 1000 set ID=%1
goto :eof

:makeHTML
echo Made %frame% frames at 480x720 pixels placed in subdirectory %dir%
goto :eof
