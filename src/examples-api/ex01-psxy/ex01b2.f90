! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! psxy and ps2raster
! input data imported from user arrays by sGMT_Init_Vector subroutine with C pointer to GMT_VECTOR
! API functions GMT_Create_Default_Session, GMT_Call_Module, GMT_Destroy_Session,
! GMT_Create_Data, GMT_Get_ID and GMT_Encode_ID
! ----------------------------------------------------------------------

program ex01b
use gmt
implicit none
integer,parameter :: nmax=10
real(8) x(0:nmax),y(0:nmax)
type(c_ptr) v               ! C pointer to GMT_VECTOR
integer(8) dim(0:1)
character(16) filedat,fileps
character(20) module
character(100) args
integer i,id,ierr

fileps="ex01.ps"

! user data arrays
x=[(i,i=0,nmax)]
y=x*x

! create GMT session
print *,"Create_Default_Session: ",GMT_Create_Default_Session("Test")

! create, initialize and encode GMT_VECTOR
dim=[2,nmax+1]
v=GMT_Create_Data(family=GMT_IS_VECTOR,geometry=GMT_IS_POINT,dim=dim,err=ierr)
print *,"Create_Data: ",ierr
call sGMT_Init_Vector(resource=v,c1=x,c2=y)
id=GMT_Get_ID(family=GMT_IS_DATASET,direction=GMT_IN,resource=v)
ierr=GMT_Encode_ID(string=filedat,object_ID=id)
print *,"Get and Encode_ID: ",id,filedat

! call psxy
module="psxy"
args=trim(filedat)//" -JX16c/24c -R0/11/0/110 -Bx2+lx -By20+ly -BWS+tFig. -Sa1c -N -P ->"//trim(fileps)
print *,"Call_Module: ",trim(module),GMT_Call_Module(module=module,args=args)

! call ps2raster
module="ps2raster"
args=trim(fileps)//" -Tg"
print *,"Call_Module: ",trim(module),GMT_Call_Module(module=module,args=args)

! clean up
print *,"Destroy_Session: ",GMT_Destroy_Session()
end program
