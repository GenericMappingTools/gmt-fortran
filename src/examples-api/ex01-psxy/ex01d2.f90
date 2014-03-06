! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API
! gmtset, psxy and ps2raster 
! input data imported from user arrays
! API subroutines and functions sGMT_Create_Session, sGMT_Call_Module, sGMT_Destroy_Session,
! sGMT_Create_Data, sGMT_Init_Vector, sGMT_Get_ID and sGMT_Encode_ID
! messages by sGMT_Report
! ----------------------------------------------------------------------

program ex01d
use gmt
implicit none
integer,parameter :: nmax=10
real(8) x(0:nmax),y(0:nmax)
type(c_ptr) :: v=c_null_ptr            ! C pointer to GMT_VECTOR
type(GMT_VECTOR),pointer :: Fv=>null() ! Fortran pointer
integer(8) dim(0:1)
character(16) filedat,fileps
character(20) module
character(100) args
character(150) message
character(1) :: verbosity(0:6)=['Q','N','T','C','V','L','D']
integer i,id,ierr,bound,level

! GMT verbosity bound and message level
bound=GMT_MSG_NORMAL ! QUIET, NORMAL, TICTOC, COMPAT, VERBOSE, LONG_VERBOSE, DEBUG
level=GMT_MSG_NORMAL
  
fileps="ex01.ps"

! user data arrays
x=[(i,i=0,nmax)]
y=x*x

! create GMT session and set the verbosity bound level
call sGMT_Create_Session("Test",err=ierr)
module="gmtset"
args="GMT_VERBOSE "//verbosity(bound)
call sGMT_Call_Module(module=module,args=args)
write (message,"(a,i2)") "Create_Default_Session: ",ierr
call sGMT_Report(level=level,message=message)

! create, initialize and encode GMT_VECTOR
dim=[2,nmax+1]
call sGMT_Create_Data(dim=dim,resource=v,err=ierr)
write (message,"(a,i2)") "Create_Data: ",ierr
call sGMT_Report(level=level,message=message)
call sGMT_Init_Vector(resource=v,c1=x,c2=y)
call c_f_pointer(v,Fv)
write (message,"(a,2i7)") "Create_Data cols&rows: ",Fv%n_columns,Fv%n_rows
call sGMT_Report(level=level,message=message)
call sGMT_Get_ID(family=GMT_IS_DATASET,direction=GMT_IN,resource=v,object_ID=id)
call sGMT_Encode_ID(string=filedat,object_ID=id)
write (message,"(a,i2,2a)") "Get and Encode_ID: ",id," ",filedat
call sGMT_Report(level=level,message=message)

! call psxy
module="psxy"
args=trim(filedat)//" -JX16c/24c -R0/11/0/110 -Bx2+lx -By20+ly -BWS+tFig. -Sa1c -N -P ->"//trim(fileps)
call sGMT_Call_Module(module=module,args=args,err=ierr)
write (message,"(2a,i2)") "Call_Module: ",trim(module),ierr
call sGMT_Report(level=level,message=message)

! call ps2raster
module="ps2raster"
args=trim(fileps)//" -Tg"
call sGMT_Call_Module(module=module,args=args,err=ierr)
write (message,"(2a,i2)") "Call_Module: ",trim(module),ierr
call sGMT_Report(level=level,message=message)

! clean up
call sGMT_Destroy_Session(err=ierr)
write (message,"(a,i2)") "Test: Destroy_Session: ",ierr
if (level<=bound) print "(a)",trim(message)
end program
