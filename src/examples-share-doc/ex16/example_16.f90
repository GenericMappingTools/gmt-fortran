! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! Examples from GMT_SHAREDIR/doc/examples
! ----------------------------------------------------------------------

program example_16
use gmt
implicit none
character(16) tag,table,cpt,grd0,grd5,grdt,grdf,tmp,ps
character(100) lines(10)

tag='example_16'
table='table_5.11'
cpt='ex16.cpt'
grd0='raws0.nc'
grd5='raws5.nc'
grdt='rawt.nc'
grdf='filtered.nc'
tmp='tmp'
ps='example_16.ps'

call rm(ps)

print *,trim(tag)
call sGMT_Create_Session(tag)
call sGMT('gmtset FONT_ANNOT_PRIMARY 9p')

if (.true.) then
call sGMT('pscontour -R0/6.5/-0.2/6.5 -Jx0.45i -P -K -Y5.5i -Ba2f1 -BWSne '//trim(table)//' -C'//trim(cpt)//' -I ->'//ps)
endif
if (.true.) then
lines(1)='3.25 7 pscontour (triangulate)'
call echo(tmp,lines(:1))
call sGMT('pstext '//trim(tmp)//' -R -J -O -K -N -F+f18p,Times-Roman+jCB ->>'//ps)
endif

if (.true.) then
call sGMT('surface '//trim(table)//' -R -I0.2 -G'//grd0)
call sGMT('grdview '//trim(grd0)//' -R -J -B -C'//trim(cpt)//' -Qs -O -K -X2.5i ->>'//ps)
endif
if (.true.) then
lines(1)='3.25 7 surface (tension = 0)'
call echo(tmp,lines(:1))
call sGMT('pstext '//trim(tmp)//' -R -J -O -K -N -F+f18p,Times-Roman+jCB ->>'//ps)
endif

if (.true.) then
call sGMT('surface '//trim(table)//' -R -I0.2 -G'//trim(grd5)//' -T0.5')
call sGMT('grdview '//trim(grd5)//' -R -J -B -C'//trim(cpt)//' -Qs -O -K -Y-3.75i -X-3.5i ->>'//ps)
lines(1)='3.25 7 surface (tension = 0.5)'
call echo(tmp,lines(:1))
call sGMT('pstext '//trim(tmp)//' -R -J -O -K -N -F+f18p,Times-Roman+jCB ->>'//ps)
endif

if (.true.) then
call sGMT('triangulate '//trim(table)//' -G'//trim(grdt)//' -R -I0.2 ->'//'NUL')
call sGMT('grdfilter '//trim(grdt)//' -G'//trim(grdf)//' -D0 -Fc1')
call sGMT('grdview '//trim(grdf)//' -R -J -B -C'//trim(cpt)//' -Qs -O -K -X3.5i ->>'//ps)
lines(1)='3.25 7 triangulate @~\256@~ gmt grdfilter'
call echo(tmp,lines(:1))
call sGMT('pstext '//trim(tmp)//' -R -J -O -K -N -F+f18p,Times-Roman+jCB ->>'//ps)
endif

if (.true.) then
lines(1)='3.2125 7.5 Gridding of Data'
call echo(tmp,lines(:1))
call sGMT('pstext '//trim(tmp)//' -R0/10/0/10 -Jx1i -O -K -N -F+f32p,Times-Roman+jCB -X-3.5i ->>'//ps)
endif
if (.true.) then
call sGMT('psscale -D3.21/0.35/5/0.25h -C'//trim(cpt)//' -O -Y-0.75i ->>'//ps)
endif
if (.false.) then
call sGMT('ps2raster '//trim(ps)//' -Tg')
endif
call sGMT_Destroy_Session()

call rm('gmt.conf')
call rm('gmt.history')
call rm(grd0)
call rm(grd5)
call rm(grdt)
call rm(grdf)
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
