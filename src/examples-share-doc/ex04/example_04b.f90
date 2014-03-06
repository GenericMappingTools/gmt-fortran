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

program example_04
use gmt
use mChars
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

call sGMT_Create_Session(tag)

print *,tag
ps='example_04.ps'
lines(1)='-10     255     0       255'
lines(2)='0       100     10      100'
call echo(zcpt,lines(:2))
call sGMT('grdcontour'+ggrd+'-R195/210/18/25 -Jm0.45i -p60/30 -C1 -A5+o -Gd4i -K -P -X1.5i -Y1.5i ->'//ps)
call sGMT('pscoast -R -J -p -B2 -BNEsw -Gblack -O -K -T209/19.5/1i ->>'//ps)
call sGMT('grdview'+tgrd+'-R195/210/18/25/-6/4 -J -Jz0.34i -p -C'//zcpt &
          +'-N-6+glightgray -Qsm -O -K -B2 -Bz2+l"Topo (km)" -BneswZ -Y2.2i ->>'//ps)
lines(1)='3.25 5.75 H@#awaiian@# R@#idge'
call echo(tmp,lines(:1))
call sGMT('pstext'+tmp+'-R0/10/0/10 -Jx1i -F+f60p,ZapfChancery-MediumItalic+jCB -O ->>'//ps)
call sGMT('ps2raster'+ps+'-Tg')
call rm(zcpt)
call rm(tmp)

print *,tag+'(color)'
ps='example_04c.ps'
call sGMT('grdgradient'+ggrd+'-A0 -G'//gigrd+'-Nt0.75 -fg')
call sGMT('grdgradient'+tgrd+'-A0 -G'//tigrd+'-Nt0.75 -fg')
call sGMT('grdimage'+ggrd+'-I'//gigrd+'-R195/210/18/25 -JM6.75i -p60/30 -C'//gcpt &
          +'-E100 -K -X1.5i -Y1.25i -P -UL/-1.25i/-1i/"Example 04c in Cookbook" ->'//ps)
call sGMT('pscoast -R -J -p -B2 -BNEsw -Gblack -O -K ->>'//ps)
call sGMT('psscale -R -J -p -D3.375i/4.3i/5i/0.3ih -C'//gcpt+'-I -O -K -A -Bx2+l"Geoid (m)" ->>'//ps)
call sGMT('psbasemap -R -J -p -O -K -T209/19.5/1i --COLOR_BACKGROUND=red --MAP_TICK_PEN_PRIMARY=thinner,red --FONT=red ->>'//ps)
call sGMT('grdview'+tgrd+'-I'//tigrd+'-R195/210/18/25/-6/4 -J -JZ3.4i -p -C'//tcpt &
          +'-N-6+glightgray -Qc100 -O -K -Y2.2i -B2 -Bz2+l"Topo (km)" -BneswZ ->>'//ps)
lines(1)='3.25 5.75 H@#awaiian@# R@#idge'
call echo(tmp,lines(:1))
call sGMT('pstext'+tmp+'-R0/10/0/10 -Jx1i -F+f60p,ZapfChancery-MediumItalic+jCB -O ->>'//ps)
call sGMT('ps2raster'+ps+'-Tg')

call sGMT_Destroy_Session()

call rm('gmt.conf')
call rm('gmt.history')
call rm(gigrd)
call rm(tigrd)
call rm(tmp)
end program
