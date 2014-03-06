! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! psxy and ps2raster
! C API functions (cGMT_*), no optional arguments, explicit session, error checking
! cGMT_Create_Session, cGMT_Call_Module and cGMT_Destroy_Session
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
API=cGMT_Create_Session("Test"//c_null_char,2,0,0)
print *,"Create_Session: ",merge(0,1,c_associated(API))

! call psxy
module="psxy"
args=trim(filedat)//" -JX16c/24c -R0/11/0/110 -Bx2+lx -By20+ly -BWS+tFig. -Sa1c -N -P ->"//trim(fileps)
ierr=cGMT_Call_Module(API,trim(module)//c_null_char,GMT_MODULE_CMD,trim(args)//c_null_char)
print *,"Call_Module: ",trim(module),ierr

! call ps2raster
module="ps2raster"
args=trim(fileps)//" -Tg"
ierr=cGMT_Call_Module(API,trim(module)//c_null_char,GMT_MODULE_CMD,trim(args)//c_null_char)
print *,"Call_Module: ",trim(module),ierr

! clean up
ierr=cGMT_Destroy_Session(API)
print *,"Destroy_Session: ",ierr
end program
