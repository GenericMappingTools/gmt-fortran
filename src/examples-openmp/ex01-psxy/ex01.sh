#!/bin/bash
NMAX=100
for (( N=0; N<=$NMAX; N++ )); do
  echo $N of $NMAX
  FILE=000$N
  if [ $N -ge 10 ]; then FILE=00$N; fi
  if [ $N -ge 100 ]; then FILE=0$N; fi
  if [ $N -ge 1000 ]; then FILE=$N; fi
  FILEDAT=$FILE.dat
  FILEPS=$FILE.ps
  gmt gmtmath -T0/6.283185/0.00006283185 T 6.283185 $N MUL $NMAX DIV ADD SIN = | psxy -JX15c/10c -R0/7/-1/1 -Bx1+lx -By0.5+ly -BWS+t"time = $N of $NMAX" -Sc0.15c -N > $FILEPS
# gmt gmtmath -T0/6.283185/0.00006283185 T 6.283185 $N MUL $NMAX DIV ADD SIN = > $FILEDAT
# gmt psxy $FILEDAT -JX15c/10c -R0/7/-1/1 -Bx1+lx -By0.5+ly -BWS+t"time = $N of $NMAX" -Sc0.15c -N > $FILEPS
# gmt ps2raster $FILEPS -P
done
