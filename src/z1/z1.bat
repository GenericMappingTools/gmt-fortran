gmtset GMT_VERBOSE V
gmtmath -T0/10/1 T SQR = > xy.dat
psxy xy.dat -JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P >xy.ps
ps2raster xy.ps -Tg
