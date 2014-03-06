! $Id$
! ----------------------------------------------------------------------
! Test of GMT API
! modules pscoast, psxy, pstext and ps2raster
! GMT API subroutines sGMT_Create_Session, sGMT_Call_Module, sGMT_Destroy_Session
! sGMT_Create_Data, sGMT_Init_Vector, sGMT_Get_ID and sGMT_Encode_ID
! ----------------------------------------------------------------------

program ex02b
use gmt
implicit none
integer,parameter :: nmax=2
real(8) x(nmax),y(nmax)
type(c_ptr) v,v2
integer(8) dim(0:1)
character(16) filedat,filedat2,filetxt,fileps
character(20) module
character(100) args
integer id,id2

! user data arrays
x(1)=  14.; y(1)=  50.
x(2)=-158.; y(2)=  21

filetxt="ex02-text.dat"
fileps ="ex02.ps"

! create GMT session
call sGMT_Create_Session("Test")

! create, initialize and encode GMT_VECTORs for lines and points
dim=[2,nmax]
call sGMT_Create_Data(family=GMT_IS_VECTOR,geometry=GMT_IS_LINE,dim=dim,resource=v)
call sGMT_Init_Vector(resource=v,c1=x,c2=y)
call sGMT_Get_ID(family=GMT_IS_DATASET,direction=GMT_IN,resource=v,object_ID=id)
call sGMT_Encode_ID(string=filedat,object_ID=id)

call sGMT_Create_Data(family=GMT_IS_VECTOR,geometry=GMT_IS_POINT,dim=dim,resource=v2)
call sGMT_Init_Vector(resource=v2,c1=x,c2=y)
call sGMT_Get_ID(family=GMT_IS_DATASET,direction=GMT_IN,resource=v2,object_ID=id2)
call sGMT_Encode_ID(string=filedat2,object_ID=id2)

! call pscoast
module="pscoast"
args="-JG-100/50/10c -R0/360/-90/90 -Bxg30 -Byg15 -Dl -Gsandybrown -Slightskyblue -P -K ->"//trim(fileps)
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

! call psxy for lines
! module="psxy"
! args=trim(filedat)//" -J -R -W1p,blue -O -K ->>"//trim(fileps)
! print *,trim(module)//" "//trim(args)
! call sGMT_Call_Module(module=module,args=args)
print *,'...line plotting skipped (GMT 5.1.1 segfault)'

! call psxy for points
module="psxy"
args=trim(filedat2)//" -J -R -Gyellow -Sc7p -W1p,blue -O -K ->>"//trim(fileps)
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

! call pstext
module="pstext"
args=trim(filetxt)//" -J -R -D0.25c/-0.4c -O ->>"//trim(fileps)
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

! call ps2raster
module="ps2raster"
args=trim(fileps)//" -Tg"
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

! clean up
call sGMT_Destroy_Session()
end program
