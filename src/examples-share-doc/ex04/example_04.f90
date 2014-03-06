! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! Examples from GMT_SHAREDIR/doc/examples
! ----------------------------------------------------------------------

program example_04
use gmt
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

print *,trim(tag)
ps='example_04.ps'
lines(1)='-10     255     0       255'
lines(2)='0       100     10      100'
call echo(zcpt,lines(:2))
call sGMT('grdcontour '//trim(ggrd)//' -R195/210/18/25 -Jm0.45i -p60/30 -C1 -A5+o -Gd4i -K -P -X1.5i -Y1.5i ->'//ps)
call sGMT('pscoast -R -J -p -B2 -BNEsw -Gblack -O -K -T209/19.5/1i ->>'//ps)
call sGMT('grdview '//trim(tgrd)//' -R195/210/18/25/-6/4 -J -Jz0.34i -p -C'//trim(zcpt) &
          //' -N-6+glightgray -Qsm -O -K -B2 -Bz2+l"Topo (km)" -BneswZ -Y2.2i ->>'//ps)
lines(1)='3.25 5.75 H@#awaiian@# R@#idge'
call echo(tmp,lines(:1))
call sGMT('pstext '//trim(tmp)//' -R0/10/0/10 -Jx1i -F+f60p,ZapfChancery-MediumItalic+jCB -O ->>'//ps)
call sGMT('ps2raster '//trim(ps)//' -Tg')
call rm(zcpt)
call rm(tmp)

print *,trim(tag)//' (color)'
ps='example_04c.ps'
call sGMT('grdgradient '//trim(ggrd)//' -A0 -G'//trim(gigrd)//' -Nt0.75 -fg')
call sGMT('grdgradient '//trim(tgrd)//' -A0 -G'//trim(tigrd)//' -Nt0.75 -fg')
call sGMT('grdimage '//trim(ggrd)//' -I'//trim(gigrd)//' -R195/210/18/25 -JM6.75i -p60/30 -C'//trim(gcpt) &
          //' -E100 -K -X1.5i -Y1.25i -P -UL/-1.25i/-1i/"Example 04c in Cookbook" ->'//ps)
call sGMT('pscoast -R -J -p -B2 -BNEsw -Gblack -O -K ->>'//ps)
call sGMT('psscale -R -J -p -D3.375i/4.3i/5i/0.3ih -C'//trim(gcpt)//' -I -O -K -A -Bx2+l"Geoid (m)" ->>'//ps)
call sGMT('psbasemap -R -J -p -O -K -T209/19.5/1i --COLOR_BACKGROUND=red --MAP_TICK_PEN_PRIMARY=thinner,red --FONT=red ->>'//ps)
call sGMT('grdview '//trim(tgrd)//' -I'//trim(tigrd)//' -R195/210/18/25/-6/4 -J -JZ3.4i -p -C'//trim(tcpt) &
          //' -N-6+glightgray -Qc100 -O -K -Y2.2i -B2 -Bz2+l"Topo (km)" -BneswZ ->>'//ps)
lines(1)='3.25 5.75 H@#awaiian@# R@#idge'
call echo(tmp,lines(:1))
call sGMT('pstext '//trim(tmp)//' -R0/10/0/10 -Jx1i -F+f60p,ZapfChancery-MediumItalic+jCB -O ->>'//ps)
call sGMT('ps2raster '//trim(ps)//' -Tg')

call sGMT_Destroy_Session()

call rm('gmt.conf')
call rm('gmt.history')
call rm(gigrd)
call rm(tigrd)
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
