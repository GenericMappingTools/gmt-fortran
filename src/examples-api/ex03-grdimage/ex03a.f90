! $Id$
! ----------------------------------------------------------------------
! Test of GMT API
! modules xyz2grd, makecpt; psbasemap, grdimage, grdcontour, psscale; ps2raster
! GMT API sGMT_Create_Session, sGMT_Call_Module, sGMT_Destroy_Session,
! GMT_Create_Data, sGMT_Init_Vector, GMT_Get_ID and sGMT_Encode_ID
! ----------------------------------------------------------------------

program ex03a
use gmt
implicit none
integer,parameter :: nx=200,ny=120
real(8),parameter :: a=2.,b=1.
real(8),parameter :: xmin=-2.,xmax=2.,ymin=-1.2_8,ymax=1.2_8
real(8) x(0:nx),y(0:ny)
real(8),dimension(nx+1,ny+1) :: colx,coly,z
type(c_ptr) v
integer(8) dim(0:1)
character(16) fileDAT,fileGRD,fileCPT,filePS
character(20) module
character(100) args
integer id,ierr,ix,iy

fileGRD="ex03-xyz.grd"
fileCPT="ex03-xyz.cpt"
filePS ="ex03.ps"

! user data arrays
x=xmin+(xmax-xmin)*[(ix,ix=0,nx)]/nx
y=ymin+(ymax-ymin)*[(iy,iy=0,ny)]/ny
colx=spread(x,2,ny+1)
coly=spread(y,1,nx+1)
z=a*colx**2+b*coly**2

! create GMT session
call sGMT_Create_Session("Test",err=ierr)
print *,"Create_Session: ",ierr

! create, initialize and encode GMT_VECTOR
dim=[3,(nx+1)*(ny+1)]
v=GMT_Create_Data(dim=dim,err=ierr)
print *,"Create_Data: ",ierr
call sGMT_Init_Vector(resource=v,c1=colx,c2=coly,c3=z)
id=GMT_Get_ID(resource=v)
call sGMT_Encode_ID(string=fileDAT,object_ID=id)
print *,"Get & Encode ID: ",id,fileDAT

! create GRD
module="xyz2grd"
args=trim(fileDAT)//" -G"//trim(fileGRD)//" -R-2/2/-1.2/1.2 -I.02/.02"
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

! create CPT
module="makecpt"
args="-Crainbow -T0/10/2 -Z ->"//trim(fileCPT)
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

! create PostScript
module="psbasemap"
args="-JX14c/8c -R -Ba0.5 -BWeSn+tFig. -P -K ->"//trim(filePS)
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

module="grdimage"
args=trim(fileGRD)//" -J -R -B -C"//trim(fileCPT)//" -O -K ->>"//trim(filePS)
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

module="grdcontour"
args=trim(fileGRD)//" -J -R -B -C2 -O -K ->>"//trim(filePS)
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

module="psscale"
args="-D15c/4c/8c/1c -C"//trim(fileCPT)//" -O ->>"//trim(filePS)
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

! create PNG
module="ps2raster"
args=trim(filePS)//" -Tg"
print *,trim(module)//" "//trim(args)
call sGMT_Call_Module(module=module,args=args)

! clean up
call sGMT_Destroy_Session(err=ierr)
print *,"Destroy_Session: ",ierr
end program
