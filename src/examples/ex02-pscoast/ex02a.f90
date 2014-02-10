! $Id$
! ----------------------------------------------------------------------
! Test of GMT API
! modules pscoast, psxy, pstext and ps2raster
! GMT API functions GMT_Create_Session, GMT_Call_Module and GMT_Destroy_Session
! ----------------------------------------------------------------------

program ex02a
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

! call pscoast
write(args,"(100(a,1x))") "-JG-100/50/10c -R0/360/-90/90 -Bg30/g15 -Dl -Gsandybrown -Slightskyblue -P -K","->ex02.ps"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"pscoast"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","pscoast",ierr

! call psxy for lines
filename="ex02-line.dat"
write(args,"(100(a,1x))") trim(filename),"-J -R -W1p,blue -O -K","->>ex02.ps"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"psxy"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","psxy",ierr

! call psxy for points
filename="ex02-line.dat"
write(args,"(100(a,1x))") trim(filename),"-J -R -Gyellow -Sc7p -W1p,blue -O -K","->>ex02.ps"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"psxy"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","psxy",ierr

! call pstext
filename="ex02-text.dat"
write(args,"(100(a,1x))") trim(filename),"-J -R -D0.25c/-0.4c -O","->>ex02.ps"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"pstext"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","pstext",ierr

! call ps2raster
ierr=GMT_Call_Module(API,"ps2raster"//c_null_char,GMT_MODULE_CMD,"ex02.ps -Tg"//c_null_char)
print *,"Call_Module: ","ps2raster",ierr

! clean up
ierr=GMT_Destroy_Session(API)
print *,"Destroy_Session: ",ierr
end program
