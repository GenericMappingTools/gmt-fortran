! $Id: mGMT.f90 2 2014-01-28 10:25:41Z remko $
! ----------------------------------------------------------------------
! Fortran enumerations, derived types and interfaces for GMT API
! ----------------------------------------------------------------------
! ----------------------------------------------------------------------
! To compile:
! ----------------------------------------------------------------------
! Windows & Linux
! gfortran -c mGMT.f90
! g95 -c mGMT.f90
! ifort -c mGMT.f90
! pgfortran -c mGMT.f90
! ----------------------------------------------------------------------

! ----------------------------------------------------------------------
MODULE mGMT
USE iso_c_binding

! ----------------------------------------------------------------------
! gmt_define.h: ENUMERATIONS
! ----------------------------------------------------------------------
ENUM,BIND(C)  ! GMT_enum_type
	ENUMERATOR :: GMT_CHAR=0,GMT_UCHAR,GMT_SHORT,GMT_USHORT,GMT_INT,GMT_UINT,GMT_LONG,GMT_ULONG, &
		GMT_FLOAT,GMT_DOUBLE,GMT_TEXT,GMT_DATETIME,GMT_N_TYPES
END ENUM
! -------------------------

! ----------------------------------------------------------------------
! gmt_resources.h: ENUMERATIONS
! ----------------------------------------------------------------------
ENUM,BIND(C)  ! GMT_enum_method
	ENUMERATOR :: GMT_IS_FILE=0,GMT_IS_STREAM,GMT_IS_FDESC,GMT_IS_DUPLICATE,GMT_IS_REFERENCE
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_via
	ENUMERATOR :: GMT_VIA_NONE=0,GMT_VIA_VECTOR=100,GMT_VIA_MATRIX=200,GMT_VIA_OUTPUT=2048
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_family
	ENUMERATOR :: GMT_IS_DATASET=0,GMT_IS_TEXTSET,GMT_IS_GRID,GMT_IS_CPT,GMT_IS_IMAGE, &
		GMT_IS_VECTOR,GMT_IS_MATRIX,GMT_IS_COORD
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_comment
	ENUMERATOR :: GMT_COMMENT_IS_TEXT=0,GMT_COMMENT_IS_OPTION=1,GMT_COMMENT_IS_COMMAND=2, &
		GMT_COMMENT_IS_REMARK=4,GMT_COMMENT_IS_TITLE=8,GMT_COMMENT_IS_NAME_X=16, &
		GMT_COMMENT_IS_NAME_Y=32,GMT_COMMENT_IS_NAME_Z=64,GMT_COMMENT_IS_COLNAMES=128,GMT_COMMENT_IS_RESET=256
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_api_err_enum
	ENUMERATOR :: GMT_NOTSET=-1,GMT_NOERROR=0
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_module_enum
	ENUMERATOR :: GMT_MODULE_EXIST=-3,GMT_MODULE_PURPOSE=-2,GMT_MODULE_OPT=-1,GMT_MODULE_CMD=0
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_io_enum
	ENUMERATOR :: GMT_IN=0,GMT_OUT,GMT_ERR
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_dimensions
	ENUMERATOR :: GMT_X=0,GMT_Y,GMT_Z
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_freg
	ENUMERATOR :: GMT_ADD_FILES_IF_NONE=1,GMT_ADD_FILES_ALWAYS=2,GMT_ADD_STDIO_IF_NONE=4,GMT_ADD_STDIO_ALWAYS=8, &
		GMT_ADD_EXISTING=16,GMT_ADD_DEFAULT=6
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_ioset
	ENUMERATOR :: GMT_IO_DONE=0,GMT_IO_ASCII=512,GMT_IO_RESET=32768,GMT_IO_UNREG=16384
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_read
	ENUMERATOR :: GMT_READ_DOUBLE=0,GMT_READ_NORMAL=0,GMT_READ_TEXT=1,GMT_READ_MIXED=2,GMT_FILE_BREAK=4
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_write
	ENUMERATOR :: GMT_WRITE_DOUBLE=0,GMT_WRITE_TEXT,GMT_WRITE_SEGMENT_HEADER,GMT_WRITE_TABLE_HEADER,GMT_WRITE_TABLE_START, &
		GMT_WRITE_NOLF=16
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_header
	ENUMERATOR :: GMT_HEADER_OFF=0,GMT_HEADER_ON
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_dest
	ENUMERATOR :: GMT_WRITE_OGR=-1,GMT_WRITE_SET,GMT_WRITE_TABLE,GMT_WRITE_SEGMENT,GMT_WRITE_TABLE_SEGMENT
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_alloc
	ENUMERATOR :: GMT_ALLOCATED_EXTERNALLY=0,GMT_ALLOCATED_BY_GMT=1
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_shape
	ENUMERATOR :: GMT_ALLOC_NORMAL=0,GMT_ALLOC_VERTICAL,GMT_ALLOC_HORIZONTAL
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_duplicate
	ENUMERATOR :: GMT_DUPLICATE_NONE=0,GMT_DUPLICATE_ALLOC,GMT_DUPLICATE_DATA_ENUM ! int GMT_DUPLICATE_DATA vs. function GMT_Duplicate_Data
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_out
	ENUMERATOR :: GMT_WRITE_NORMAL=0,GMT_WRITE_HEADER,GMT_WRITE_SKIP
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_FFT_mode
	ENUMERATOR :: GMT_FFT_FWD=0,GMT_FFT_INV=1,GMT_FFT_REAL=0,GMT_FFT_COMPLEX=1
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_time_mode
	ENUMERATOR :: GMT_TIME_NONE=0,GMT_TIME_CLOCK=1,GMT_TIME_ELAPSED=2,GMT_TIME_RESET=4
END ENUM
! -------------------------
ENUM,BIND(C)  ! enum GMT_enum_verbose
	ENUMERATOR :: GMT_MSG_QUIET=0,GMT_MSG_NORMAL,GMT_MSG_COMPAT,GMT_MSG_VERBOSE,GMT_MSG_LONG_VERBOSE,GMT_MSG_DEBUG
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_reg
	ENUMERATOR :: GMT_GRID_NODE_REG=0,GMT_GRID_PIXEL_REG=1,GMT_GRID_DEFAULT_REG=1024
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_gridindex
	ENUMERATOR :: GMT_XLO=0,GMT_XHI,GMT_YLO,GMT_YHI,GMT_ZLO,GMT_ZHI
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_dimindex
	ENUMERATOR :: GMT_TBL=0,GMT_SEG,GMT_ROW,GMT_COL
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_gridio
	ENUMERATOR :: GMT_GRID_IS_REAL=0,GMT_GRID_ALL=0,GMT_GRID_HEADER_ONLY=1,GMT_GRID_DATA_ONLY=2, &
		GMT_GRID_IS_COMPLEX_REAL=4,GMT_GRID_IS_COMPLEX_IMAG=8,GMT_GRID_IS_COMPLEX_MASK=12, &
		GMT_GRID_NO_HEADER=16,GMT_GRID_ROW_BY_ROW=32,GMT_GRID_ROW_BY_ROW_MANUAL=64
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_grdlen
	ENUMERATOR :: GMT_GRID_UNIT_LEN80=80,GMT_GRID_TITLE_LEN80=80,GMT_GRID_VARNAME_LEN80=80, &
		GMT_GRID_COMMAND_LEN320=320,GMT_GRID_REMARK_LEN160=160,GMT_GRID_NAME_LEN256=256,GMT_GRID_HEADER_SIZE=892
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_geometry
	ENUMERATOR :: GMT_IS_POINT=1,GMT_IS_LINE=2,GMT_IS_POLY=4,GMT_IS_PLP=7,GMT_IS_SURFACE=8,GMT_IS_NONE=16
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_pol
	ENUMERATOR :: GMT_IS_PERIMETER=0,GMT_IS_HOLE=1
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_ascii_input_return
	ENUMERATOR :: GMT_IO_DATA_RECORD=0,GMT_IO_TABLE_HEADER=1,GMT_IO_SEGMENT_HEADER=2,GMT_IO_ANY_HEADER=3,GMT_IO_MISMATCH=4, &
		GMT_IO_EOF=8,GMT_IO_NAN=16,GMT_IO_NEW_SEGMENT=18,GMT_IO_GAP=32,GMT_IO_LINE_BREAK=58,GMT_IO_NEXT_FILE=64
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_color
	ENUMERATOR :: GMT_CMYK=1,GMT_HSV=2,GMT_COLORINT=4,GMT_NO_COLORNAMES=8
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_bfn
	ENUMERATOR :: GMT_BGD,GMT_FGD,GMT_NAN
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_cpt
	ENUMERATOR :: GMT_CPT_REQUIRED,GMT_CPT_OPTIONAL
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_cptflags
	ENUMERATOR :: GMT_CPT_NO_BNF=1,GMT_CPT_EXTEND_BNF=2
END ENUM
! -------------------------
ENUM,BIND(C)  ! GMT_enum_fmt
	ENUMERATOR :: GMT_IS_ROW_FORMAT=0,GMT_IS_COL_FORMAT=1
END ENUM
! -------------------------

! ----------------------------------------------------------------------
! gmt_resources.h: DERIVED TYPES
! ----------------------------------------------------------------------
! TODO: struct GMT_GRID_HEADER
! TODO: struct GMT_GRID
! TODO: struct GMT_OGR
! TODO: struct GMT_OGR_SEG
! TODO: struct GMT_DATASEGMENT
! TODO: struct GMT_DATATABLE
! TODO: struct GMT_DATASET
! TODO: struct GMT_TEXTSEGMENT
! TODO: struct GMT_TEXTTABLE
! TODO: struct GMT_TEXTSET
! TODO: struct GMT_LUT
! TODO: struct GMT_BFN_COLOR
! TODO: struct GMT_PALETTE
! TODO: struct GMT_IMAGE
! not needed: union GMT_UNIVECTOR
! ----------------------------------------------------------------------
! struct GMT_VECTOR {	/* Single container for user vector(s) of data */
! /* Variables we document for the API: */
! uint64_t n_columns;		/* Number of vectors */
! uint64_t n_rows;		/* Number of rows in each vector */
! enum GMT_enum_reg registration;	/* 0 for gridline and 1 for pixel registration  */
! enum GMT_enum_type *type;	/* Array of data types (type of each uni-vector, e.g. GMT_FLOAT */
! union GMT_UNIVECTOR *data;	/* Array of uni-vectors */
! double range[2];		/* Contains tmin/tmax (or 0/0 if not equidistant) */
! char command[GMT_GRID_COMMAND_LEN320]; /* name of generating command */
! char remark[GMT_GRID_REMARK_LEN160];   /* comments re this data set */
! /* ---- Variables "hidden" from the API ---- */
! uint64_t id;			/* The internal number of the data set */
! unsigned int alloc_level;	/* The level it was allocated at */
! enum GMT_enum_alloc alloc_mode;	/* Allocation mode [GMT_ALLOCATED_BY_GMT] */
! };
! -------------------------
TYPE,BIND(C) :: GMT_VECTOR
	INTEGER(kind=c_int64_t) :: n_columns,n_rows
	INTEGER(kind=c_int) :: registration
	TYPE(c_ptr) :: type,data
	REAL(kind=c_double) :: range(0:1)
	CHARACTER(len=GMT_GRID_COMMAND_LEN320,kind=c_char) :: command
	CHARACTER(len=GMT_GRID_REMARK_LEN160,kind=c_char) :: remark
	INTEGER(kind=c_int64_t) :: id
	INTEGER(kind=c_int) :: alloc_level,alloc_mode
! g95: PRIVATE attribute not implemented
! INTEGER(kind=c_int64_t),PRIVATE :: id
! INTEGER(kind=c_int),PRIVATE :: alloc_level,alloc_mode
END TYPE
! -------------------------
! struct GMT_MATRIX {	/* Single container for a user matrix of data */
! /* Variables we document for the API: */
! uint64_t n_rows;		/* Number of rows in this matrix */
! uint64_t n_columns;		/* Number of columns in this matrix */
! uint64_t n_layers;		/* Number of layers in a 3-D matrix [1] */
! enum GMT_enum_fmt shape;	/* 0 = C (rows) and 1 = Fortran (cols) */
! enum GMT_enum_reg registration;	/* 0 for gridline and 1 for pixel registration  */
! size_t dim;			/* Allocated length of longest C or Fortran dim */
! size_t size;			/* Byte length of data */
! enum GMT_enum_type type;	/* Data type, e.g. GMT_FLOAT */
! double range[6];		/* Contains xmin/xmax/ymin/ymax[/zmin/zmax] */
! union GMT_UNIVECTOR data;	/* Union with pointer to actual matrix of the chosen type */
! char command[GMT_GRID_COMMAND_LEN320]; /* name of generating command */
! char remark[GMT_GRID_REMARK_LEN160];   /* comments re this data set */
! /* ---- Variables "hidden" from the API ---- */
! uint64_t id;			/* The internal number of the data set */
! unsigned int alloc_level;	/* The level it was allocated at */
! enum GMT_enum_alloc alloc_mode;	/* Allocation mode [GMT_ALLOCATED_BY_GMT] */
! };
! -------------------------
TYPE,BIND(C) :: GMT_MATRIX
	INTEGER(kind=c_int64_t) :: n_rows,n_columns,n_layers
	INTEGER(kind=c_int) :: shape,registration
	INTEGER(kind=c_size_t) :: dim,size
	INTEGER(kind=c_int) :: type
	REAL(kind=c_double) :: range(0:5)
	TYPE(c_ptr) :: data
	CHARACTER(len=GMT_GRID_COMMAND_LEN320,kind=c_char) :: command
	CHARACTER(len=GMT_GRID_REMARK_LEN160,kind=c_char) :: remark
	INTEGER(kind=c_int64_t) :: id
	INTEGER(kind=c_int) :: alloc_level,alloc_mode
! g95: PRIVATE attribute not implemented
! INTEGER(kind=c_int64_t),PRIVATE :: id
! INTEGER(kind=c_int),PRIVATE :: alloc_level,alloc_mode
END TYPE

! ----------------------------------------------------------------------
! gmt.h: C INTERFACES
! ----------------------------------------------------------------------
INTERFACE
! ----------------------------------------------------------------------
! 22 Primary API functions 
! ----------------------------------------------------------------------
! void * GMT_Create_Session(char *tag, unsigned int pad, unsigned int mode, int (*print_func) (FILE *, const char *));
! -------------------------
TYPE(c_ptr) FUNCTION GMT_Create_Session(tag,pad,mode,print_func) BIND(C,NAME='GMT_Create_Session')
IMPORT c_ptr,c_char,c_int,c_funptr
CHARACTER(len=1, kind=c_char) :: tag(*)
INTEGER(kind=c_int),VALUE :: pad,mode
INTEGER(kind=c_int),VALUE :: print_func   ! if actual argument is integer
! TYPE(c_funptr),VALUE :: print_func ! if actual argument is C function pointer 
END FUNCTION
! -------------------------
! void * GMT_Create_Data(void *API, unsigned int family, unsigned int geometry, unsigned int mode, uint64_t dim[], double *wesn, double *inc, unsigned int registration, int pad, void *data);
! -------------------------
TYPE(c_ptr) FUNCTION GMT_Create_Data(API,family,geometry,mode,dim,wesn,inc,registration,pad,data) BIND(C,NAME='GMT_Create_Data')
IMPORT c_ptr, c_int, c_int64_t, c_double
TYPE(c_ptr),VALUE :: API,data
INTEGER(kind=c_int),VALUE :: family,geometry,mode,registration,pad
INTEGER(kind=c_int64_t) :: dim(*)
TYPE(c_ptr),VALUE :: wesn,inc        ! if actual argument is C pointer
! REAL(kind=c_double) :: wesn(*),inc(*)   ! if actual argument is real(8) array
END FUNCTION
! -------------------------
! void * GMT_Get_Data(void *API, int object_ID, unsigned int mode, void *data);
! -------------------------
TYPE(c_ptr) FUNCTION GMT_Get_Data(API,object_ID,mode,data) BIND(C,NAME='GMT_Get_Data')
IMPORT c_ptr, c_int
TYPE(c_ptr),VALUE :: API,data
INTEGER(kind=c_int),VALUE :: object_ID,mode
END FUNCTION
! -------------------------
! void * GMT_Read_Data(void *API, unsigned int family, unsigned int method, unsigned int geometry, unsigned int mode, double wesn[], char *input, void *data);
! -------------------------
TYPE(c_ptr) FUNCTION GMT_Read_Data(API,family,method,geometry,mode,wesn,input,data) BIND(C,NAME='GMT_Read_Data')
	IMPORT c_ptr, c_int, c_double, c_char
	TYPE(c_ptr),VALUE :: API, data
	INTEGER(kind=c_int), VALUE :: family,method,geometry,mode
	TYPE(c_ptr), VALUE :: wesn        ! if actual argument is C pointer
! REAL(kind=c_double) :: wesn(*)          ! if actual argument is real(8) array
	CHARACTER(len=1,kind=c_char) :: input(*)
END FUNCTION
! -------------------------
! void * GMT_Retrieve_Data(void *API, int object_ID);
! -------------------------
TYPE(c_ptr) FUNCTION GMT_Retrieve_Data(API,object_ID) BIND(C,NAME='GMT_Retrieve_Data')
	IMPORT c_int,c_ptr
	TYPE(c_ptr),VALUE :: API
	INTEGER(kind=c_int),VALUE :: object_ID
END FUNCTION
! -------------------------
! void * GMT_Duplicate_Data(void *API, unsigned int family, unsigned int mode, void *data);
! -------------------------
TYPE(c_ptr) FUNCTION GMT_Duplicate_Data(API,family,mode,data) BIND(C,NAME='GMT_Duplicate_Data')
	IMPORT c_int,c_ptr
	TYPE(c_ptr),VALUE :: API,data
	INTEGER(kind=c_int),VALUE :: family,mode
END FUNCTION
! -------------------------
! void * GMT_Get_Record(void *API, unsigned int mode, int *retval);
! -------------------------
TYPE(c_ptr) FUNCTION GMT_Get_Record(API,mode,retval) BIND(C,NAME='GMT_Get_Record')
	IMPORT c_int,c_ptr
	TYPE(c_ptr),VALUE :: API
	INTEGER(kind=c_int),VALUE :: mode
	INTEGER(kind=c_int) :: retval
END FUNCTION
! -------------------------
! int GMT_Destroy_Session(void *API);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Destroy_Session(API) BIND(C,NAME='GMT_Destroy_Session')
	IMPORT c_int, c_ptr
	TYPE(c_ptr), VALUE :: API
END FUNCTION
! -------------------------
! int GMT_Register_IO(void *API, unsigned int family, unsigned int method, unsigned int geometry, unsigned int direction, double wesn[], void *resource);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Register_IO(API,family,method,geometry,direction,wesn,resource) BIND(C,NAME='GMT_Register_IO')
	IMPORT c_int, c_ptr, c_double
	TYPE(c_ptr), VALUE :: API, resource
	INTEGER(kind=c_int), VALUE :: family, method, geometry, direction
	TYPE(c_ptr),VALUE :: wesn            ! if actual argument is C pointer
! REAL(kind=c_double) :: wesn(*)          ! if actual argument is real(8) array
END FUNCTION
! -------------------------
! int GMT_Init_IO(void *API, unsigned int family, unsigned int geometry, unsigned int direction, unsigned int mode, unsigned int n_args, void *args);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Init_IO(API,family,geometry,direction,mode,n_args,args) BIND(C,NAME='GMT_Init_IO')
	IMPORT c_int, c_ptr
	TYPE(c_ptr),VALUE :: API,args
	INTEGER(kind=c_int),VALUE :: family,geometry,direction,mode,n_args
END FUNCTION
! -------------------------
! int GMT_Begin_IO(void *API, unsigned int family, unsigned int direction, unsigned int header);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Begin_IO(API,family,direction,header) BIND(C,NAME='GMT_Begin_IO')
IMPORT c_int,c_ptr
TYPE(c_ptr),VALUE :: API
INTEGER(kind=c_int),VALUE :: family,direction,header
END FUNCTION
! -------------------------
! int GMT_Status_IO(void *API, unsigned int mode);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Status_IO(API,mode) BIND(C,NAME='GMT_Status_IO')
IMPORT c_int,c_ptr
TYPE(c_ptr),VALUE :: API
INTEGER(kind=c_int),VALUE :: mode
END FUNCTION
! -------------------------
! int GMT_End_IO(void *API, unsigned int direction, unsigned int mode);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_End_IO(API,direction,mode) BIND(C,NAME='GMT_End_IO')
IMPORT c_int,c_ptr
TYPE(c_ptr),VALUE :: API
INTEGER(kind=c_int),VALUE :: direction,mode
END FUNCTION
! -------------------------
! int GMT_Put_Data(void *API, int object_ID, unsigned int mode, void *data);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Put_Data(API,object_ID,mode,data) BIND(C,NAME='GMT_Put_Data')
IMPORT c_int,c_ptr
TYPE(c_ptr),VALUE :: API,data
INTEGER(kind=c_int),VALUE :: object_ID,mode
END FUNCTION
! -------------------------
! int GMT_Write_Data(void *API, unsigned int family, unsigned int method, unsigned int geometry, unsigned int mode, double wesn[], char *output, void *data);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Write_Data(API,family,method,geometry,mode,wesn,output,data) BIND(C,NAME='GMT_Write_Data')
IMPORT c_int, c_ptr, c_double, c_char
TYPE(c_ptr),VALUE :: API,data
INTEGER(kind=c_int),VALUE :: family,method,geometry,mode
TYPE(c_ptr),VALUE :: wesn            ! if actual argument is C pointer
! REAL(kind=c_double) :: wesn(*)          ! if actual argument is real(8) array
CHARACTER(len=1,kind=c_char) :: output
END FUNCTION
! -------------------------
! int GMT_Destroy_Data(void *API, void *object);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Destroy_Data(API,object) BIND(C,NAME='GMT_Destroy_Data')
IMPORT c_int,c_ptr
TYPE(c_ptr),VALUE :: API,object
END FUNCTION
! -------------------------
! int GMT_Put_Record(void *API, unsigned int mode, void *record);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Put_Record(API,mode,record) BIND(C,NAME='GMT_Put_Record')
IMPORT c_int,c_ptr
TYPE(c_ptr),VALUE :: API,record
INTEGER(kind=c_int),VALUE :: mode
END FUNCTION
! -------------------------
! int GMT_Encode_ID(void *API, char *string, int object_ID);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Encode_ID(API,string,object_ID) BIND(C,NAME='GMT_Encode_ID')
	IMPORT c_int, c_ptr, c_char
	TYPE(c_ptr), VALUE :: API
	CHARACTER(len=1, kind=c_char) :: string(*)
	INTEGER(kind=c_int), VALUE :: object_ID
END FUNCTION
! -------------------------
! int GMT_Get_Row(void *API, int rec_no, struct GMT_GRID *G, float *row);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Get_Row(API,rec_no,G,row) BIND(C,NAME='GMT_Get_Row')
	IMPORT c_int, c_ptr
	TYPE(c_ptr), VALUE :: API
	INTEGER(kind=c_int), VALUE :: rec_no
	TYPE(c_ptr), VALUE :: G               ! struct GMT_GRID *
	TYPE(c_ptr), VALUE :: row             ! float *
END FUNCTION
! -------------------------
! int GMT_Put_Row(void *API, int rec_no, struct GMT_GRID *G, float *row);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Put_Row(API,rec_no,G,row) BIND(C,NAME='GMT_Put_Row')
	IMPORT c_int, c_ptr
	TYPE(c_ptr), VALUE :: API
	INTEGER(kind=c_int), VALUE :: rec_no
	TYPE(c_ptr), VALUE :: G               ! struct GMT_GRID *
	TYPE(c_ptr), VALUE :: row             ! float *
END FUNCTION
! -------------------------
! int GMT_Set_Comment(void *API, unsigned int family, unsigned int mode, void *arg, void *data);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Set_Comment(API,family,mode,arg,data) BIND(C,NAME='GMT_Set_Comment')
	IMPORT c_int, c_ptr
	TYPE(c_ptr), VALUE :: API,arg, data
	INTEGER(kind=c_int), VALUE :: family,mode
END FUNCTION
! -------------------------
! int GMT_Get_ID(void *API, unsigned int family, unsigned int direction, void *resource);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Get_ID(API,family,direction,resource) BIND(C,NAME='GMT_Get_ID')
	IMPORT c_int, c_ptr
	TYPE(c_ptr), VALUE :: API, resource
	INTEGER(kind=c_int),VALUE :: family, direction
END FUNCTION
! ----------------------------------------------------------------------
! 2 functions to relate (row,col) to a 1-D index and to precompute equidistant coordinates for grids and images 
! ----------------------------------------------------------------------
! int64_t GMT_Get_Index(void *API, struct GMT_GRID_HEADER *header, int row, int col);
! -------------------------
INTEGER(kind=c_int64_t) FUNCTION GMT_Get_Index(API,header,row,col) BIND(C,NAME='GMT_Get_Index')
	IMPORT c_int64_t, c_int, c_ptr
	TYPE(c_ptr), VALUE :: API
	TYPE(c_ptr), VALUE :: header          ! struct GMT_GRID_HEADER *
	INTEGER(kind=c_int), VALUE :: row,col
END FUNCTION
! -------------------------
! double * GMT_Get_Coord(void *API, unsigned int family, unsigned int dim, void *container);
! -------------------------
TYPE(c_ptr) FUNCTION GMT_Get_Coord(API,family,dim,container) BIND(C,NAME='GMT_Get_Coord')
	IMPORT c_int, c_ptr
	TYPE(c_ptr), VALUE :: API,container
	INTEGER(kind=c_int), VALUE :: family,dim
END FUNCTION
! ----------------------------------------------------------------------
! 6 functions to show and inquire about GMT common options, GMT default settings, convert strings to doubles, and message and report printing
! ----------------------------------------------------------------------
! int GMT_Option(void *API, char *options);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Option(API,options) BIND(C,NAME='GMT_Option')
	IMPORT c_int, c_ptr, c_char
	TYPE(c_ptr),VALUE :: API
	CHARACTER(len=1,kind=c_char) :: options(*)
END FUNCTION
! -------------------------
! int GMT_Get_Common(void *API, unsigned int option, double *par);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Get_Common(API,option,par) BIND(C,NAME='GMT_Get_Common')
	IMPORT c_int, c_ptr
	TYPE(c_ptr), VALUE :: API
	INTEGER(kind=c_int), VALUE :: option
	TYPE(c_ptr), VALUE :: par             ! double *
END FUNCTION
! -------------------------
! int GMT_Get_Default(void *API, char *keyword, char *value);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Get_Default(API,keyword,value) BIND(C,NAME='GMT_Get_Default')
	IMPORT c_int, c_ptr, c_char
	TYPE(c_ptr), VALUE :: API
	CHARACTER(len=1, kind=c_char) :: keyword(*), value(*)
END FUNCTION
! -------------------------
! int GMT_Get_Value(void *API, char *arg, double *par);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Get_Value(API,arg,par) BIND(C,NAME='GMT_Get_Value')
	IMPORT c_int, c_ptr, c_char
	TYPE(c_ptr), VALUE :: API
	CHARACTER(len=1, kind=c_char) :: arg(*)
	TYPE(c_ptr), VALUE :: par             ! double *
END FUNCTION
! -------------------------
! int GMT_Report(void *API, unsigned int level, char *message, ...);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Report(API,level,message) BIND(C,NAME='GMT_Report')
	IMPORT c_int, c_ptr, c_char
	TYPE(c_ptr), VALUE :: API
	INTEGER(kind=c_int), VALUE :: level
	CHARACTER(len=1, kind=c_char) :: message(*)
END FUNCTION
! -------------------------
! int GMT_Message(void *API, unsigned int mode, char *format, ...);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Message(API,mode,format) BIND(C,NAME='GMT_Message')
	IMPORT c_int, c_ptr, c_char
	TYPE(c_ptr), VALUE :: API
	INTEGER(kind=c_int), VALUE :: mode
	CHARACTER(len=1, kind=c_char) :: format(*)
END FUNCTION
! ----------------------------------------------------------------------
! 1 function to list or call the core, optional supplemental, and custom GMT modules
! ----------------------------------------------------------------------
! int GMT_Call_Module(void *API, const char *module, int mode, void *args);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_Call_Module(API,module,mode,args) BIND(C,NAME='GMT_Call_Module')
	IMPORT c_int, c_ptr, c_char
	TYPE(c_ptr), VALUE :: API
	CHARACTER(len=1, kind=c_char) :: module(*)
	INTEGER(kind=c_int), VALUE :: mode
	CHARACTER(len=1, kind=c_char) :: args(*)       ! if actual argument is string
! TYPE(c_ptr),VALUE :: args          ! if actual argument is C pointer
END FUNCTION
! ----------------------------------------------------------------------
! TODO: 12 secondary functions for argument and option parsing
! ----------------------------------------------------------------------
! struct GMT_OPTION * GMT_Create_Options(void *API, int argc, void *in);
! struct GMT_OPTION * GMT_Make_Option(void *API, char option, char *arg);
! struct GMT_OPTION * GMT_Find_Option(void *API, char option, struct GMT_OPTION *head);
! struct GMT_OPTION * GMT_Append_Option(void *API, struct GMT_OPTION *current, struct GMT_OPTION *head);
! char ** GMT_Create_Args(void *API, int *argc, struct GMT_OPTION *head);
! char * GMT_Create_Cmd(void *API, struct GMT_OPTION *head);
! int GMT_Destroy_Options(void *API, struct GMT_OPTION **head);
! int GMT_Destroy_Args(void *API, int argc, char **argv[]);
! int GMT_Destroy_Cmd(void *API, char **cmd);
! int GMT_Update_Option(void *API, struct GMT_OPTION *current, char *arg);
! int GMT_Delete_Option(void *API, struct GMT_OPTION *current);
! int GMT_Parse_Common(void *API, char *given_options, struct GMT_OPTION *options);
! ----------------------------------------------------------------------
! TODO: 8 GMT_FFT_* functions
! ----------------------------------------------------------------------
! unsigned int GMT_FFT_Option(void *API, char option, unsigned int dim, char *string);
! void * GMT_FFT_Parse(void *API, char option, unsigned int dim, char *args);
! void * GMT_FFT_Create(void *API, void *X, unsigned int dim, unsigned int mode, void *F);
! double GMT_FFT_Wavenumber(void *API, uint64_t k, unsigned int mode, void *K);
! int GMT_FFT(void *API, void *X, int direction, unsigned int mode, void *K);
! int GMT_FFT_Destroy(void *API, void *K);
! int GMT_FFT_1D(void *API, float *data, uint64_t n, int direction, unsigned int mode);
! int GMT_FFT_2D(void *API, float *data, unsigned int nx, unsigned int ny, int direction, unsigned int mode);
! ----------------------------------------------------------------------
END INTERFACE
! ----------------------------------------------------------------------

! ----------------------------------------------------------------------
! gmt.h: FORTRAN INTERFACES
! ----------------------------------------------------------------------
INTERFACE
! -------------------------
! int GMT_F77_readgrdinfo_(unsigned int dim[], double wesn[], double inc[], char *title, char *remark, char *file);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_F77_readgrdinfo(dim,wesn,inc,title,remark,file) BIND(C,NAME='GMT_F77_readgrdinfo_')
	IMPORT c_int, c_float, c_double, c_char
	INTEGER(kind=c_int) :: dim(*)
	REAL(kind=c_double) :: wesn(*), inc(*)
	CHARACTER(len=1,kind=c_char) :: title(*), remark(*), file(*)
END FUNCTION
! -------------------------
! int GMT_F77_readgrd_(float *array, unsigned int dim[], double wesn[], double inc[], char *title, char *remark, char *file);
! -------------------------
INTEGER(kind=c_int) FUNCTION GMT_F77_readgrd(array,dim,wesn,inc,title,remark,file) BIND(C,NAME='GMT_F77_readgrd_')
	IMPORT c_int, c_float, c_double, c_char
	REAL(kind=c_float) :: array(*)
	INTEGER(kind=c_int) :: dim(*)
	REAL(kind=c_double) :: wesn(*), inc(*)
	CHARACTER(len=1, kind=c_char) :: title(*), remark(*), file(*)
END FUNCTION
! -------------------------
! int GMT_F77_writegrd_(float *array, unsigned int dim[], double wesn[], double inc[], char *title, char *remark, char *file);
! ----------------------------------------------------------------------
INTEGER(kind=c_int) FUNCTION GMT_F77_writegrd(array,dim,wesn,inc,title,remark,file) BIND(C,NAME='GMT_F77_writegrd_')
	IMPORT c_int, c_float, c_double, c_char
	REAL(kind=c_float) :: array(*)
	INTEGER(kind=c_int) :: dim(*)
	REAL(kind=c_double) :: wesn(*), inc(*)
	CHARACTER(len=1, kind=c_char) :: title(*), remark(*), file(*)
END FUNCTION
! ----------------------------------------------------------------------
END INTERFACE
! ----------------------------------------------------------------------

! ----------------------------------------------------------------------
END MODULE mGMT
! ----------------------------------------------------------------------
