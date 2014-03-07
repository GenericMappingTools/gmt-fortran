gmtset GMT_VERBOSE N

xyz2grd ex03-xyz.dat -Gex03-xyz.grd -R-2/2/-1.2/1.2 -I.02/.02
makecpt -Crainbow -T0/10/2 -Z >ex03-xyz.cpt

psbasemap -JX14c/8c -R -Ba0.5 -BWeSn+tFig. -P -K >ex03.ps
grdimage ex03-xyz.grd -J -R -B -Cex03-xyz.cpt -O -K >>ex03.ps
grdcontour ex03-xyz.grd -J -R -B -C2 -O -K >>ex03.ps
psscale -D15c/4c/8c/1c -Cex03-xyz.cpt -O >>ex03.ps

ps2raster ex03.ps -Tg
