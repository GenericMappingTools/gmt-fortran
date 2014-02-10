! $Id:$
! ----------------------------------------------------------------------
! Test of GMT API
! modules psxy and ps2raster
! GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
! GMT_Create_Data, GMT_Get_ID and GMT_Encode_ID
! ----------------------------------------------------------------------

program ex01b
use iso_c_binding
use gmt
implicit none

! user data declarations
integer,parameter :: nmax=10
real(8),target :: x(0:nmax),y(0:nmax)
integer i

! GMT related declarations
type(c_ptr) :: API=c_null_ptr          ! GMT API control structure
type(c_ptr) :: v=c_null_ptr            ! C pointer to GMT_VECTOR
type(GMT_VECTOR),pointer :: Fv=>NULL() ! Fortran pointer to GMT_VECTOR
type(c_ptr),pointer :: Fdata(:)        ! Fortran pointer equivalent to C array of UNIVECTORs
integer(c_int),pointer :: Ftype(:)     ! Fortran pointer equivalent to C array of ints
! integer(c_int) :: family,method,geometry,direction
real(c_double) :: wesn(6),inc(2)
integer(c_int64_t) :: dim(0:1)         ! alias par
character(16,c_char) :: filename
character(100,c_char) :: args
integer(c_int) :: idIn,ierr

! user data
do i=0,nmax
x(i)=i
y(i)=i*i
enddo

! create GMT session
API=GMT_Create_Session("Test"//c_null_char,2,0,0);
print *,"Create_Session: ",c_associated(API)

! create GMT_VECTOR
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

! call psxy
write(args,"(100(a,1x))") filename(:15),"-JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P ->ex01.ps"
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
