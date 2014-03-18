#!/bin/bash
#               GMT ANIMATION 04
#               $Id: anim_04.sh 11490 2013-05-16 06:26:21Z pwessel $
#
# Purpose:      Make DVD-res Quicktime movie of NY to Miami flight
# GMT progs:    gmt gmtset, gmt gmtmath, gmt psbasemap, gmt pstext, gmt psxy, gmt ps2raster
# Unix progs:   awk, mkdir, rm, mv, echo, qt_export, cat
# Note:         Run with any argument to build movie; otherwise 1st frame is plotted only.
#
# 1. Initialization
# 1a) Assign movie parameters
. gmt_shell_functions.sh
REGION=-Rg
altitude=160.0
tilt=55
azimuth=210
twist=0
Width=36.0
Height=34.0
px=7.2
py=4.8
dpi=100
name=anim_04
ps=${name}.ps

# Set up flight path
gmt project -C-73.8333/40.75 -E-80.133/25.75 -G5 -Q > $$.path.d
frame=0
mkdir -p frames
gmt grdgradient USEast_Coast.nc -A90 -Nt1 -G$${_int}.nc
gmt makecpt -Cglobe -Z > $$.cpt
while read lon lat dist; do
	file=`gmt_set_framename ${name} ${frame}`
	ID=`echo ${frame} | $AWK '{printf "%04d\n", $1}'`
	gmt grdimage -JG${lon}/${lat}/${altitude}/${azimuth}/${tilt}/${twist}/${Width}/${Height}/7i+ \
		${REGION} -P -Y0.1i -X0.1i USEast_Coast.nc -I$${_int}.nc -C$$.cpt \
		--PS_MEDIA=${px}ix${py}i -K > $$.ps
	gmt psxy -R -J -O -K -W1p $$.path.d >> $$.ps
	gmt pstext -R0/${px}/0/${py} -Jx1i -F+f14p,Helvetica-Bold+jTL -O >> $$.ps <<< "0 4.6 ${ID}"
	if [ $# -eq 0 ]; then
		mv $$.ps ${ps}
		gmt_cleanup .gmt
		gmt_abort "${0}: First frame plotted to ${name}.ps"
	fi
	gmt ps2raster $$.ps -Tt -E${dpi}
	mv $$.tif frames/${file}.tif
        echo "Frame ${file} completed"
	frame=`gmt_set_framenext ${frame}`
done < $$.path.d
if [ $# -eq 0 ]; then
	echo "anim_04.sh: Made ${frame} frames at 480x720 pixels placed in subdirectory frames"
#	qt_export $$/anim_0_123456.tiff --video=h263,24,100, ${name}_movie.m4v
fi
# 4. Clean up temporary files
gmt_cleanup .gmt
