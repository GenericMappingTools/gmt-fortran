gmtset GMT_VERBOSE N

gmtmath -T0/10/1 T SQR = >ex01-xy.dat

psxy ex01-xy.dat -JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P >ex01.ps

ps2raster ex01.ps -Tg
