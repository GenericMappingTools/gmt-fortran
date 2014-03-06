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

program example_02
use gmt
use mChars
implicit none
character(16) tag,ggrd,tgrd,tgrd2,gcpt,tcpt,tmp,ps
character(100) lines(10)

tag='example_02'
ggrd='HI_geoid2.nc'
tgrd='HI_topo2.nc'
tgrd2='HI_topo2_int.nc'
gcpt='g.cpt'
tcpt='t.cpt'
tmp='tmp'
ps='example_02.ps'

print *,tag
call sGMT_Create_Session(tag)
call sGMT('gmtset FONT_TITLE 30p MAP_ANNOT_OBLIQUE 0')
call sGMT('makecpt -Crainbow -T-2/14/2 ->'//gcpt)
call sGMT('grdimage'+ggrd+'-R160/20/220/30r -JOc190/25.5/292/69/4.5i -E50 -K -P -B10 -C'//gcpt+'-X1.5i -Y1.25i ->'//ps)
call sGMT('psscale -C'//gcpt+'-D5.1i/1.35i/2.88i/0.4i -O -K -Ac -Bx2+lGEOID -By+lm -E ->>'//ps)
call sGMT('grd2cpt'+tgrd+'-Crelief -Z ->'//tcpt)
call sGMT('grdgradient'+tgrd+'-A0 -Nt -G'//tgrd2)
call sGMT('grdimage'+tgrd+'-I'//tgrd2+'-R -J -E50 -B+t"H@#awaiian@# T@#opo and @#G@#eoid"' &
          +'-B10 -O -K -C'//tcpt+'-Y4.5i --MAP_TITLE_OFFSET=0.5i ->>'//ps)
call sGMT('psscale -C'//tcpt+'-D5.1i/1.35i/2.88i/0.4i -O -K -I0.3 -Ac -Bx2+lTOPO -By+lkm ->>'//ps)
lines(1)='-0.4 7.5 a)'
lines(2)='-0.4 3.0 b)'
call echo(tmp,lines(:2))
call sGMT('pstext'+tmp+'-R0/8.5/0/11 -Jx1i -F+f30p,Helvetica-Bold+jCB -O -N -Y-4.5i ->>'//ps)
call sGMT('ps2raster'+ps+'-Tg')
call sGMT_Destroy_Session()

call rm('gmt.conf')
call rm('gmt.history')
call rm(gcpt)
call rm(tcpt)
call rm(tgrd2)
call rm(tmp)
end program
