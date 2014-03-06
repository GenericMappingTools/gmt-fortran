! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! Examples from GMT_SHAREDIR/doc/examples
! ----------------------------------------------------------------------

program example_01
use gmt
implicit none
character(16) tag,grd,ps

tag='example_01'
grd='osu91a1f_16.nc'
ps='example_01.ps'

print *,trim(tag)
call sGMT_Create_Session(tag)
call sGMT('gmtset MAP_GRID_CROSS_SIZE_PRIMARY 0 FONT_ANNOT_PRIMARY 10p')
call sGMT('psbasemap -R0/6.5/0/7.5 -Jx1i -B0 -P -K ->'//ps)
call sGMT('pscoast -Rg -JH0/6i -X0.25i -Y0.2i -O -K -Bg30 -Dc -Glightbrown -Slightblue ->>'//ps)
call sGMT('grdcontour '//trim(grd)//' -J -C10 -A50+f7p -Gd4i -L-1000/-1 -Wcthinnest,- -Wathin,- -O -K -T0.1i/0.02i ->>'//ps)
call sGMT('grdcontour '//trim(grd)//' -J -C10 -A50+f7p -Gd4i -L-1/1000 -O -K -T0.1i/0.02i ->>'//ps)
call sGMT('pscoast -Rg -JH6i -Y3.4i -O -K -B+t"Low Order Geoid" -Bg30 -Dc -Glightbrown -Slightblue ->>'//ps)
call sGMT('grdcontour '//trim(grd)//' -J -C10 -A50+f7p -Gd4i -L-1000/-1 -Wcthinnest,- -Wathin,- -O -K -T0.1i/0.02i:-+ ->>'//ps)
call sGMT('grdcontour '//trim(grd)//' -J -C10 -A50+f7p -Gd4i -L-1/1000 -O -T0.1i/0.02i:-+ ->>'//ps)
call sGMT('ps2raster '//trim(ps)//' -Tg')
call sGMT_Destroy_Session()

call rm('gmt.conf')
call rm('gmt.history')

contains

subroutine rm(file)
implicit none
character(*) file
integer :: id=1357
open (id,file=file)
! open (newunit=id,file=file) ! Fortran 2008 feature
close (id,status='delete')
end subroutine

end program
