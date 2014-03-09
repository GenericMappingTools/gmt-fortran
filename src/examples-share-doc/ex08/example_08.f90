! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! Examples from GMT_SHAREDIR/doc/examples
! ----------------------------------------------------------------------
! Note overloaded + for blank-separated string and int operands
! Combine with // for separation without blanks
! e.g.: 'psxy'+file+args+'->'//ps  for 'psxy file01.dat -J -R -B ->file.ps'
!       trim('file'+11)//'.dat'    for 'file11.dat'
! ----------------------------------------------------------------------

program example_08
use gmt
use gmt_misc
implicit none
character(16) tag,grd,tmp,ps
character(100) lines(10)

tag='example_08'
grd='guinea_bay.nc'
tmp='tmp'
ps='example_08.ps'

print *,tag
call sGMT('grd2xyz'+grd+'->'//tmp)
call sGMT('psxyz'+tmp+'-B1 -Bz1000+l"Topography (m)" -BWSneZ+b+tETOPO5' &
          +'-R-0.1/5.1/-0.1/5.1/-5000/0 -JM5i -JZ6i -p200/30 -So0.0833333ub-5000 -P' &
          +'-Wthinnest -Glightgreen -K ->'//ps)
lines(1)='0.1 4.9 This is the gmt surface of cube'
call echo(lines(:1),tmp)
call sGMT('pstext'+tmp+'-R -J -JZ -Z0 -F+f24p,Helvetica-Bold+jTL -p -O ->>'//ps)
call sGMT('ps2raster'+ps+'-Tg')

call rm('gmt.conf')
call rm('gmt.history')
call rm(tmp)
end program
