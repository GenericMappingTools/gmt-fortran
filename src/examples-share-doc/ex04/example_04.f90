! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! Examples from GMT_SHAREDIR/doc/examples
! ----------------------------------------------------------------------
! Note overloaded +- for string concatenation with/without blank-separation
! e.g.: "psxy"+dat+"-J -R -B ->"-ps  for  "psxy file.dat -J -R -B ->file.ps"
! ----------------------------------------------------------------------

program example_04
use gmt
use gmt_misc
implicit none
character(16) tag,ggrd,tgrd,gigrd,tigrd,gcpt,tcpt,zcpt,tmp,ps
character(100) lines(10)

tag='example_04'
ggrd='HI_geoid4.nc'
tgrd='HI_topo4.nc'
gigrd='g_intens.nc'
tigrd='t_intens.nc'
gcpt='geoid.cpt'
tcpt='topo.cpt'
zcpt='zero.cpt'
tmp='tmp'

print *,tag
ps='example_04.ps'
lines(1)='-10     255     0       255'
lines(2)='0       100     10      100'
call echo(lines(:2),zcpt)
call sGMT('grdcontour'+ggrd+'-R195/210/18/25 -Jm0.45i -p60/30 -C1 -A5+o -Gd4i -K -P -X1.5i -Y1.5i ->'-ps)
call sGMT('pscoast -R -J -p -B2 -BNEsw -Gblack -O -K -T209/19.5/1i ->>'-ps)
call sGMT('grdview'+tgrd+'-R195/210/18/25/-6/4 -J -Jz0.34i -p -C'-zcpt &
          +'-N-6+glightgray -Qsm -O -K -B2 -Bz2+l"Topo (km)" -BneswZ -Y2.2i ->>'-ps)
lines(1)='3.25 5.75 H@#awaiian@# R@#idge'
call echo(lines(:1),tmp)
call sGMT('pstext'+tmp+'-R0/10/0/10 -Jx1i -F+f60p,ZapfChancery-MediumItalic+jCB -O ->>'-ps)
call sGMT('ps2raster'+ps+'-Tg')
call rm(zcpt)
call rm(tmp)

print *,tag+'(color)'
ps='example_04c.ps'
call sGMT('grdgradient'+ggrd+'-A0 -G'-gigrd+'-Nt0.75 -fg')
call sGMT('grdgradient'+tgrd+'-A0 -G'-tigrd+'-Nt0.75 -fg')
call sGMT('grdimage'+ggrd+'-I'-gigrd+'-R195/210/18/25 -JM6.75i -p60/30 -C'-gcpt &
          +'-E100 -K -X1.5i -Y1.25i -P -UL/-1.25i/-1i/"Example 04c in Cookbook" ->'-ps)
call sGMT('pscoast -R -J -p -B2 -BNEsw -Gblack -O -K ->>'-ps)
call sGMT('psscale -R -J -p -D3.375i/4.3i/5i/0.3ih -C'-gcpt+'-I -O -K -A -Bx2+l"Geoid (m)" ->>'-ps)
call sGMT('psbasemap -R -J -p -O -K -T209/19.5/1i --COLOR_BACKGROUND=red --MAP_TICK_PEN_PRIMARY=thinner,red --FONT=red ->>'-ps)
call sGMT('grdview'+tgrd+'-I'-tigrd+'-R195/210/18/25/-6/4 -J -JZ3.4i -p -C'-tcpt &
          +'-N-6+glightgray -Qc100 -O -K -Y2.2i -B2 -Bz2+l"Topo (km)" -BneswZ ->>'-ps)
lines(1)='3.25 5.75 H@#awaiian@# R@#idge'
call echo(lines(:1),tmp)
call sGMT('pstext'+tmp+'-R0/10/0/10 -Jx1i -F+f60p,ZapfChancery-MediumItalic+jCB -O ->>'-ps)
call sGMT('ps2raster'+ps+'-Tg')

call rm('gmt.conf')
call rm('gmt.history')
call rm(gigrd)
call rm(tigrd)
call rm(tmp)
end program
