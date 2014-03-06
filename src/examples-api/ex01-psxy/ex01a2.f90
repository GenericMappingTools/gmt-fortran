! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! psxy and ps2raster
! API subroutines (sGMT_*), optional arguments, default session, error checking
! sGMT_Create_Session, sGMT_Call_Module and sGMT_Destroy_Session
! ----------------------------------------------------------------------

program ex01a
use gmt
implicit none
character(16) filedat,fileps
character(20) module
character(100) args
integer ierr

filedat="ex01-xy.dat"
fileps="ex01.ps"

! create GMT session
call sGMT_Create_Session("Test",err=ierr)
print *,"Create_Default_Session: ",ierr

! call psxy
module="psxy"
args=trim(filedat)//" -JX16c/24c -R0/11/0/110 -Bx2+lx -By20+ly -BWS+tFig. -Sa1c -N -P ->"//trim(fileps)
call sGMT_Call_Module(module=module,args=args,err=ierr)
print *,"Call_Module: ",trim(module),ierr

! call ps2raster
module="ps2raster"
args=trim(fileps)//" -Tg"
call sGMT_Call_Module(module=module,args=args,err=ierr)
print *,"Call_Module: ",trim(module),ierr

! clean up
call sGMT_Destroy_Session(err=ierr)
print *,"Destroy_Session: ",ierr
end program
