! $Id: z2.f90 2 2014-01-28 10:25:41Z remko $
! ----------------------------------------------------------------------
! Test of GMT API
! with modules psxy and ps2raster
! and GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
! GMT_Create_Data, GMT_Get_ID and GMT_Encode_ID
! ----------------------------------------------------------------------
! To compile:
! ----------------------------------------------------------------------
! Linux (a.out)
!   gfortran mGMT.f90 z2.f90 -lgmt
!   g95 mGMT.f90 z2.f90 -lgmt
!   ifort mGMT.f90 z2.f90 -lgmt
!   pgfortran mGMT.f90 z2.f90 -L/opt/gmt/lib -lgmt
! ----------------------------------------------------------------------
! Windows (a.exe)
!   gfortran mGMT.f90 z2.f90 -Lc:/programs/gmt5/lib -lgmt
!   g95 mGMT.f90 z2.f90 -Lc:/programs/gmt5/lib -lgmt
!   ifort -o a mGMT.f90 z2.f90 c:\programs\gmt5\lib\gmt.lib
!   pgfortran -o a mGMT.f90 z2.f90 -Lc:/programs/gmt5/lib -lgmt
! ----------------------------------------------------------------------

PROGRAM TestPsxy2
USE iso_c_binding
USE mGMT
IMPLICIT NONE

! user data declarations
INTEGER,PARAMETER :: nmax=10
REAL(8),TARGET :: x(0:nmax),y(0:nmax)
INTEGER i

! GMT related declarations
TYPE(c_ptr) :: API=c_null_ptr          ! GMT API control structure
TYPE(c_ptr) :: v=c_null_ptr            ! C pointer to GMT_VECTOR
TYPE(GMT_VECTOR),POINTER :: Fv=>NULL() ! Fortran pointer to GMT_VECTOR
TYPE(c_ptr),POINTER :: Fdata(:)        ! Fortran pointer equivalent to C array of UNIVECTORs
INTEGER(c_int),POINTER :: Ftype(:)     ! Fortran pointer equivalent to C array of ints
! INTEGER(c_int) :: family,method,geometry,direction
REAL(c_double) :: wesn(6),inc(2)
INTEGER(c_int64_t) :: dim(0:1)         ! alias par
CHARACTER(16,c_char) :: filename
CHARACTER(100,c_char) :: args
INTEGER(c_int) :: idIn,ierr

! user data
do i=0,nmax
	x(i)=i ; y(i)=i*i
enddo

! create GMT session
API=GMT_Create_Session("Test"//c_null_char,2,0,0);
print *,"Create_Session: ",c_associated(API)

! create GMT data
dim=[2,nmax+1]
wesn=0. ; inc=0.
v=GMT_Create_Data(API,GMT_IS_VECTOR,GMT_IS_POINT,0,dim,c_null_ptr,c_null_ptr,0,0,c_null_ptr)
print *,"Create_Data: ",c_associated(v)

! associate GMT_VECTOR components with user data
call c_f_pointer(v,Fv)                         ! F pointer to C structure
call c_f_pointer(Fv%data,Fdata,[Fv%n_columns]) ! F pointer to C array of UNIVECTORs
call c_f_pointer(Fv%type,Ftype,[Fv%n_columns]) ! F pointer to integer/enum arrays
Ftype(1)=GMT_DOUBLE
Fdata(1)=c_loc(x)
Ftype(2)=GMT_DOUBLE
Fdata(2)=c_loc(y)
print *,"Create_Data cols&rows: ",Fv%n_columns,Fv%n_rows

! get id for GMT_VECTOR
idIn=GMT_Get_ID(API,GMT_IS_DATASET,GMT_IN,v);
print *,"Get_ID: ",idIn

! get a filename for GMT_VECTOR
ierr=GMT_Encode_ID(API,filename,idIn)
print *,"Encode_ID: ",filename

! call ps2raster
write(args,"(100(a,1x))") filename(:15), &
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
