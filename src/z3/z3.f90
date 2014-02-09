! $Id: z3.f90 2 2014-01-28 10:25:41Z remko $
! ----------------------------------------------------------------------
! Test of GMT API
! with modules gmtset, psxy and ps2raster
! and GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
! GMT_Create_Data, GMT_Get_ID, GMT_Encode_ID and GMT_Report
! ----------------------------------------------------------------------
! To compile:
! ----------------------------------------------------------------------
! Linux (a.out)
!   gfortran mGMT.f90 z3.f90 -lgmt
!   g95 mGMT.f90 z3.f90 -lgmt
!   ifort mGMT.f90 z3.f90 -lgmt
!   pgfortran mGMT.f90 z3.f90 -L/opt/gmt/lib -lgmt
! ----------------------------------------------------------------------
! Windows (a.exe)
!   gfortran mGMT.f90 z3.f90 -Lc:/programs/gmt5/lib -lgmt
!   g95 mGMT.f90 z3.f90 -Lc:/programs/gmt5/lib -lgmt
!   ifort -o a mGMT.f90 z3.f90 c:\programs\gmt5\lib\gmt.lib
!   pgfortran -o a mGMT.f90 z3.f90 -Lc:/programs/gmt5/lib -lgmt
! ----------------------------------------------------------------------

PROGRAM TestPsxy3
USE iso_c_binding
USE mGMT
IMPLICIT NONE

! user data declarations
INTEGER,PARAMETER :: nmax=10
REAL(8),TARGET :: x(0:nmax),y(0:nmax)
INTEGER i

! GMT related declarations
TYPE(c_ptr) :: API=c_null_ptr          ! GMT API control structure
TYPE(c_ptr) :: v=c_null_ptr            ! C pointer to GMT_VECTOR
TYPE(GMT_VECTOR),POINTER :: Fv=>NULL() ! Fortran pointer to GMT_VECTOR
TYPE(c_ptr),POINTER :: Fdata(:)        ! Fortran pointer equivalent to C array of UNIVECTORs
INTEGER(c_int),POINTER :: Ftype(:)     ! Fortran pointer equivalent to C array of ints
! INTEGER(c_int) :: family,method,geometry,direction
REAL(c_double) :: wesn(6),inc(2)
INTEGER(c_int64_t) :: dim(0:1)         ! alias par
CHARACTER(16,c_char) :: filename
CHARACTER(100,c_char) :: args
CHARACTER(150,c_char) :: message
CHARACTER(1,c_char) :: verbosity(0:5)=['Q','N','C','V','L','D']
INTEGER(c_int) :: level
INTEGER(c_int) :: idIn,ierr

! interface to external conversion function
INTERFACE
FUNCTION cs(string) RESULT (result)
IMPORT c_char
CHARACTER(*,c_char) string
CHARACTER(len_trim(string)+1,c_char) result
END FUNCTION
END INTERFACE

! user data
do i=0,nmax
	x(i)=i ; y(i)=i*i
enddo

! GMT verbosity
level=GMT_MSG_VERBOSE ! QUIET, NORMAL, COMPAT, VERBOSE, LONG_VERBOSE, DEBUG

! create GMT session
API=GMT_Create_Session(cs("Test"),2,0,0);
ierr=GMT_Call_Module(API,cs("gmtset"),GMT_MODULE_CMD,cs("GMT_VERBOSE "//verbosity(level)))
write (message,"(a,l1,a)") "Create_Session: ",c_associated(API),c_new_line
ierr=GMT_Report(API,GMT_MSG_NORMAL,cs(message))

! create GMT data
dim=[2,nmax+1]
wesn=0. ; inc=0.
v=GMT_Create_Data(API,family=GMT_IS_VECTOR,geometry=GMT_IS_POINT,mode=0,dim=dim, &
	wesn=c_null_ptr,inc=c_null_ptr,registration=0,pad=0,data=c_null_ptr)
write (message,"(a,l1,a)") "Create_Data: ",c_associated(v),c_new_line
ierr=GMT_Report(API,GMT_MSG_NORMAL,cs(message))

! associate GMT_VECTOR components with user data
call c_f_pointer(v,Fv)                         ! F pointer to C structure
call c_f_pointer(Fv%data,Fdata,[Fv%n_columns]) ! F pointer to C array of UNIVECTORs
call c_f_pointer(Fv%type,Ftype,[Fv%n_columns]) ! F pointer to integer/enum arrays
Ftype(1)=GMT_DOUBLE
Fdata(1)=c_loc(x)
Ftype(2)=GMT_DOUBLE
Fdata(2)=c_loc(y)
write (message,"(a,2i7,a)") "Create_Data cols&rows: ",Fv%n_columns,Fv%n_rows,c_new_line
ierr=GMT_Report(API,GMT_MSG_NORMAL,cs(message))

! get id for GMT_VECTOR
idIn=GMT_Get_ID(API,family=GMT_IS_DATASET,direction=GMT_IN,resource=v);
write (message,"(a,i7,a)") "Get_ID: ",idIn,c_new_line
ierr=GMT_Report(API,GMT_MSG_NORMAL,cs(message))

! get a filename for GMT_VECTOR
ierr=GMT_Encode_ID(API,string=filename,object_ID=idIn)
write (message,"(3a)") "Encode_ID: ",filename(1:15),c_new_line
ierr=GMT_Report(API,GMT_MSG_NORMAL,cs(message))

! call psxy
write(args,"(100(a,1x))") filename(:15), &
	"-JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P ->xy.ps"
write (message,"(3a)") "args = ",trim(args),c_new_line
ierr=GMT_Report(API,GMT_MSG_NORMAL,cs(message))
ierr=GMT_Call_Module(API,cs("psxy"),GMT_MODULE_CMD,cs(args))
write (message,"(2a,i7,a)") "Call_Module: ","psxy",ierr,c_new_line
ierr=GMT_Report(API,GMT_MSG_NORMAL,cs(message))

! call ps2raster
ierr=GMT_Call_Module(API,cs("ps2raster"),GMT_MODULE_CMD,cs("xy.ps -Tg"))
write (message,"(2a,i7,a)") "Call_Module: ","ps2raster",ierr,c_new_line
ierr=GMT_Report(API,GMT_MSG_NORMAL,cs(message))

! clean up
ierr=GMT_Destroy_Session(API)
write (message,"(a,i7)") "Test: Destroy_Session: ",ierr
if (GMT_MSG_NORMAL<=level) print "(a)",trim(message)
END PROGRAM

! ----------------------------------------------------------------------
! return a C string (remove trailing blanks, add trailing \0)
! usage: cs(string) instead of string\\c_null_char
! ----------------------------------------------------------------------
! INTERFACE
! FUNCTION cs(string) RESULT (result)
! IMPORT c_char
! CHARACTER(*,c_char) string
! CHARACTER(len_trim(string)+1,c_char) result
! END FUNCTION
! END INTERFACE
! ----------------------------------------------------------------------
FUNCTION cs(string) RESULT (result)
USE iso_c_binding
CHARACTER(*,c_char) string
CHARACTER(len_trim(string)+1,c_char) result
if (index(string,c_null_char)>0) then       ! is string a C string?
	result=string
else
	result=trim(string)//c_null_char
endif
END FUNCTION
