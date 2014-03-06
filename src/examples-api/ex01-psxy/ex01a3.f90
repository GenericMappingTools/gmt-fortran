! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! psxy and ps2raster
! API functions (GMT_*), optional arguments, default session, error checking
! GMT_Create_Default_Session, fGMT (alias GMTF) and GMT_Destroy_Session
! ----------------------------------------------------------------------

program ex01a
use gmt
implicit none
character(16) filedat,fileps
character(20) module
character(200) cmd

filedat="ex01-xy.dat"
fileps="ex01.ps"

! create GMT session
print *,"Create_Default_Session: ",GMT_Create_Default_Session("Test")

! call psxy
module="psxy"
cmd=trim(module)//" "//trim(filedat)//" -JX16c/24c -R0/11/0/110 -Bx2+lx -By20+ly -BWS+tFig. -Sa1c -N -P ->"//trim(fileps)
print *,"Call_Module: ",trim(module),fGMT(cmd)

! call ps2raster
module="ps2raster"
cmd=trim(module)//" "//trim(fileps)//" -Tg"
print *,"Call_Module: ",trim(module),GMTF(cmd)

! clean up
print *,"Destroy_Session: ",GMT_Destroy_Session()
end program
