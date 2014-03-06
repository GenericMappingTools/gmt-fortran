! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! psxy and ps2raster
! input data imported from user arrays by sGMT_Create_Init_Encode subroutine
! API subroutines sGMT_Create_Session, sGMT_Call_Module, sGMT_Destroy_Session
! ----------------------------------------------------------------------

program ex01b
use gmt
implicit none
integer,parameter :: nmax=10
real(8) x(0:nmax),y(0:nmax)
integer(8) dim(0:1)
character(16) filedat,fileps
character(20) module
character(100) args
integer i,id

fileps="ex01.ps"

! user data arrays
x=[(i,i=0,nmax)]
y=x*x

! create GMT session
call sGMT_Create_Session("Test")

! create, initialize and encode GMT_VECTOR
dim=[2,nmax+1]
call sGMT_Create_Init_Encode(family=GMT_IS_VECTOR,geometry=GMT_IS_POINT,dim=dim,c1=x,c2=y,object_ID=id,string=filedat)
print *,"Create_Init_Encode: ",id,filedat

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
