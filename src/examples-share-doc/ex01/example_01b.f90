! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! Examples from GMT_SHAREDIR/doc/examples
! ----------------------------------------------------------------------

module mChars

! overloaded plus operator for character strings and integers
interface operator (+)
module procedure ChPlusCh,ChPlusInt
end interface

contains

! blank-separated trimmed string+string
function ChPlusCh(a,b)
implicit none
character(*),intent(in) :: a,b
character(len_trim(a)+1+len_trim(b)) ChPlusCh
ChPlusCh=trim(a)//' '//trim(b)
end function

! blank-separated trimmed string+int
function ChPlusInt(a,ib)
implicit none
character(*),intent(in) :: a
integer,intent(in) :: ib
character(10) chb
! character(int(log10(abs(real(ib,8)))+1+merge(1,0,ib<0))) chb ! ifort 13.1.0 problem
character(len_trim(a)+1+len(chb)) ChPlusInt
write (chb,'(i0)') ib
ChPlusInt=trim(a)//' '//chb
end function

! echo character array lines into file
subroutine echo(file,lines)
implicit none
character(*) file
character(100) lines(:)
integer :: id=1357,i
open (id,file=file)
! open (newunit=id,file=file) ! Fortran 2008 feature
do i=1,size(lines)
write (id,'(a)') trim(lines(i))
enddo
close (id)
end subroutine

! remove file
subroutine rm(file)
implicit none
character(*) file
integer :: id=1357
open (id,file=file)
! open (newunit=id,file=file) ! Fortran 2008 feature
close (id,status='delete')
end subroutine

end module

! ----------------------------------------------------------------------

program example_01
use gmt
use mChars
implicit none
character(16) tag,grd,ps

tag='example_01'
grd='osu91a1f_16.nc'
ps='example_01.ps'

print *,tag
call sGMT_Create_Session(tag)
call sGMT('gmtset MAP_GRID_CROSS_SIZE_PRIMARY 0 FONT_ANNOT_PRIMARY 10p')
call sGMT('psbasemap -R0/6.5/0/7.5 -Jx1i -B0 -P -K ->'//ps)
call sGMT('pscoast -Rg -JH0/6i -X0.25i -Y0.2i -O -K -Bg30 -Dc -Glightbrown -Slightblue ->>'//ps)
call sGMT('grdcontour'+grd+'-J -C10 -A50+f7p -Gd4i -L-1000/-1 -Wcthinnest,- -Wathin,- -O -K -T0.1i/0.02i ->>'//ps)
call sGMT('grdcontour'+grd+'-J -C10 -A50+f7p -Gd4i -L-1/1000 -O -K -T0.1i/0.02i ->>'//ps)
call sGMT('pscoast -Rg -JH6i -Y3.4i -O -K -B+t"Low Order Geoid" -Bg30 -Dc -Glightbrown -Slightblue ->>'//ps)
call sGMT('grdcontour'+grd+'-J -C10 -A50+f7p -Gd4i -L-1000/-1 -Wcthinnest,- -Wathin,- -O -K -T0.1i/0.02i:-+ ->>'//ps)
call sGMT('grdcontour'+grd+'-J -C10 -A50+f7p -Gd4i -L-1/1000 -O -T0.1i/0.02i:-+ ->>'//ps)
call sGMT('ps2raster'+ps+'-Tg')
call sGMT_Destroy_Session()

call rm('gmt.conf')
call rm('gmt.history')
end program
