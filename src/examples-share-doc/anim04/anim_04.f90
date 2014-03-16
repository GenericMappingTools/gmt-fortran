!                 GMT ANIMATION 04
!                 $Id$
!
! Purpose:        Fortran OpenMP port of the GMT anim_04.sh script to visualize a NY to Miami flight
! Source script:  GMT5_HOME/share/doc/examples/anim04
! GMT modules:    project, makecpt, grdgradient, grdimage, psxy, pstext, ps2raster
! Unix/Win progs: mkdir, mv, rm, convert, qt_export

program anim_04
use gmt
use gmt_misc,only: operator(+),operator(-),i2ch,irandom,newunit,echo
implicit none
real(8) lon1,lat1,lon2,lat2,stride
real(8) altitude,tilt,azimuth,twist,Width,Height,px,py
real(8) lon,lat,dist
integer dpi,frame,id_path,id_bat,ierr
character(20) REGION,file,fileps,chID,lines(1)
character(20) input,name,ps,dir,path,grdint,cpt,tmp,batprefix,batsuffix,tmpecho
character(1) sep
logical,parameter :: makeTIF=.false.
logical isLinux

! ----- flight parameters
lon1=-73.8333  ! NY
lat1=40.75
lon2=-80.133   ! Miami
lat2=25.75
stride=100     ! stride in the original script: 5
altitude=160.0
tilt=55
azimuth=210
twist=0
Width=36.0
Height=34.0
px=7.2
py=4.8
dpi=100
REGION="-Rg"

! ----- file names
input="USEast_Coast.nc"
name="anim_04"
ps=name-".ps"
dir="frames"
tmp=i2ch(irandom(),4)
path=tmp-".path.d"
grdint=tmp-"_int.nc"
cpt=tmp-".cpt"
batprefix="run_ps2raster"
batsuffix=".bat"
call testLinux(isLinux)
sep=char(merge(47,92,isLinux)) ! / or \
call mkdir(dir,isLinux)
grdint=tmp-"_int.nc"
id_bat=newunit() ; open (id_bat,file=dir-sep-batprefix-batsuffix,status="replace")

! ----- set up a flight path
  call sGMT("project -C"-lon1-"/"-lat1+"-E"-lon2-"/"-lat2+"-G"-stride+"-Q ->"-path)
  call sGMT("makecpt -Cglobe -Z ->"-cpt)
  call sGMT("grdgradient"+input+"-A90 -Nt1 -G"-grdint)

  frame=0
  id_path=newunit() ; open (id_path,file=path)
  do
    read (id_path,*,iostat=ierr) lon,lat,dist
    if (ierr/=0) exit
    file=name-"_"-i2ch(frame,6)
    fileps=file-".ps"
    chID=i2ch(frame,4)

! ----- make PostScript
    call sGMT("grdimage -JG"-lon-"/"-lat-"/"-altitude-"/"-azimuth-"/"-tilt-"/"-twist-"/"-Width-"/"-Height-"/7i+"+REGION &
         +"-P -Y0.1i -X0.1i"+input+"-I"-grdint+"-C"-cpt+"--PS_MEDIA="-px-"ix"-py-"i -K ->"-fileps)
    call sGMT("psxy -R -J -O -K -W1p"+path+"->>"-fileps)
    lines(1)="0 4.6"+chID
    tmpecho=tmp-"_"-chID
    call echo(lines(:1),tmpecho)
    call sGMT("pstext"+tmpecho+"-R0/"-px-"/0/"-py+"-Jx1i -F+f14p,Helvetica-Bold+jTL -O ->>"-fileps)
    call rm(tmpecho,isLinux)
    call mv(fileps,dir,isLinux)

! ----- make TIF
    if (makeTIF) then
      call sGMT("ps2raster -E"-dpi+"-Tt"+dir-sep-fileps)
!     call execute_command_line("ps2raster -E"-dpi+"-Tt"+dir-sep-fileps)
!     call execute_command_line("ps2raster -E"-dpi+"-Tt"+dir-sep-fileps,wait=.false.)
    else
      write (id_bat,'(a)') "ps2raster -E"-dpi+"-Tt"+fileps
    endif
    print *,"Frame"+file+"completed"
    frame=frame+1
  enddo
  close (id_path)

  close (id_bat)
  call rm(grdint,isLinux)
  call sGMT_Destroy_Session()

! ----- create a movie
! convert -delay 10 -loop 0 $dir/$name_*.tif $name.gif
! qt_export $dir/anim_0_123456.tiff --video=h263,24,100, $name_movie.m4v
call makeHTML()

! ----- clean up temporary files
call rm(cpt,isLinux)
call rm(path,isLinux)

contains

subroutine makeHTML(file)
implicit none
character(*),optional :: file
if (present(file)) continue
print *,"Made"+frame+"frames at 480x720 pixels placed in subdirectory"+trim(dir)
end subroutine

! identify Linux vs. Windows
subroutine testLinux(isLinux)
implicit none
logical,intent(out) :: isLinux
integer id,ierr
character(10) file,line
file=i2ch(irandom(),4)
call execute_command_line("echo >"+file)
id=newunit() ; open (id,file=file)
read (id,*,iostat=ierr) line ! Linux: empty, Windows: "ECHO is on"
close (id,status='delete')
isLinux=ierr/=0
end subroutine

! call Linux/Win mkdir
subroutine mkdir(dir,isLinux)
implicit none
character(*) dir
logical isLinux
if (isLinux) then
  call execute_command_line("mkdir -p"+dir)
else
  call execute_command_line("if not exist"+dir-char(92)-"nul mkdir"+dir)
endif
end subroutine

! call Linux/Win move
subroutine mv(file1,file2,isLinux)
implicit none
character(*) file1,file2
logical isLinux
if (isLinux) then
  call execute_command_line("mv"+file1+file2)
else
  call execute_command_line("move"+file1+file2+"> nul")
endif
end subroutine

! call Linux/Win remove
subroutine rm(file,isLinux)
implicit none
character(*) file
logical isLinux
if (isLinux) then
  call execute_command_line("rm"+file)
else
  call execute_command_line("del"+file)
endif
end subroutine

! gfortran F2008 intrinsic, extension in actual ifort and pgfortran
subroutine execute_command_line(cmd)
implicit none
character(*) cmd
call system(cmd)
end subroutine

end program
