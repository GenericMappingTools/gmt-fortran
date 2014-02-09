gmtset GMT_VERBOSE N

xyz2grd xyz.dat -Gxyz.grd -R-2/2/-1.2/1.2 -I.02/.02
makecpt -Crainbow -T0/10/2 -Z >xyz.cpt

psbasemap -JX14c/8c -R -Ba0.5::/a0.5::WeSn:.Fig.: -P -K >xyz.ps
grdimage xyz.grd -J -R -B -Cxyz.cpt -O -K >>xyz.ps
grdcontour xyz.grd -J -R -B -C2 -O -K >>xyz.ps
psscale -D15c/4c/8c/1c -Cxyz.cpt -O >>xyz.ps

ps2raster xyz.ps -Tg
