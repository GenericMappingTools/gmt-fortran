! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! Examples from GMT_SHAREDIR/doc/examples
! ----------------------------------------------------------------------

program example_08
use gmt
implicit none
character(16) tag,grd,tmp,ps
character(100) lines(10)

tag='example_08'
grd='guinea_bay.nc'
tmp='tmp'
ps='example_08.ps'

print *,trim(tag)
call sGMT_Create_Session(tag)
call sGMT('grd2xyz '//trim(grd)//' ->'//tmp)
call sGMT('psxyz '//trim(tmp)//' -B1 -Bz1000+l"Topography (m)" -BWSneZ+b+tETOPO5 ' &
          //'-R-0.1/5.1/-0.1/5.1/-5000/0 -JM5i -JZ6i -p200/30 -So0.0833333ub-5000 -P ' &
          //'-Wthinnest -Glightgreen -K ->'//ps)
lines(1)='0.1 4.9 This is the gmt surface of cube'
call echo(tmp,lines(:1))
call sGMT('pstext '//trim(tmp)//' -R -J -JZ -Z0 -F+f24p,Helvetica-Bold+jTL -p -O ->>'//ps)
call sGMT('ps2raster '//trim(ps)//' -Tg')
call sGMT_Destroy_Session()

call rm('gmt.conf')
call rm('gmt.history')
call rm(tmp)

contains

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

subroutine rm(file)
implicit none
character(*) file
integer :: id=1357
open (id,file=file)
! open (newunit=id,file=file) ! Fortran 2008 feature
close (id,status='delete')
end subroutine

end program
