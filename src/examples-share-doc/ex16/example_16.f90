! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! Examples from GMT_SHAREDIR/doc/examples
! ----------------------------------------------------------------------
! Note overloaded +- for string concatenation with/without blank-separation
! e.g.: "psxy"+dat+"-J -R -B ->"-ps  for  "psxy file.dat -J -R -B ->file.ps"
! ----------------------------------------------------------------------

program example_16
use gmt
use gmt_misc
implicit none
character(16) tag,table,cpt,grd0,grd5,grdt,grdf,pipe,ps
character(100) lines(10)

tag='example_16'
table='table_5.11'
cpt='ex16.cpt'
grd0='raws0.nc'
grd5='raws5.nc'
grdt='rawt.nc'
grdf='filtered.nc'
pipe='pipe'
ps='example_16.ps'

print *,tag
call sGMT('gmtset FONT_ANNOT_PRIMARY 9p')

call sGMT('pscontour -R0/6.5/-0.2/6.5 -Jx0.45i -P -K -Y5.5i -Ba2f1 -BWSne'+table+'-C'//cpt+'-I ->'-ps)
lines(1)='3.25 7 pscontour (triangulate)'
call echo(lines(:1),pipe)
call sGMT('pstext'+pipe+'-R -J -O -K -N -F+f18p,Times-Roman+jCB ->>'-ps)

call sGMT('surface'+table+'-R -I0.2 -G'-grd0)
call sGMT('grdview'+grd0+'-R -J -B -C'-cpt+'-Qs -O -K -X3.5i ->>'-ps)
lines(1)='3.25 7 surface (tension = 0)'
call echo(lines(:1),pipe)
call sGMT('pstext'+pipe+'-R -J -O -K -N -F+f18p,Times-Roman+jCB ->>'-ps)

call sGMT('surface'+table+'-R -I0.2 -G'-grd5+'-T0.5')
call sGMT('grdview'+grd5+'-R -J -B -C'-cpt+'-Qs -O -K -Y-3.75i -X-3.5i ->>'-ps)
lines(1)='3.25 7 surface (tension = 0.5)'
call echo(lines(:1),pipe)
call sGMT('pstext'+pipe+'-R -J -O -K -N -F+f18p,Times-Roman+jCB ->>'-ps)

call sGMT('triangulate'+table+'-G'-grdt+'-R -I0.2 ->'-'NUL')
call sGMT('grdfilter'+grdt+'-G'-grdf+'-D0 -Fc1')
call sGMT('grdview'+grdf+'-R -J -B -C'-cpt+'-Qs -O -K -X3.5i ->>'-ps)
lines(1)='3.25 7 triangulate @~\256@~ gmt grdfilter'
call echo(lines(:1),pipe)
call sGMT('pstext'+pipe+'-R -J -O -K -N -F+f18p,Times-Roman+jCB ->>'-ps)

lines(1)='3.2125 7.5 Gridding of Data'
call echo(lines(:1),pipe)
call sGMT('pstext'+pipe+'-R0/10/0/10 -Jx1i -O -K -N -F+f32p,Times-Roman+jCB -X-3.5i ->>'-ps)
call sGMT('psscale -D3.21/0.35/5/0.25h -C'-cpt+'-O -Y-0.75i ->>'-ps)

if (.false.) then
call sGMT('ps2raster'+ps+'-Tg')
endif

call rm('gmt.conf')
call rm('gmt.history')
call rm(grd0)
call rm(grd5)
call rm(grdt)
call rm(grdf)
call rm(pipe)
end program
