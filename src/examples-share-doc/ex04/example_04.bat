REM		GMT EXAMPLE 04
REM
REM		$Id$
REM
REM Purpose:	3-D mesh plot of Hawaiian topography and geoid
REM GMT progs:	grdcontour, grdgradient, grdimage, grdview, psbasemap, pscoast, pstext
REM DOS calls:	echo, del
REM
REM CPS: topo.cpt
REM CPS: geoid.cpt
echo GMT EXAMPLE 04
set ps=example_04.ps
echo -10     255     0       255 > zero.cpt
echo 0       100     10      100 >> zero.cpt
gmt grdcontour HI_geoid4.nc -R195/210/18/25 -Jm0.45i -p60/30 -C1 -A5+o -Gd4i -K -P -X1.5i -Y1.5i > %ps%
gmt pscoast -R -J -p -B2 -BNEsw -Gblack -O -K -T209/19.5/1i >> %ps%
gmt grdview HI_topo4.nc -R195/210/18/25/-6/4 -J -Jz0.34i -p -Czero.cpt -N-6+glightgray -Qsm -O -K -B2 -Bz2+l"Topo (km)" -BneswZ -Y2.2i >> %ps%
echo 3.25 5.75 H@#awaiian@# R@#idge | gmt pstext -R0/10/0/10 -Jx1i -F+f60p,ZapfChancery-MediumItalic+jCB -O >> %ps%
gmt ps2raster %ps% -Tg
del zero.cpt
REM
echo GMT EXAMPLE 4 (color)
set ps=example_04c.ps
gmt grdgradient HI_geoid4.nc -A0 -Gg_intens.nc -Nt0.75 -fg
gmt grdgradient HI_topo4.nc -A0 -Gt_intens.nc -Nt0.75 -fg
REM
gmt grdimage HI_geoid4.nc -Ig_intens.nc -R195/210/18/25 -JM6.75i -p60/30 -Cgeoid.cpt -E100 -K -X1.5i -Y1.25i -P -UL/-1.25i/-1i/"Example 04c in Cookbook" > %ps%
gmt pscoast -R -J -p -B2 -BNEsw -Gblack -O -K >> %ps%
gmt psscale -R -J -p -D3.375i/4.3i/5i/0.3ih -Cgeoid.cpt -I -O -K -A -Bx2+l"Geoid (m)" >> %ps%
gmt psbasemap -R -J -p -O -K -T209/19.5/1i --COLOR_BACKGROUND=red --MAP_TICK_PEN_PRIMARY=thinner,red --FONT=red >> %ps%
gmt grdview HI_topo4.nc -It_intens.nc -R195/210/18/25/-6/4 -J -JZ3.4i -p -Ctopo.cpt -N-6+glightgray -Qc100 -O -K -Y2.2i -B2 -Bz2+l"Topo (km)" -BneswZ >> %ps%
echo 3.25 5.75 H@#awaiian@# R@#idge | gmt pstext -R0/10/0/10 -Jx1i -F+f60p,ZapfChancery-MediumItalic+jCB -O >> %ps%
gmt ps2raster %ps% -Tg
del *_intens.nc
del .gmt*
