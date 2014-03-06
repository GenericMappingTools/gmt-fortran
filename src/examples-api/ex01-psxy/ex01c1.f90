! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! psxy and ps2raster
! input data imported from a file by GMT_Read_Data
! API subroutines and functions sGMT_Create_Session, sGMT_Call_Module, sGMT_Destroy_Session,
! GMT_Read_Data, GMT_Register_IO and sGMT_Encode_ID
! ----------------------------------------------------------------------

program ex01c
use gmt
implicit none
type(c_ptr) D                          ! C pointer to GMT_DATASET
type(GMT_DATASET),pointer :: FD        ! Fortran pointer to GMT_DATASET
type(GMT_DATATABLE),pointer :: FT(:)   ! Fortran pointer to GMT_DATATABLE
type(GMT_DATASEGMENT),pointer :: FS(:) ! Fortran pointer to GMT_DATASEGMENT
real(8),pointer :: FDmin(:),FDmax(:)   ! Fortran pointers equivalent to C array of doubles
real(8),pointer :: FTmin(:),FTmax(:)   ! Fortran pointers equivalent to C array of doubles
real(8),pointer :: FSmin(:),FSmax(:)   ! Fortran pointers equivalent to C array of doubles
type(c_ptr),pointer :: FDT,FTS         ! Fortran transient pointers needed for C **
character(16) filedat,fileps
character(20) module
character(100) args
integer id,ierr

filedat="ex01-xy.dat"
fileps="ex01.ps"

! create GMT session
call sGMT_Create_Session("Test")

! import data from file
D=GMT_Read_Data(family=GMT_IS_DATASET,geometry=GMT_IS_POINT,input=filedat,err=ierr)
print *,"Read_Data: ",ierr

! optional block to check data in GMT_DATASET - segfault in PGI and g95
if (.true.) then
call c_f_pointer(D,FD)
print *,"About D: ",FD%n_tables,FD%n_columns,FD%n_records
call c_f_pointer(FD%table,FDT)      ; call c_f_pointer(FDT,FT,[FD%n_tables])
print *,"About T: ",FT(1)%n_segments,FT(1)%n_columns,FT(1)%n_records
call c_f_pointer(FT(1)%segment,FTS) ; call c_f_pointer(FTS,FS,[FT(1)%n_segments])
print *,"About S: ",FS(1)%n_columns,FS(1)%n_rows
call c_f_pointer(FD%min,FDmin,[FD%n_columns])
call c_f_pointer(FD%max,FDmax,[FD%n_columns])
print *,"About D: ",real([FDmin(1),FDmax(1),FDmin(2),FDmax(2)])
call c_f_pointer(FT(1)%min,FTmin,[FT(1)%n_columns])
call c_f_pointer(FT(1)%max,FTmax,[FT(1)%n_columns])
print *,"About T: ",real([FTmin(1),FTmax(1),FTmin(2),FTmax(2)])
call c_f_pointer(FS(1)%min,FSmin,[FS(1)%n_columns])
call c_f_pointer(FS(1)%max,FSmax,[FS(1)%n_columns])
print *,"About S: ",real([FSmin(1),FSmax(1),FSmin(2),FSmax(2)])
endif

! register and encode id for GMT_DATASET
id=GMT_Register_IO(family=GMT_IS_DATASET,method=GMT_IS_REFERENCE,geometry=GMT_IS_POINT,direction=GMT_IN,resource=D)
! id=GMT_Get_ID(family=GMT_IS_DATASET,direction=GMT_IN,resource=D)
call sGMT_Encode_ID(string=filedat,object_ID=id)
print *,"Register and Encode_ID: ",id,filedat

! call psxy
module="psxy"
args=trim(filedat)//" -JX16c/24c -R0/11/0/110 -Bx2+lx -By20+ly -BWS+tFig. -Sa1c -N -P ->"//trim(fileps)
call sGMT_Call_Module(module=module,args=args)
print *,trim(module)//" "//trim(args)

! call ps2raster
module="ps2raster"
args=trim(fileps)//" -Tg"
call sGMT_Call_Module(module=module,args=args)
print *,trim(module)//" "//trim(args)

! clean up
call sGMT_Destroy_Session()
end program
