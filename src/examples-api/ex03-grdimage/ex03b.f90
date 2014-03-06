! $Id$
! ----------------------------------------------------------------------
! Test of GMT API
! modules xyz2grd, makecpt; psbasemap, grdimage, grdcontour, psscale; ps2raster
! GMT API sGMT_Create_Session, sGMT_Call_Module, sGMT_Destroy_Session,
! sGMT_Create_Init_Encode, GMT_Register_IO, sGMT_Encode_ID, GMT_Retrieve_Data 
! and GMT_Duplicate_Data
! ----------------------------------------------------------------------

program ex03b
use gmt
implicit none
integer,parameter :: nx=200,ny=120
real(8),parameter :: a=2.,b=1.
real(8),parameter :: xmin=-2.,xmax=2.,ymin=-1.2_8,ymax=1.2_8
real(8) x(0:nx),y(0:ny)
real(8),dimension(nx+1,ny+1) :: colx,coly,z
integer(8) dim(0:1)
character(16) fileDAT,fileGRD,fileGRD2,fileCPT,filePS
character(20) module
character(100) :: args
type(c_ptr) :: pGRD,pGRD2,pCPT
integer idDAT,idGRD,idGRD2,idCPT,ierr,ix,iy

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
call sGMT_Create_Init_Encode(dim=dim,c1=colx,c2=coly,c3=z,object_ID=idDAT,string=fileDAT)
print *,"DAT Get & Encode ID: ",idDAT,trim(fileDAT)

! create and register GRD in memory
module="xyz2grd"
idGRD=GMT_Register_IO(family=GMT_IS_GRID,method=GMT_IS_REFERENCE,geometry=GMT_IS_SURFACE,direction=GMT_OUT)
call sGMT_Encode_ID(string=fileGRD,object_ID=idGRD)
print *,"GRD Register & Encode ID:",idGRD,trim(fileGRD)
args=trim(fileDAT)//" -G"//trim(fileGRD)//" -R-2/2/-1.2/1.2 -I.02/.02"
call sGMT_Call_Module(module=module,args=args,err=ierr)
print *,trim(module),' ',trim(args),ierr
pGRD=GMT_Retrieve_Data(object_ID=idGRD)
idGRD=GMT_Register_IO(family=GMT_IS_GRID,method=GMT_IS_REFERENCE,geometry=GMT_IS_SURFACE,resource=pGRD)
call sGMT_Encode_ID(string=fileGRD,object_ID=idGRD)
print *,"GRD Retrieve_Data & reRegister_IO: ",idGRD,trim(fileGRD)

! duplicate GRD
! as of v.5.1.1: using one GRD for grdimage and grdcontour breaks the latter
! the same for GMT_Register_IO(...,GMT_IS_REFERENCE+GMT_IO_RESET,...)
! the same for second registration of pGRD
! but data duplication helps
! cf. http://gmt.soest.hawaii.edu/boards/2/topics/157
pGRD2=GMT_Duplicate_Data(data=pGRD)
idGRD2=GMT_Register_IO(family=GMT_IS_GRID,method=GMT_IS_REFERENCE,geometry=GMT_IS_SURFACE,resource=pGRD2)
call sGMT_Encode_ID(string=fileGRD2,object_ID=idGRD2)
print *,"GRD2 Register_IO: ",idGRD2,trim(fileGRD2)

! create and register CPT in memory
module="makecpt"
idCPT=GMT_Register_IO(family=GMT_IS_CPT,method=GMT_IS_REFERENCE,geometry=GMT_IS_NONE,direction=GMT_OUT)
call sGMT_Encode_ID(string=fileCPT,object_ID=idCPT)
print *,"CPT Register & Encode ID: ",idCPT,trim(fileCPT)
args="-Crainbow -T0/10/2 -Z ->"//trim(fileCPT)
call sGMT_Call_Module(module=module,args=args,err=ierr)
print *,trim(module),' ',trim(args),ierr
pCPT=GMT_Retrieve_Data(object_ID=idCPT)
idCPT=GMT_Register_IO(family=GMT_IS_CPT,method=GMT_IS_REFERENCE,geometry=GMT_IS_NONE,resource=pCPT)
call sGMT_Encode_ID(string=fileCPT,object_ID=idCPT)
print *,"CPT Retrieve_Data & reRegister_IO: ",idCPT,trim(fileCPT)

! create PostScript
module="psbasemap"
args="-JX14c/8c -R -Ba0.5 -BWeSn+tFig. -P -K ->"//trim(filePS)
call sGMT_Call_Module(module=module,args=args,err=ierr)
print *,trim(module),' ',trim(args),ierr

module="grdimage"
args=trim(fileGRD)//" -J -R -B -C"//trim(fileCPT)//" -O -K ->>"//trim(filePS)
call sGMT_Call_Module(module=module,args=args,err=ierr)
print *,trim(module),' ',trim(args),ierr

module="grdcontour"
args=trim(fileGRD2)//" -J -R -B -C2 -O -K ->>"//trim(filePS)
call sGMT_Call_Module(module=module,args=args,err=ierr)
print *,trim(module),' ',trim(args),ierr

module="psscale"
args="-D15c/4c/8c/1c -C"//trim(fileCPT)//" -O ->>"//trim(filePS)
call sGMT_Call_Module(module=module,args=args,err=ierr)
print *,trim(module),' ',trim(args),ierr

! create PNG
module="ps2raster"
args=trim(filePS)//" -Tg"
call sGMT_Call_Module(module=module,args=args,err=ierr)
print *,trim(module),' ',trim(args),ierr

! clean up
call sGMT_Destroy_Session(err=ierr)
print *,"Destroy_Session: ",ierr
end program
