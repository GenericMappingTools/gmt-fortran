! $Id$
! ----------------------------------------------------------------------
! Test of GMT API
! modules psxy and ps2raster
! GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
! GMT_Read_Data, GMT_Register_IO and GMT_Encode_ID
! ----------------------------------------------------------------------

program ex01c
use iso_c_binding
use gmt
implicit none

! user data declarations
integer,parameter :: nmax=10

! GMT related declarations
type(c_ptr) :: API=c_null_ptr                  ! GMT API control structure
type(c_ptr) :: D=c_null_ptr                    ! C pointer to GMT_DATASET
type(GMT_DATASET),pointer :: FD=>NULL()        ! Fortran pointer to GMT_DATASET
type(GMT_DATATABLE),pointer :: FT(:)=>NULL()   ! Fortran pointer to GMT_DATATABLE
type(GMT_DATASEGMENT),pointer :: FS(:)=>NULL() ! Fortran pointer to GMT_DATASEGMENT
real(c_double),pointer :: FDmin(:),FDmax(:)    ! Fortran pointers equivalent to C array of doubles
real(c_double),pointer :: FTmin(:),FTmax(:)    ! Fortran pointers equivalent to C array of doubles
real(c_double),pointer :: FSmin(:),FSmax(:)    ! Fortran pointers equivalent to C array of doubles
type(c_ptr),pointer :: FDT,FTS                 ! Fortran transient pointers needed for C **
integer(c_int) :: mode
real(c_double) :: wesn(6)
character(16,c_char) :: filename
character(100,c_char) :: args
integer(c_int) :: idIn,ierr

! create GMT session
API=GMT_Create_Session("Test",2,0,0);
print *,"Create_Session: ",c_associated(API)

! import data from file
filename="ex01-xy.dat"
mode=0
wesn=0.
D=GMT_Read_Data(API,GMT_IS_DATASET,GMT_IS_FILE,GMT_IS_POINT,mode,c_null_ptr,trim(filename),c_null_ptr)
print *,"Read_Data: ",c_associated(D)

! optional: check data in GMT_DATASET - Windows gfortran and ifort ok, otherwise (Linux, g95, pgfortran always) run-time error
call c_f_pointer(D,FD)
call c_f_pointer(FD%table,FDT)      ; call c_f_pointer(FDT,FT,[FD%n_tables])
call c_f_pointer(FT(1)%segment,FTS) ; call c_f_pointer(FTS,FS,[FT(1)%n_segments])
call c_f_pointer(FD%min,FDmin,[FD%n_columns])
call c_f_pointer(FD%max,FDmax,[FD%n_columns])
call c_f_pointer(FT(1)%min,FTmin,[FT(1)%n_columns])
call c_f_pointer(FT(1)%max,FTmax,[FT(1)%n_columns])
call c_f_pointer(FS(1)%min,FSmin,[FS(1)%n_columns])
call c_f_pointer(FS(1)%max,FSmax,[FS(1)%n_columns])
print *,"About D: ",FD%n_tables,FD%n_columns,FD%n_records
print *,"About T: ",FT(1)%n_segments,FT(1)%n_columns,FT(1)%n_records
print *,"About S: ",FS(1)%n_columns,FS(1)%n_rows
print *,"About D: ",real([FDmin(1),FDmax(1),FDmin(2),FDmax(2)])
print *,"About T: ",real([FTmin(1),FTmax(1),FTmin(2),FTmax(2)])
print *,"About S: ",real([FSmin(1),FSmax(1),FSmin(2),FSmax(2)])

! get id for GMT_DATASET
idIn=GMT_Register_IO(API,GMT_IS_DATASET,GMT_IS_REFERENCE,GMT_IS_POINT,GMT_IN,c_null_ptr,D);
print *,"Register_IO: ",idIn

! get a filename for GMT_DATASET
ierr=GMT_Encode_ID(API,filename,idIn)
print *,"Encode_ID: ",filename

! call psxy
write(args,"(100(a,1x))") filename(:15),"-JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P ->ex01.ps"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args)
print *,"Call_Module: ","psxy",ierr

! call ps2raster
! ierr=GMT_Call_Module(API,"ps2raster",GMT_MODULE_CMD,"ex01.ps -Tg")
! print *,"Call_Module: ","ps2raster",ierr

! clean up
! ierr=GMT_Destroy_Session(API)
! print *,"Destroy_Session: ",ierr
end program
