! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! psxy and ps2raster
! API subroutines (sGMT_*), optional arguments, default session, no error checking
! sGMT_Create_Session, sGMT and sGMT_Destroy_Session
! ----------------------------------------------------------------------

program ex01a
use gmt
implicit none
character(16) filedat,fileps
character(200) cmd

filedat="ex01-xy.dat"
fileps="ex01.ps"

! create GMT session
call sGMT_Create_Session("Test")

! call psxy
cmd="psxy "//trim(filedat)//" -JX16c/24c -R0/11/0/110 -Bx2+lx -By20+ly -BWS+tFig. -Sa1c -N -P ->"//trim(fileps)
call sGMT(cmd)
print *,trim(cmd)

! call ps2raster
cmd="ps2raster "//trim(fileps)//" -Tg"
call sGMT(cmd)
print *,trim(cmd)

! clean up
call sGMT_Destroy_Session()
end program
