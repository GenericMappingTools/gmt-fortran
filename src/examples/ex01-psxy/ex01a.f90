! $Id$
! ----------------------------------------------------------------------
! Test of GMT API
! modules psxy and ps2raster
! GMT API functions GMT_Create_Session, GMT_Call_Module and GMT_Destroy_Session
! ----------------------------------------------------------------------

program ex01a
use iso_c_binding
use gmt
implicit none

! GMT related declarations
type(c_ptr) :: API=c_null_ptr
character(16,c_char) :: filename
character(100,c_char) :: args
integer(c_int) :: ierr

! create GMT session
API=GMT_Create_Session("Test"//c_null_char,2,0,0)
print *,"Create_Session: ",c_associated(API)

! call psxy
filename="ex01-xy.dat"
write(args,"(100(a,1x))") trim(filename),"-JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P ->ex01.ps"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"psxy"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","psxy",ierr

! call ps2raster
ierr=GMT_Call_Module(API,"ps2raster"//c_null_char,GMT_MODULE_CMD,"ex01.ps -Tg"//c_null_char)
print *,"Call_Module: ","ps2raster",ierr

! clean up
ierr=GMT_Destroy_Session(API)
print *,"Destroy_Session: ",ierr
end program
