gmtset GMT_VERBOSE N

pscoast -JG-100/50/10c -R0/360/-90/90 -Bxg30 -Byg15 -Dl -Gsandybrown -Slightskyblue -P -K >ex02.ps
psxy ex02-line.dat -J -R -W1p,blue -O -K >>ex02.ps
psxy ex02-line.dat -J -R -Gyellow -Sc7p -W1p,blue -O -K >>ex02.ps
pstext ex02-text.dat -J -R -D0.25c/-0.4c -O >>ex02.ps

ps2raster ex02.ps -Tg
