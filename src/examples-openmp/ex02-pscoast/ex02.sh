#!/bin/bash
LONMIN=-158
LONMAX=14
LATMIN=21
LATMAX=50
NMAX=100
for (( N=0; N<=$NMAX; N++ )); do
  echo $N of $NMAX
  FILE=000$N
  if [ $N -ge 10 ]; then FILE=00$N; fi
  if [ $N -ge 100 ]; then FILE=0$N; fi
  if [ $N -ge 1000 ]; then FILE=$N; fi
  FILEDAT=$FILE.dat
  FILEPS=$FILE.ps
  LON=x
  LAT=y
  LON=$(($LONMIN+($LONMAX-$LONMIN)*$N/$NMAX))
  LAT=$(($LATMIN+($LATMAX-$LATMIN)*$N/$NMAX))
  gmt pscoast -JG$LON/$LAT/10c -R0/360/-90/90 -Bxg30 -Byg15 -B+t"$N of $NMAX" -Dc -Gsandybrown -Slightskyblue -P -K > $FILEPS
  gmt psxy ex02-line.dat -J -R -W1p,blue -O -K >> $FILEPS
  gmt psxy ex02-line.dat -J -R -Gyellow -Sc7p -W1p,blue -O -K >> $FILEPS
  gmt pstext ex02-text.dat -J -R -D0.25c/-0.4c -O >> $FILEPS
# gmt ps2raster $FILEPS -P
done
