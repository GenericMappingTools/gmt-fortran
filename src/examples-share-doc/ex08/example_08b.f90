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

program example_08
use gmt
use mChars
implicit none
character(16) tag,grd,tmp,ps
character(100) lines(10)

tag='example_08'
grd='guinea_bay.nc'
tmp='tmp'
ps='example_08.ps'

print *,tag
call sGMT_Create_Session(tag)
call sGMT('grd2xyz'+grd+'->'//tmp)
call sGMT('psxyz'+tmp+'-B1 -Bz1000+l"Topography (m)" -BWSneZ+b+tETOPO5' &
          +'-R-0.1/5.1/-0.1/5.1/-5000/0 -JM5i -JZ6i -p200/30 -So0.0833333ub-5000 -P' &
          +'-Wthinnest -Glightgreen -K ->'//ps)
lines(1)='0.1 4.9 This is the gmt surface of cube'
call echo(tmp,lines(:1))
call sGMT('pstext'+tmp+'-R -J -JZ -Z0 -F+f24p,Helvetica-Bold+jTL -p -O ->>'//ps)
call sGMT('ps2raster'+ps+'-Tg')
call sGMT_Destroy_Session()

call rm('gmt.conf')
call rm('gmt.history')
call rm(tmp)
end program
