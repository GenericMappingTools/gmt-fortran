! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! psxy and ps2raster
! API functions (GMT_*), no optional arguments, explicit session, error checking
! GMT_Create_Session, GMT_Call_Module and GMT_Destroy_Session
! ----------------------------------------------------------------------

program ex01a
use gmt
implicit none
character(16) filedat,fileps
character(20) module
character(100) args
type(c_ptr) API
integer ierr

filedat="ex01-xy.dat"
fileps="ex01.ps"

! create GMT session
API=GMT_Create_Session("Test",2,0,0,ierr)
print *,"Create_Session: ",ierr

! call psxy
module="psxy"
args=trim(filedat)//" -JX16c/24c -R0/11/0/110 -Bx2+lx -By20+ly -BWS+tFig. -Sa1c -N -P ->"//trim(fileps)
ierr=GMT_Call_Module(API,module,GMT_MODULE_CMD,args)
print *,"Call_Module: ",trim(module),ierr

! call ps2raster
module="ps2raster"
args=trim(fileps)//" -Tg"
ierr=GMT_Call_Module(API,module,GMT_MODULE_CMD,args)
print *,"Call_Module: ",trim(module),ierr

! clean up
ierr=GMT_Destroy_Session(API)
print *,"Destroy_Session: ",ierr
end program
