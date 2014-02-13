! $Id$
! ----------------------------------------------------------------------
! Test of GMT API
! modules pscoast, psxy, pstext and ps2raster
! GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session
! GMT_Create_Data, GMT_Get_ID and GMT_Encode_ID
! ----------------------------------------------------------------------

program ex02b
use iso_c_binding
use gmt
implicit none

! user data declarations
integer,parameter :: nmax=2
real(8),target :: x(nmax),y(nmax)

! GMT related declarations
type(c_ptr) :: API=c_null_ptr                 ! GMT API control structure
type(c_ptr) :: v=c_null_ptr,v2=c_null_ptr     ! C pointer to GMT_VECTOR
type(GMT_VECTOR),pointer :: Fv=>NULL()        ! Fortran pointer to GMT_VECTOR
type(c_ptr),pointer :: Fdata(:),F2data(:)     ! Fortran pointer equivalent to C array of UNIVECTORs
integer(c_int),pointer :: Ftype(:), F2type(:) ! Fortran pointer equivalent to C array of ints
! integer(c_int) :: family,method,geometry,direction
real(c_double) :: wesn(6),inc(2)
integer(c_int64_t) :: dim(0:1)
character(16,c_char) :: filename,filename2
character(100,c_char) :: args
integer(c_int) :: idIn,idIn2,ierr

! user data
x(1)=  14.; y(1)=  50.
x(2)=-158.; y(2)=  21

! create GMT session
API=GMT_Create_Session("Test",2,0,0)
print *,"Create_Session: ",c_associated(API)

! create GMT_VECTOR
dim=[2,nmax]
wesn=0. ; inc=0.
v=GMT_Create_Data(API,GMT_IS_VECTOR,GMT_IS_POINT,0,dim,c_null_ptr,c_null_ptr,0,0,c_null_ptr)
print *,"Create_Data: ",c_associated(v)
v2=GMT_Create_Data(API,GMT_IS_VECTOR,GMT_IS_LINE,0,dim,c_null_ptr,c_null_ptr,0,0,c_null_ptr)
print *,"Create_Data: ",c_associated(v2)

! associate GMT_VECTOR components with user data
call c_f_pointer(v,Fv)                         ! F pointer to C structure
call c_f_pointer(Fv%data,Fdata,[Fv%n_columns]) ! F pointer to C array of UNIVECTORs
call c_f_pointer(Fv%type,Ftype,[Fv%n_columns]) ! F pointer to integer/enum arrays
Ftype(1)=GMT_DOUBLE
Fdata(1)=c_loc(x)
Ftype(2)=GMT_DOUBLE
Fdata(2)=c_loc(y)
call c_f_pointer(v2,Fv)                         ! F pointer to C structure
call c_f_pointer(Fv%data,F2data,[Fv%n_columns]) ! F pointer to C array of UNIVECTORs
call c_f_pointer(Fv%type,F2type,[Fv%n_columns]) ! F pointer to integer/enum arrays
F2type(1)=GMT_DOUBLE
F2data(1)=c_loc(x)
F2type(2)=GMT_DOUBLE
F2data(2)=c_loc(y)
print *,"Create_Data cols&rows: ",Fv%n_columns,Fv%n_rows

! call pscoast
write(args,"(100(a,1x))") "-JG-100/50/10c -R0/360/-90/90 -Bg30/g15 -Dl -Gsandybrown -Slightskyblue -P -K","->ex02.ps"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"pscoast",GMT_MODULE_CMD,args)
print *,"Call_Module: ","pscoast",ierr

! call psxy for points
idIn=GMT_Get_ID(API,GMT_IS_DATASET,GMT_IN,v);
ierr=GMT_Encode_ID(API,filename,idIn)
write(args,"(100(a,1x))") filename(:15),"-J -R -Gyellow -Sc7p -W1p,blue -O -K","->>ex02.ps"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args)
print *,"Call_Module: ","psxy",ierr

! call psxy for lines
! Linux: segfault, Windows: ok
! idIn2=GMT_Get_ID(API,GMT_IS_DATASET,GMT_IN,v2);
! ierr=GMT_Encode_ID(API,filename2,idIn2)
! write(args,"(100(a,1x))") filename2(:15),"-J -R -W1p,blue -O -K","->>ex02.ps"
! print *,"args = ",trim(args)
! ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args)
! print *,"Call_Module: ","psxy",ierr

! call pstext
filename="ex02-text.dat"
write(args,"(100(a,1x))") trim(filename),"-J -R -D0.25c/-0.4c -O","->>ex02.ps"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"pstext",GMT_MODULE_CMD,args)
print *,"Call_Module: ","pstext",ierr

! call ps2raster
ierr=GMT_Call_Module(API,"ps2raster",GMT_MODULE_CMD,"ex02.ps -Tg")
print *,"Call_Module: ","ps2raster",ierr

! clean up
ierr=GMT_Destroy_Session(API)
print *,"Destroy_Session: ",ierr
end program
