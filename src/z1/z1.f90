! $Id: z1.f90 2 2014-01-28 10:25:41Z remko $
! ----------------------------------------------------------------------
! Test of GMT API
! with modules psxy and ps2raster
! and GMT API functions GMT_Create_Session, GMT_Call_Module and GMT_Destroy_Session
! ----------------------------------------------------------------------
! To compile:
! ----------------------------------------------------------------------
! Linux (a.out)
!   gfortran mGMT.f90 z1.f90 -lgmt
!   g95 mGMT.f90 z1.f90 -lgmt
!   ifort mGMT.f90 z1.f90 -lgmt
!   pgfortran mGMT.f90 z1.f90 -L/opt/gmt/lib -lgmt
! ----------------------------------------------------------------------
! Windows (a.exe)
!   gfortran mGMT.f90 z1.f90 -Lc:/programs/gmt5/lib -lgmt
!   g95 mGMT.f90 z1.f90 -Lc:/programs/gmt5/lib -lgmt
!   ifort -o a mGMT.f90 z1.f90 c:\programs\gmt5\lib\gmt.lib
!   pgfortran -o a mGMT.f90 z1.f90 -Lc:/programs/gmt5/lib -lgmt
! ----------------------------------------------------------------------

PROGRAM TestPsxy1
USE iso_c_binding
USE mGMT
IMPLICIT NONE

! GMT related declarations
TYPE(c_ptr) :: API=c_null_ptr
CHARACTER(16,c_char) :: filename
CHARACTER(100,c_char) :: args
INTEGER(c_int) :: ierr

! create GMT session
API=GMT_Create_Session("Test"//c_null_char,2,0,0);
print *,"Create_Session: ",c_associated(API)

! call ps2raster
filename="xy.dat"
write(args,"(100(a,1x))") trim(filename), &
	"-JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P ->xy.ps"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"psxy"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","psxy",ierr

ierr=GMT_Call_Module(API,"ps2raster"//c_null_char,GMT_MODULE_CMD,"xy.ps -Tg"//c_null_char)
print *,"Call_Module: ","ps2raster",ierr

! clean up
ierr=GMT_Destroy_Session(API)
print *,"Destroy_Session: ",ierr
END PROGRAM
