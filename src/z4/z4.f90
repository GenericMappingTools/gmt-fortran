! $Id: z4.f90 2 2014-01-28 10:25:41Z remko $
! ----------------------------------------------------------------------
! Test of GMT API
! with modules xyz2grd, makecpt; psbasemap, grdimage, grdcontour, psscale; ps2raster
! and GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
! GMT_Create_Data, GMT_Get_ID, GMT_Encode_ID,
! GMT_Register_IO, GMT_Retrieve_Data, GMT_Duplicate_Data
! ----------------------------------------------------------------------
! To compile:
! ----------------------------------------------------------------------
! Linux (a.out)
!   gfortran mGMT.f90 z4.f90 -lgmt
!   g95 mGMT.f90 z4.f90 -lgmt
!   ifort mGMT.f90 z4.f90 -lgmt
!   pgfortran mGMT.f90 z4.f90 -L/opt/gmt/lib -lgmt
! ----------------------------------------------------------------------
! Windows (a.exe)
!   gfortran mGMT.f90 z4.f90 -Lc:/programs/gmt5/lib -lgmt
!   g95 mGMT.f90 z4.f90 -Lc:/programs/gmt5/lib -lgmt
!   ifort -o a mGMT.f90 z4.f90 c:\programs\gmt5\lib\gmt.lib
!   pgfortran -o a mGMT.f90 z4.f90 -Lc:/programs/gmt5/lib -lgmt
! ----------------------------------------------------------------------

PROGRAM TestPsxy4
USE iso_c_binding
USE mGMT
IMPLICIT NONE

! user data declarations
INTEGER,PARAMETER :: nx=200,ny=120
REAL(8),PARAMETER :: a=2.,b=1.
REAL(8),PARAMETER :: xmin=-2.,xmax=2.,ymin=-1.2_8,ymax=1.2_8
REAL(8) :: x(0:nx),y(0:ny)
REAL(8),DIMENSION(nx+1,ny+1),TARGET :: z,colx,coly
INTEGER ix,iy

! GMT related declarations
TYPE(c_ptr) :: API=c_null_ptr          ! GMT API control structure
TYPE(c_ptr) :: v=c_null_ptr            ! C pointer to GMT_VECTOR
TYPE(GMT_VECTOR),POINTER :: Fv=>NULL() ! Fortran pointer to GMT_VECTOR
TYPE(c_ptr),POINTER :: Fdata(:)        ! Fortran pointer equivalent to C array of UNIVECTORs
INTEGER(c_int),POINTER :: Ftype(:)     ! Fortran pointer equivalent to C array of ints
REAL(c_double) :: wesn(6),inc(2)
INTEGER(c_int64_t) :: dim(0:1)         ! alias par
CHARACTER(16,c_char) :: fileIn,fileGRD,fileGRD2,fileCPT
CHARACTER(100,c_char) :: args
TYPE(c_ptr) :: pGRD,pGRD2,pCPT
INTEGER(c_int) :: idIn,idGRD,idGRD2,idCPT,ierr

! user data
x=xmin+(xmax-xmin)*[(ix,ix=0,nx)]/nx
y=ymin+(ymax-ymin)*[(iy,iy=0,ny)]/ny
colx=spread(x,2,ny+1)
coly=spread(y,1,nx+1)
z=a*colx**2+b*coly**2

! create GMT session
API=GMT_Create_Session("Test"//c_null_char,2,0,0);
print *,"Create_Session: ",c_associated(API)

! create GMT data
dim=[3,(nx+1)*(ny+1)]
wesn=0. ; inc=0.
v=GMT_Create_Data(API,GMT_IS_VECTOR,GMT_IS_POINT,0,dim,c_null_ptr,c_null_ptr,0,0,c_null_ptr)
print *,"Create_Data: ",c_associated(v)

! associate GMT_VECTOR components with user data
call c_f_pointer(v,Fv)                         ! F pointer to C structure
call c_f_pointer(Fv%data,Fdata,[Fv%n_columns]) ! F pointer to C array of UNIVECTORs
call c_f_pointer(Fv%type,Ftype,[Fv%n_columns]) ! F pointer to integer/enum arrays
Fdata(1)=c_loc(colx)
Ftype(1)=GMT_DOUBLE
Fdata(2)=c_loc(coly)
Ftype(2)=GMT_DOUBLE
Fdata(3)=c_loc(z)
Ftype(3)=GMT_DOUBLE
print *,"Create_Data cols&rows: ",Fv%n_columns,Fv%n_rows

! get id and filename for GMT_VECTOR
idIn=GMT_Get_ID(API,GMT_IS_DATASET,GMT_IN,v);
ierr=GMT_Encode_ID(API,fileIn,idIn)
print *,"GMT_VECTOR Get_ID & Encode ID: ",idIn,fileIn

! create and register GRD in memory
idGRD=GMT_Register_IO(API,GMT_IS_GRID,GMT_IS_REFERENCE,GMT_IS_SURFACE,GMT_OUT,c_null_ptr,c_null_ptr)
ierr=GMT_Encode_ID(API,fileGRD,idGRD)
print *,"GRD Register_ID & Encode ID:",idGRD,fileGRD
write (args,"(100(a,1x))") fileIn(:15),"-G"//fileGRD(:15),"-R-2/2/-1.2/1.2 -I.02/.02"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"xyz2grd"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","xyz2grd",ierr
pGRD=GMT_Retrieve_Data(API,idGRD)
idGRD=GMT_Register_IO(API,GMT_IS_GRID,GMT_IS_REFERENCE,GMT_IS_SURFACE,GMT_IN,c_null_ptr,pGRD)
ierr=GMT_Encode_ID(API,fileGRD,idGRD)
print *,"GRD Retrieve_Data & reRegister_IO: ",c_associated(pGRD),idGRD,fileGRD
! using a grid two times requires data duplication (v.5.1.0)
! cf. http://gmt.soest.hawaii.edu/boards/2/topics/157
pGRD2=GMT_Duplicate_Data(API,GMT_IS_GRID,GMT_DUPLICATE_DATA_ENUM,pGRD)
idGRD2=GMT_Register_IO(API,GMT_IS_GRID,GMT_IS_REFERENCE,GMT_IS_SURFACE,GMT_IN,c_null_ptr,pGRD2)
ierr=GMT_Encode_ID(API,fileGRD2,idGRD2)
print *,"GRD2 Register_IO: ",c_associated(pGRD2),.not.c_associated(pGRD2,pGrd),idGRD2,fileGRD2

! create and register CPT in memory
idCPT=GMT_Register_IO(API,GMT_IS_CPT,GMT_IS_REFERENCE,GMT_IS_NONE,GMT_OUT,c_null_ptr,c_null_ptr)
ierr=GMT_Encode_ID(API,fileCPT,idCPT)
print *,"CPT Register_ID & Encode ID: ",idCPT,fileCPT
write (args,"(100(a,1x))") "-Crainbow -T0/10/2 -Z ->"//fileCPT(:15)
print *,trim(args)
ierr=GMT_Call_Module(API,"makecpt"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","makecpt",ierr
pCPT=GMT_Retrieve_Data(API,idCPT)
idCPT=GMT_Register_IO(API,GMT_IS_CPT,GMT_IS_REFERENCE,GMT_IS_NONE,GMT_IN,c_null_ptr,pCPT)
ierr=GMT_Encode_ID(API,fileCPT,idCPT)
print *,"CPT Retrive_Data & reRegister_IO: ",c_associated(pCPT),idCPT,fileCPT

! create PostScript
write (args,"(100(a,1x))") "-JX14c/8c -R -Ba0.5::/a0.5::WeSn:.Fig.: -P -K ->xyz.ps"
print *,trim(args)
ierr=GMT_Call_Module(API,"psbasemap"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","psbasemap",ierr

write (args,"(100(a,1x))") fileGRD(:15),"-J -R -B -C"//fileCPT(:15),"-O -K ->>xyz.ps"
print *,trim(args)
ierr=GMT_Call_Module(API,"grdimage"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","grdimage",ierr

write (args,"(100(a,1x))") fileGRD2(:15),"-J -R -B -C2 -O -K ->>xyz.ps"
print *,trim(args)
ierr=GMT_Call_Module(API,"grdcontour"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","grdcontour",ierr

write (args,"(100(a,1x))") "-D15c/4c/8c/1c -C"//fileCPT(:15),"-O ->>xyz.ps"
print *,trim(args)
ierr=GMT_Call_Module(API,"psscale"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","psscale",ierr

! create PNG
write(args,"(100(a,1x))") "xyz.ps -Tg"
print *,"args = ",trim(args)
ierr=GMT_Call_Module(API,"ps2raster"//c_null_char,GMT_MODULE_CMD,args//c_null_char)
print *,"Call_Module: ","ps2raster",ierr

! clean up
ierr=GMT_Destroy_Session(API)
print *,"Destroy_Session: ",ierr
END PROGRAM
