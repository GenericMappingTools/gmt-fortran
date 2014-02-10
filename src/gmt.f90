! $Id$
! ----------------------------------------------------------------------
! GMT FORTRAN 
! alias 
! GMT5 API from Fortran 2003 codes
! ----------------------------------------------------------------------
! Get by: svn checkout svn://gmtserver.soest.hawaii.edu/gmt-fortran gmt-fortran
! Use by: 'use gmt' statement
! Compile by: Fortran compiler with iso_c_binding support (e.g., GNU, Intel, PGI, g95)
! See examples of matching shell scripts, C codes and Fortran codes
! ----------------------------------------------------------------------
! Enumerations, derived types and interfaces compatible with header files of GMT-5.1.0
! Id: gmt.h 12022 2013-08-04 10:29:09Z fwobbe
! Id: gmt_define.h 11801 2013-06-24 21:19:31Z pwessel
! Id: gmt_option.h 12380 2013-10-23 19:20:13Z pwessel
! Id: gmt_resources.h 12307 2013-10-09 20:23:10Z jluis
! ----------------------------------------------------------------------
module gmt
! ----------------------------------------------------------------------
use iso_c_binding
! ----------------------------------------------------------------------
! gmt_define.h enumerations
! ----------------------------------------------------------------------
enum,bind(c) ! GMT_enum_type
enumerator :: GMT_CHAR=0,GMT_UCHAR,GMT_SHORT,GMT_USHORT,GMT_INT,GMT_UINT,GMT_LONG,GMT_ULONG, &
GMT_FLOAT,GMT_DOUBLE,GMT_TEXT,GMT_DATETIME,GMT_N_TYPES
end enum
! ----------------------------------------------------------------------
! gmt_option.h enumerations
! ----------------------------------------------------------------------
enum,bind(c) ! GMT_enum_opt
enumerator :: GMT_OPT_USAGE=ichar('?'),GMT_OPT_SYNOPSIS=ichar('^'),GMT_OPT_PARAMETER=ichar('-'), &
GMT_OPT_INFILE=ichar('<'),GMT_OPT_OUTFILE=ichar('>')
end enum
! ----------------------------------------------------------------------
! gmt_resources.h enumerations
! ----------------------------------------------------------------------
enum,bind(c) ! GMT_enum_method
enumerator :: GMT_IS_FILE=0,GMT_IS_STREAM,GMT_IS_FDESC,GMT_IS_DUPLICATE,GMT_IS_REFERENCE
end enum
enum,bind(c) ! GMT_enum_via
enumerator :: GMT_VIA_NONE=0,GMT_VIA_VECTOR=100,GMT_VIA_MATRIX=200,GMT_VIA_OUTPUT=2048
end enum
enum,bind(c) ! GMT_enum_family
enumerator :: GMT_IS_DATASET=0,GMT_IS_TEXTSET,GMT_IS_GRID,GMT_IS_CPT,GMT_IS_IMAGE, &
GMT_IS_VECTOR,GMT_IS_MATRIX,GMT_IS_COORD
end enum
enum,bind(c) ! GMT_enum_comment
enumerator :: GMT_COMMENT_IS_TEXT=0,GMT_COMMENT_IS_OPTION=1,GMT_COMMENT_IS_COMMAND=2, &
GMT_COMMENT_IS_REMARK=4,GMT_COMMENT_IS_TITLE=8,GMT_COMMENT_IS_NAME_X=16, &
GMT_COMMENT_IS_NAME_Y=32,GMT_COMMENT_IS_NAME_Z=64,GMT_COMMENT_IS_COLNAMES=128,GMT_COMMENT_IS_RESET=256
end enum
enum,bind(c) ! GMT_api_err_enum
enumerator :: GMT_NOTSET=-1,GMT_NOERROR=0
end enum
enum,bind(c) ! GMT_module_enum
enumerator :: GMT_MODULE_EXIST=-3,GMT_MODULE_PURPOSE=-2,GMT_MODULE_OPT=-1,GMT_MODULE_CMD=0
end enum
enum,bind(c) ! GMT_io_enum
enumerator :: GMT_IN=0,GMT_OUT,GMT_ERR
end enum
enum,bind(c) ! GMT_enum_dimensions
enumerator :: GMT_X=0,GMT_Y,GMT_Z
end enum
enum,bind(c) ! GMT_enum_freg
enumerator :: GMT_ADD_FILES_IF_NONE=1,GMT_ADD_FILES_ALWAYS=2,GMT_ADD_STDIO_IF_NONE=4,GMT_ADD_STDIO_ALWAYS=8, &
GMT_ADD_EXISTING=16,GMT_ADD_DEFAULT=6
end enum
enum,bind(c) ! GMT_enum_ioset
enumerator :: GMT_IO_DONE=0,GMT_IO_ASCII=512,GMT_IO_RESET=32768,GMT_IO_UNREG=16384
end enum
enum,bind(c) ! GMT_enum_read
enumerator :: GMT_READ_DOUBLE=0,GMT_READ_NORMAL=0,GMT_READ_TEXT=1,GMT_READ_MIXED=2,GMT_FILE_BREAK=4
end enum
enum,bind(c) ! GMT_enum_write
enumerator :: GMT_WRITE_DOUBLE=0,GMT_WRITE_TEXT,GMT_WRITE_SEGMENT_HEADER,GMT_WRITE_TABLE_HEADER,GMT_WRITE_TABLE_START, &
GMT_WRITE_NOLF=16
end enum
enum,bind(c) ! GMT_enum_header
enumerator :: GMT_HEADER_OFF=0,GMT_HEADER_ON
end enum
enum,bind(c) ! GMT_enum_dest
enumerator :: GMT_WRITE_OGR=-1,GMT_WRITE_SET,GMT_WRITE_TABLE,GMT_WRITE_SEGMENT,GMT_WRITE_TABLE_SEGMENT
end enum
enum,bind(c) ! GMT_enum_alloc
enumerator :: GMT_ALLOCATED_EXTERNALLY=0,GMT_ALLOCATED_BY_GMT=1
end enum
enum,bind(c) ! GMT_enum_shape
enumerator :: GMT_ALLOC_NORMAL=0,GMT_ALLOC_VERTICAL,GMT_ALLOC_HORIZONTAL
end enum
enum,bind(c) ! GMT_enum_duplicate ! name clash: int GMT_DUPLICATE_DATA vs. function GMT_Duplicate_Data
enumerator :: GMT_DUPLICATE_NONE=0,GMT_DUPLICATE_ALLOC,GMT_DUPLICATE_DATA_ENUM
end enum
enum,bind(c) ! GMT_enum_out
enumerator :: GMT_WRITE_NORMAL=0,GMT_WRITE_HEADER,GMT_WRITE_SKIP
end enum
enum,bind(c) ! GMT_FFT_mode
enumerator :: GMT_FFT_FWD=0,GMT_FFT_INV=1,GMT_FFT_real=0,GMT_FFT_COMPLEX=1
end enum
enum,bind(c) ! GMT_time_mode
enumerator :: GMT_TIME_NONE=0,GMT_TIME_CLOCK=1,GMT_TIME_ELAPSED=2,GMT_TIME_RESET=4
end enum
enum,bind(c) ! enum GMT_enum_verbose
enumerator :: GMT_MSG_QUIET=0,GMT_MSG_NORMAL,GMT_MSG_COMPAT,GMT_MSG_VERBOSE,GMT_MSG_LONG_VERBOSE,GMT_MSG_DEBUG
end enum
enum,bind(c) ! GMT_enum_reg
enumerator :: GMT_GRID_NODE_REG=0,GMT_GRID_PIXEL_REG=1,GMT_GRID_DEFAULT_REG=1024
end enum
enum,bind(c) ! GMT_enum_gridindex
enumerator :: GMT_XLO=0,GMT_XHI,GMT_YLO,GMT_YHI,GMT_ZLO,GMT_ZHI
end enum
enum,bind(c) ! GMT_enum_dimindex
enumerator :: GMT_TBL=0,GMT_SEG,GMT_ROW,GMT_COL
end enum
enum,bind(c) ! GMT_enum_gridio
enumerator :: GMT_GRID_IS_real=0,GMT_GRID_ALL=0,GMT_GRID_HEADER_ONLY=1,GMT_GRID_DATA_ONLY=2, &
GMT_GRID_IS_COMPLEX_real=4,GMT_GRID_IS_COMPLEX_IMAG=8,GMT_GRID_IS_COMPLEX_MASK=12, &
GMT_GRID_NO_HEADER=16,GMT_GRID_ROW_BY_ROW=32,GMT_GRID_ROW_BY_ROW_MANUAL=64
end enum
enum,bind(c) ! GMT_enum_grdlen
enumerator :: GMT_GRID_UNIT_LEN80=80,GMT_GRID_TITLE_LEN80=80,GMT_GRID_VARNAME_LEN80=80, &
GMT_GRID_COMMAND_LEN320=320,GMT_GRID_REMARK_LEN160=160,GMT_GRID_NAME_LEN256=256,GMT_GRID_HEADER_SIZE=892
end enum
enum,bind(c) ! GMT_enum_geometry
enumerator :: GMT_IS_POINT=1,GMT_IS_LINE=2,GMT_IS_POLY=4,GMT_IS_PLP=7,GMT_IS_SURFACE=8,GMT_IS_NONE=16
end enum
enum,bind(c) ! GMT_enum_pol
enumerator :: GMT_IS_PERIMETER=0,GMT_IS_HOLE=1
end enum
enum,bind(c) ! GMT_enum_ascii_input_return
enumerator :: GMT_IO_DATA_RECORD=0,GMT_IO_TABLE_HEADER=1,GMT_IO_SEGMENT_HEADER=2,GMT_IO_ANY_HEADER=3,GMT_IO_MISMATCH=4, &
GMT_IO_EOF=8,GMT_IO_NAN=16,GMT_IO_NEW_SEGMENT=18,GMT_IO_GAP=32,GMT_IO_LINE_BREAK=58,GMT_IO_NEXT_FILE=64
end enum
enum,bind(c) ! GMT_enum_color
enumerator :: GMT_CMYK=1,GMT_HSV=2,GMT_COLORINT=4,GMT_NO_COLORNAMES=8
end enum
enum,bind(c) ! GMT_enum_bfn
enumerator :: GMT_BGD,GMT_FGD,GMT_NAN
end enum
enum,bind(c) ! GMT_enum_cpt
enumerator :: GMT_CPT_REQUIRED,GMT_CPT_OPTIONAL
end enum
enum,bind(c) ! GMT_enum_cptflags
enumerator :: GMT_CPT_NO_BNF=1,GMT_CPT_EXTEND_BNF=2
end enum
enum,bind(c) ! GMT_enum_fmt
enumerator :: GMT_IS_ROW_FORMAT=0,GMT_IS_COL_FORMAT=1
end enum
! ----------------------------------------------------------------------
! gmt_option.h derived types
! ----------------------------------------------------------------------
! struct GMT_OPTION { /* Structure for a single GMT command option */
! char option; /* 1-char command line -<option> (e.g. D in -D) identifying the option (* if file) */
! char *arg; /* If not NULL, contains the argument for this option */
! struct GMT_OPTION *next; /* Pointer to next option in a linked list */
! struct GMT_OPTION *previous; /* Pointer to previous option in a linked list */
! };
! ----------------------------------
type,bind(c) :: GMT_OPTION_STRUCT ! name clash: struct GMT_OPTION vs. function GMT_Option
character(1,c_char) option
type(c_ptr) arg
type(c_ptr) next,previous
end type
! ----------------------------------------------------------------------
! gmt_resources.h derived types
! ----------------------------------------------------------------------
! TODO: struct GMT_GRID_HEADER
! TODO: struct GMT_GRID
! TODO: struct GMT_OGR
! TODO: struct GMT_OGR_SEG
! ----------------------------------
! struct GMT_DATASEGMENT { /* For holding segment lines in memory */
! /* Variables we document for the API: */
! uint64_t n_rows; /* Number of points in this segment */
! uint64_t n_columns; /* Number of fields in each record (>= 2) */
! double *min; /* Minimum coordinate for each column */
! double *max; /* Maximum coordinate for each column */
! double **coord; /* Coordinates x,y, and possibly other columns */
! char *label; /* Label string (if applicable) */
! char *header; /* Segment header (if applicable) */
! /* ---- Variables "hidden" from the API ---- */
! enum GMT_enum_out mode; /* 0 = output segment, 1 = output header only, 2 = skip segment */
! enum GMT_enum_pol pol_mode; /* Either GMT_IS_PERIMETER  [-Pp] or GMT_IS_HOLE [-Ph] (for polygons only) */
! uint64_t id; /* The internal number of the segment */
! size_t n_alloc; /* The current allocation length of each coord */
! int range; /* 0 = use default lon adjustment, -1 = negative longs, +1 = positive lons */
! int pole; /* Spherical polygons only: If it encloses the S (-1) or N (+1) pole, or none (0) */
! double dist; /* Distance from a point to this feature */
! double lat_limit; /* For polar caps: the latitude of the point closest to the pole */
! struct GMT_OGR_SEG *ogr; /* NULL unless OGR/GMT metadata exist for this segment */
! struct GMT_DATASEGMENT *next; /* NULL unless polygon and has holes and pointing to next hole */
! char *file[2]; /* Name of file or source [0 = in, 1 = out] */
! };
! ----------------------------------
type,bind(c) :: GMT_DATASEGMENT
integer(c_int64_t) n_rows,n_columns
type(c_ptr) min,max,coord
type(c_ptr) label,header
integer(c_int) mode,pol_mode
integer(c_int64_t) id
integer(c_size_t) n_alloc
integer(c_int) range,pole
real(c_double) dist,lat_limit
type(c_ptr) ogr,next
type(c_ptr) file
end type
! ----------------------------------
! struct GMT_DATATABLE { /* To hold an array of line segment structures and header information in one container */
! /* Variables we document for the API: */
! unsigned int n_headers; /* Number of file header records (0 if no header) */
! uint64_t n_columns; /* Number of columns (fields) in each record */
! uint64_t n_segments; /* Number of segments in the array */
! uint64_t n_records; /* Total number of data records across all segments */
! double *min; /* Minimum coordinate for each column */
! double *max; /* Maximum coordinate for each column */
! char **header; /* Array with all file header records, if any) */
! struct GMT_DATASEGMENT **segment; /* Pointer to array of segments */
! /* ---- Variables "hidden" from the API ---- */
! uint64_t id; /* The internal number of the table */
! size_t n_alloc; /* The current allocation length of segments */
! enum GMT_enum_out mode; /* 0 = output table, 1 = output header only, 2 = skip table */
! struct GMT_OGR *ogr; /* Pointer to struct with all things GMT/OGR (if MULTI-geometry and not MULTIPOINT) */
! char *file[2]; /* Name of file or source [0 = in, 1 = out] */
! };
! ----------------------------------
type,bind(c) :: GMT_DATATABLE
integer(c_int) n_headers
integer(c_int64_t) n_columns,n_segments,n_records
type(c_ptr) min,max,header,segment
integer(c_int64_t) id
integer(c_size_t) n_alloc
integer(c_int) mode
type(c_ptr) ogr
type(c_ptr) file
end type
! ----------------------------------
! struct GMT_DATASET { /* Single container for an array of GMT tables (files) */
! /* Variables we document for the API: */
! uint64_t n_tables; /* The total number of tables (files) contained */
! uint64_t n_columns; /* The number of data columns */
! uint64_t n_segments; /* The total number of segments across all tables */
! uint64_t n_records; /* The total number of data records across all tables */
! double *min; /* Minimum coordinate for each column */
! double *max; /* Maximum coordinate for each column */
! struct GMT_DATATABLE **table; /* Pointer to array of tables */
! /* ---- Variables "hidden" from the API ---- */
! uint64_t id; /* The internal number of the data set */
! size_t n_alloc; /* The current allocation length of tables */
! unsigned int geometry; /* The geometry of this dataset */
! unsigned int alloc_level; /* The level it was allocated at */
! enum GMT_enum_dest io_mode; /* -1 means write OGR format (requires proper -a),
! * 0 means write everything to one destination [Default],
! * 1 means use table->file[GMT_OUT] to write separate table,
! * 2 means use segment->file[GMT_OUT] to write separate segments.
! * 3 is same as 2 but with no filenames we create filenames from tbl and seg numbers */
! enum GMT_enum_alloc alloc_mode; /* Allocation mode [GMT_ALLOCATED_BY_GMT] */
! char *file[2]; /* Name of file or source [0 = in, 1 = out] */
! };
! ----------------------------------
type,bind(c) :: GMT_DATASET
integer(c_int64_t) n_tables,n_columns,n_segments,n_records
type(c_ptr) min,max,table
integer(c_int64_t) id
integer(c_size_t) n_alloc
integer(c_int) geometry,alloc_level,io_mode,alloc_mode
type(c_ptr) file
end type
! ----------------------------------
! TODO: struct GMT_TEXTSEGMENT
! TODO: struct GMT_TEXTTABLE
! TODO: struct GMT_TEXTSET
! TODO: struct GMT_LUT
! TODO: struct GMT_BFN_COLOR
! TODO: struct GMT_PALETTE
! TODO: struct GMT_IMAGE
! ----------------------------------
! not needed: union GMT_UNIVECTOR
! ----------------------------------
! struct GMT_VECTOR { /* Single container for user vector(s) of data */
! /* Variables we document for the API: */
! uint64_t n_columns; /* Number of vectors */
! uint64_t n_rows; /* Number of rows in each vector */
! enum GMT_enum_reg registration; /* 0 for gridline and 1 for pixel registration */
! enum GMT_enum_type *type; /* Array of data types (type of each uni-vector, e.g. GMT_FLOAT */
! union GMT_UNIVECTOR *data; /* Array of uni-vectors */
! double range[2]; /* Contains tmin/tmax (or 0/0 if not equidistant) */
! char command[GMT_GRID_COMMAND_LEN320]; /* name of generating command */
! char remark[GMT_GRID_REMARK_LEN160]; /* comments re this data set */
! /* ---- Variables "hidden" from the API ---- */
! uint64_t id; /* The internal number of the data set */
! unsigned int alloc_level; /* The level it was allocated at */
! enum GMT_enum_alloc alloc_mode; /* Allocation mode [GMT_ALLOCATED_BY_GMT] */
! };
! ----------------------------------
type,bind(c) :: GMT_VECTOR
integer(c_int64_t) n_columns,n_rows
integer(c_int) registration
type(c_ptr) type,data
real(c_double) range(0:1)
character(GMT_GRID_COMMAND_LEN320,c_char) command
character(GMT_GRID_REMARK_LEN160,c_char) remark
! private attribute not implemented in g95
integer(c_int64_t) id 
integer(c_int) alloc_level,alloc_mode 
! integer(c_int64_t),private :: id
! integer(c_int),private :: alloc_level,alloc_mode
end type
! ----------------------------------
! struct GMT_MATRIX { /* Single container for a user matrix of data */
! /* Variables we document for the API: */
! uint64_t n_rows; /* Number of rows in this matrix */
! uint64_t n_columns; /* Number of columns in this matrix */
! uint64_t n_layers; /* Number of layers in a 3-D matrix [1] */
! enum GMT_enum_fmt shape; /* 0 = C (rows) and 1 = Fortran (cols) */
! enum GMT_enum_reg registration; /* 0 for gridline and 1 for pixel registration */
! size_t dim; /* Allocated length of longest C or Fortran dim */
! size_t size; /* Byte length of data */
! enum GMT_enum_type type; /* Data type, e.g. GMT_FLOAT */
! double range[6]; /* Contains xmin/xmax/ymin/ymax[/zmin/zmax] */
! union GMT_UNIVECTOR data; /* Union with pointer to actual matrix of the chosen type */
! char command[GMT_GRID_COMMAND_LEN320]; /* name of generating command */
! char remark[GMT_GRID_REMARK_LEN160]; /* comments re this data set */
! /* ---- Variables "hidden" from the API ---- */
! uint64_t id; /* The internal number of the data set */
! unsigned int alloc_level; /* The level it was allocated at */
! enum GMT_enum_alloc alloc_mode; /* Allocation mode [GMT_ALLOCATED_BY_GMT] */
! };
! ----------------------------------
type,bind(c) :: GMT_MATRIX
integer(c_int64_t) n_rows,n_columns,n_layers
integer(c_int) shape,registration
integer(c_size_t) dim,size
integer(c_int) type
real(c_double) range(0:5)
type(c_ptr) data
character(GMT_GRID_COMMAND_LEN320,c_char) command
character(GMT_GRID_REMARK_LEN160,c_char) remark
! private attribute not implemented in g95
integer(c_int64_t) id
integer(c_int) alloc_level,alloc_mode
end type
! ----------------------------------------------------------------------
! gmt.h C interfaces
! ----------------------------------------------------------------------
interface
! ----------------------------------------------------------------------
! 22 primary API functions 
! ----------------------------------------------------------------------
! void * GMT_Create_Session(char *tag, unsigned int pad, unsigned int mode, int (*print_func) (FILE *, const char *));
! ----------------------------------
type(c_ptr) function GMT_Create_Session(tag,pad,mode,print_func) bind(c,name='GMT_Create_Session')
import c_ptr,c_char,c_int,c_funptr
character(1,c_char) :: tag(*)
integer(c_int),value :: pad,mode
integer(c_int),value :: print_func ! if actual argument is integer
! type(c_funptr),value :: print_func ! if actual argument is C function pointer 
end function
! ----------------------------------
! void * GMT_Create_Data(void *API, unsigned int family, unsigned int geometry, unsigned int mode, uint64_t dim[], 
! double *wesn, double *inc, unsigned int registration, int pad, void *data);
! ----------------------------------
type(c_ptr) function GMT_Create_Data(API,family,geometry,mode,dim,wesn,inc,registration,pad,data) bind(c,name='GMT_Create_Data')
import c_ptr,c_int,c_int64_t,c_double
type(c_ptr),value :: API,data
integer(c_int),value :: family,geometry,mode,registration,pad
integer(c_int64_t) :: dim(*)
type(c_ptr),value :: wesn,inc ! if actual argument is C pointer
! real(c_double) :: wesn(*),inc(*) ! if actual argument is real(8) array
end function
! ----------------------------------
! void * GMT_Get_Data(void *API, int object_ID, unsigned int mode, void *data);
! ----------------------------------
type(c_ptr) function GMT_Get_Data(API,object_ID,mode,data) bind(c,name='GMT_Get_Data')
import c_ptr,c_int
type(c_ptr),value :: API,data
integer(c_int),value :: object_ID,mode
end function
! ----------------------------------
! void * GMT_Read_Data(void *API, unsigned int family, unsigned int method, unsigned int geometry, unsigned int mode, 
! double wesn[], char *input, void *data);
! ----------------------------------
type(c_ptr) function GMT_Read_Data(API,family,method,geometry,mode,wesn,input,data) bind(c,name='GMT_Read_Data')
import c_ptr,c_int,c_double,c_char
type(c_ptr),value :: API,data
integer(c_int),value :: family,method,geometry,mode
type(c_ptr),value :: wesn ! if actual argument is C pointer
! real(c_double) :: wesn(*) ! if actual argument is real(8) array
character(1,c_char) :: input(*)
end function
! ----------------------------------
! void * GMT_Retrieve_Data(void *API, int object_ID);
! ----------------------------------
type(c_ptr) function GMT_Retrieve_Data(API,object_ID) bind(c,name='GMT_Retrieve_Data')
import c_int,c_ptr
type(c_ptr),value :: API
integer(c_int),value :: object_ID
end function
! ----------------------------------
! void * GMT_Duplicate_Data(void *API, unsigned int family, unsigned int mode, void *data);
! ----------------------------------
type(c_ptr) function GMT_Duplicate_Data(API,family,mode,data) bind(c,name='GMT_Duplicate_Data')
import c_int,c_ptr
type(c_ptr),value :: API,data
integer(c_int),value :: family,mode
end function
! ----------------------------------
! void * GMT_Get_Record(void *API, unsigned int mode, int *retval);
! ----------------------------------
type(c_ptr) function GMT_Get_Record(API,mode,retval) bind(c,name='GMT_Get_Record')
import c_int,c_ptr
type(c_ptr),value :: API
integer(c_int),value :: mode
integer(c_int) :: retval
end function
! ----------------------------------
! int GMT_Destroy_Session(void *API);
! ----------------------------------
integer(c_int) function GMT_Destroy_Session(API) bind(c,name='GMT_Destroy_Session')
import c_int,c_ptr
type(c_ptr),value :: API
end function
! ----------------------------------
! int GMT_Register_IO(void *API, unsigned int family, unsigned int method, unsigned int geometry, unsigned int direction, 
! double wesn[], void *resource);
! ----------------------------------
integer(c_int) function GMT_Register_IO(API,family,method,geometry,direction,wesn,resource) bind(c,name='GMT_Register_IO')
import c_int,c_ptr,c_double
type(c_ptr),value :: API,resource
integer(c_int),value :: family,method,geometry,direction
type(c_ptr),value :: wesn ! if actual argument is C pointer
! real(c_double) :: wesn(*) ! if actual argument is real(8) array
end function
! ----------------------------------
! int GMT_Init_IO(void *API, unsigned int family, unsigned int geometry, unsigned int direction, unsigned int mode, 
! unsigned int n_args, void *args);
! ----------------------------------
integer(c_int) function GMT_Init_IO(API,family,geometry,direction,mode,n_args,args) bind(c,name='GMT_Init_IO')
import c_int,c_ptr
type(c_ptr),value :: API,args
integer(c_int),value :: family,geometry,direction,mode,n_args
end function
! ----------------------------------
! int GMT_Begin_IO(void *API, unsigned int family, unsigned int direction, unsigned int header);
! ----------------------------------
integer(c_int) function GMT_Begin_IO(API,family,direction,header) bind(c,name='GMT_Begin_IO')
import c_int,c_ptr
type(c_ptr),value :: API
integer(c_int),value :: family,direction,header
end function
! ----------------------------------
! int GMT_Status_IO(void *API, unsigned int mode);
! ----------------------------------
integer(c_int) function GMT_Status_IO(API,mode) bind(c,name='GMT_Status_IO')
import c_int,c_ptr
type(c_ptr),value :: API
integer(c_int),value :: mode
end function
! ----------------------------------
! int GMT_End_IO(void *API, unsigned int direction, unsigned int mode);
! ----------------------------------
integer(c_int) function GMT_End_IO(API,direction,mode) bind(c,name='GMT_End_IO')
import c_int,c_ptr
type(c_ptr),value :: API
integer(c_int),value :: direction,mode
end function
! ----------------------------------
! int GMT_Put_Data(void *API, int object_ID, unsigned int mode, void *data);
! ----------------------------------
integer(c_int) function GMT_Put_Data(API,object_ID,mode,data) bind(c,name='GMT_Put_Data')
import c_int,c_ptr
type(c_ptr),value :: API,data
integer(c_int),value :: object_ID,mode
end function
! ----------------------------------
! int GMT_Write_Data(void *API, unsigned int family, unsigned int method, unsigned int geometry, unsigned int mode, 
! double wesn[], char *output, void *data);
! ----------------------------------
integer(c_int) function GMT_Write_Data(API,family,method,geometry,mode,wesn,output,data) bind(c,name='GMT_Write_Data')
import c_int,c_ptr,c_double,c_char
type(c_ptr),value :: API,data
integer(c_int),value :: family,method,geometry,mode
type(c_ptr),value :: wesn ! if actual argument is C pointer
! real(c_double) :: wesn(*) ! if actual argument is real(8) array
character(1,c_char) :: output
end function
! ----------------------------------
! int GMT_Destroy_Data(void *API, void *object);
! ----------------------------------
integer(c_int) function GMT_Destroy_Data(API,object) bind(c,name='GMT_Destroy_Data')
import c_int,c_ptr
type(c_ptr),value :: API,object
end function
! ----------------------------------
! int GMT_Put_Record(void *API, unsigned int mode, void *record);
! ----------------------------------
integer(c_int) function GMT_Put_Record(API,mode,record) bind(c,name='GMT_Put_Record')
import c_int,c_ptr
type(c_ptr),value :: API,record
integer(c_int),value :: mode
end function
! ----------------------------------
! int GMT_Encode_ID(void *API, char *string, int object_ID);
! ----------------------------------
integer(c_int) function GMT_Encode_ID(API,string,object_ID) bind(c,name='GMT_Encode_ID')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
character(1,c_char) :: string(*)
integer(c_int),value :: object_ID
end function
! ----------------------------------
! int GMT_Get_Row(void *API, int rec_no, struct GMT_GRID *G, float *row);
! ----------------------------------
integer(c_int) function GMT_Get_Row(API,rec_no,G,row) bind(c,name='GMT_Get_Row')
import c_int,c_ptr
type(c_ptr),value :: API
integer(c_int),value :: rec_no
type(c_ptr),value :: G ! struct GMT_GRID *
type(c_ptr),value :: row ! float *
end function
! ----------------------------------
! int GMT_Put_Row(void *API, int rec_no, struct GMT_GRID *G, float *row);
! ----------------------------------
integer(c_int) function GMT_Put_Row(API,rec_no,G,row) bind(c,name='GMT_Put_Row')
import c_int,c_ptr
type(c_ptr),value :: API
integer(c_int),value :: rec_no
type(c_ptr),value :: G ! struct GMT_GRID *
type(c_ptr),value :: row ! float *
end function
! ----------------------------------
! int GMT_Set_Comment(void *API, unsigned int family, unsigned int mode, void *arg, void *data);
! ----------------------------------
integer(c_int) function GMT_Set_Comment(API,family,mode,arg,data) bind(c,name='GMT_Set_Comment')
import c_int,c_ptr
type(c_ptr),value :: API,arg,data
integer(c_int),value :: family,mode
end function
! ----------------------------------
! int GMT_Get_ID(void *API, unsigned int family, unsigned int direction, void *resource);
! ----------------------------------
integer(c_int) function GMT_Get_ID(API,family,direction,resource) bind(c,name='GMT_Get_ID')
import c_int,c_ptr
type(c_ptr),value :: API,resource
integer(c_int),value :: family,direction
end function
! ----------------------------------------------------------------------
! 2 functions to relate (row,col) to a 1-D index and to precompute equidistant coordinates for grids and images 
! ----------------------------------------------------------------------
! int64_t GMT_Get_Index(void *API, struct GMT_GRID_HEADER *header, int row, int col);
! ----------------------------------
integer(c_int64_t) function GMT_Get_Index(API,header,row,col) bind(c,name='GMT_Get_Index')
import c_int64_t,c_int,c_ptr
type(c_ptr),value :: API
type(c_ptr),value :: header ! struct GMT_GRID_HEADER *
integer(c_int),value :: row,col
end function
! ----------------------------------
! double * GMT_Get_Coord(void *API, unsigned int family, unsigned int dim, void *container);
! ----------------------------------
type(c_ptr) function GMT_Get_Coord(API,family,dim,container) bind(c,name='GMT_Get_Coord')
import c_int,c_ptr
type(c_ptr),value :: API,container
integer(c_int),value :: family,dim
end function
! ----------------------------------------------------------------------
! 6 functions to show and inquire about GMT common options, GMT default settings, convert strings to doubles, 
! and message and report printing
! ----------------------------------------------------------------------
! int GMT_Option(void *API, char *options);
! ----------------------------------
integer(c_int) function GMT_Option(API,options) bind(c,name='GMT_Option')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
character(1,c_char) :: options(*)
end function
! ----------------------------------
! int GMT_Get_Common(void *API, unsigned int option, double *par);
! ----------------------------------
integer(c_int) function GMT_Get_Common(API,option,par) bind(c,name='GMT_Get_Common')
import c_int,c_ptr
type(c_ptr),value :: API
integer(c_int),value :: option
type(c_ptr),value :: par ! double *
end function
! ----------------------------------
! int GMT_Get_Default(void *API, char *keyword, char *value);
! -------------------------
integer(c_int) function GMT_Get_Default(API,keyword,value) bind(c,name='GMT_Get_Default')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
character(1,c_char) :: keyword(*),value(*)
end function
! ----------------------------------
! int GMT_Get_Value(void *API, char *arg, double *par);
! ----------------------------------
integer(c_int) function GMT_Get_Value(API,arg,par) bind(c,name='GMT_Get_Value')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
character(1,c_char) :: arg(*)
type(c_ptr),value :: par ! double *
end function
! ----------------------------------
! int GMT_Report(void *API, unsigned int level, char *message, ...);
! ----------------------------------
integer(c_int) function GMT_Report(API,level,message) bind(c,name='GMT_Report')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
integer(c_int),value :: level
character(1,c_char) :: message(*)
end function
! ----------------------------------
! int GMT_Message(void *API, unsigned int mode, char *format, ...);
! ----------------------------------
integer(c_int) function GMT_Message(API,mode,format) bind(c,name='GMT_Message')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
integer(c_int),value :: mode
character(1,c_char) :: format(*)
end function
! ----------------------------------------------------------------------
! 1 function to list or call the core, optional supplemental, and custom GMT modules
! ----------------------------------------------------------------------
! int GMT_Call_Module(void *API, const char *module, int mode, void *args);
! ----------------------------------
integer(c_int) function GMT_Call_Module(API,module,mode,args) bind(c,name='GMT_Call_Module')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
character(1,c_char) :: module(*)
integer(c_int),value :: mode
character(1,c_char) :: args(*) ! if actual argument is string
! type(c_ptr),value :: args ! if actual argument is C pointer
end function
! ----------------------------------------------------------------------
! 12 secondary functions for argument and option parsing
! ----------------------------------------------------------------------
! struct GMT_OPTION * GMT_Create_Options(void *API, int argc, void *in);
! ----------------------------------
type(c_ptr) function GMT_Create_Options(API,argc,in) bind(c,name='GMT_Create_Options')
import c_ptr,c_int
type(c_ptr),value :: API
integer(c_int),value :: argc
type(c_ptr),value :: in
end function
! ----------------------------------
! struct GMT_OPTION * GMT_Make_Option(void *API, char option, char *arg);
! ----------------------------------
type(c_ptr) function GMT_Make_Options(API,option,arg) bind(c,name='GMT_Make_Options')
import c_ptr,c_char
type(c_ptr),value :: API
character(1,c_char),value :: option
character(1,c_char) :: arg(*)
end function
! ----------------------------------
! struct GMT_OPTION * GMT_Find_Option(void *API, char option, struct GMT_OPTION *head);
! ----------------------------------
type(c_ptr) function GMT_Find_Option(API,option,head) bind(c,name='GMT_Find_Option')
import c_ptr,c_char
type(c_ptr),value :: API
character(1,c_char),value :: option
type(c_ptr),value :: head
end function
! ----------------------------------
! struct GMT_OPTION * GMT_Append_Option(void *API, struct GMT_OPTION *current, struct GMT_OPTION *head);
! ----------------------------------
type(c_ptr) function GMT_Append_Option(API,current,head) bind(c,name='GMT_Append_Option')
import c_ptr
type(c_ptr),value :: API,current,head
end function
! ----------------------------------
! char ** GMT_Create_Args(void *API, int *argc, struct GMT_OPTION *head);
! ----------------------------------
type(c_ptr) function GMT_Create_Args(API,argc,head) bind(c,name='GMT_Create_Args')
import c_ptr,c_int
type(c_ptr),value :: API
integer(c_int) :: argc
type(c_ptr),value :: head
end function
! ----------------------------------
! char * GMT_Create_Cmd(void *API, struct GMT_OPTION *head);
! ----------------------------------
type(c_ptr) function GMT_Create_Cmd(API,head) bind(c,name='GMT_Create_Cmd')
import c_ptr,c_int
type(c_ptr),value :: API,head
end function
! ----------------------------------
! int GMT_Destroy_Options(void *API, struct GMT_OPTION **head);
! ----------------------------------
integer(c_int) function GMT_Destroy_Options(API,head) bind(c,name='GMT_Destroy_Options')
import c_int,c_ptr
type(c_ptr),value :: API
type(c_ptr) :: head
end function
! ----------------------------------
! int GMT_Destroy_Args(void *API, int argc, char **argv[]);
! ----------------------------------
integer(c_int) function GMT_Destroy_Args(API,argc,argv) bind(c,name='GMT_Destroy_Args')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
integer(c_int),value :: argc
type(c_ptr) :: argv
end function
! ----------------------------------
! int GMT_Destroy_Cmd(void *API, char **cmd);
! ----------------------------------
integer(c_int) function GMT_Destroy_Cmd(API,cmd) bind(c,name='GMT_Destroy_Cmd')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
type(c_ptr) :: cmd
end function
! ----------------------------------
! int GMT_Update_Option(void *API, struct GMT_OPTION *current, char *arg);
! ----------------------------------
integer(c_int) function GMT_Update_Option(API,current,arg) bind(c,name='GMT_Update_Option')
import c_int,c_ptr,c_char
type(c_ptr),value :: API,current
character(1,c_char) :: arg(*)
end function
! ----------------------------------
! int GMT_Delete_Option(void *API, struct GMT_OPTION *current);
! ----------------------------------
integer(c_int) function GMT_Delete_Option(API,current) bind(c,name='GMT_Delete_Option')
import c_int,c_ptr
type(c_ptr),value :: API,current
end function
! ----------------------------------
! int GMT_Parse_Common(void *API, char *given_options, struct GMT_OPTION *options);
! ----------------------------------------------------------------------
integer(c_int) function GMT_Parse_Common(API,given_options,options) bind(c,name='GMT_Parse_Common')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
character(1,c_char) :: given_options(*)
type(c_ptr),value :: options
end function
! ----------------------------------------------------------------------
! 8 GMT_FFT_* functions
! ----------------------------------------------------------------------
! unsigned int GMT_FFT_Option(void *API, char option, unsigned int dim, char *string);
! ----------------------------------
integer(c_int) function GMT_FFT_Option(API,option,dim,string) bind(c,name='GMT_FFT_Option')
import c_int,c_ptr,c_char
type(c_ptr),value :: API
character(1,c_char),value :: option
integer(c_int),value :: dim
character(1,c_char) :: string(*)
end function
! ----------------------------------
! void * GMT_FFT_Parse(void *API, char option, unsigned int dim, char *args);
! ----------------------------------
type(c_ptr) function GMT_FFT_Parse(API,option,dim,args) bind(c,name='GMT_FFT_Parse')
import c_ptr,c_char,c_int
type(c_ptr),value :: API
character(1,c_char),value :: option
integer(c_int),value :: dim
character(1,c_char) :: args(*)
end function
! ----------------------------------
! void * GMT_FFT_Create(void *API, void *X, unsigned int dim, unsigned int mode, void *F);
! ----------------------------------
type(c_ptr) function GMT_FFT_Create(API,X,dim,mode,F) bind(c,name='GMT_FFT_Create')
import c_ptr,c_int
type(c_ptr),value :: API,X,F
integer(c_int),value :: dim,mode
end function
! ----------------------------------
! double GMT_FFT_Wavenumber(void *API, uint64_t k, unsigned int mode, void *K);
! ----------------------------------
real(c_double) function GMT_FFT_Wavenumber(API,kk,mode,K) bind(c,name='GMT_FFT_Wavenumber')
import c_double,c_ptr,c_int64_t,c_int
type(c_ptr),value :: API,K
integer(c_int64_t),value :: kk ! name clash: k vs. K
integer(c_int),value :: mode
end function
! ----------------------------------
! int GMT_FFT(void *API, void *X, int direction, unsigned int mode, void *K);
! ----------------------------------
integer(c_int) function GMT_FFT(API,X,direction,mode,K) bind(c,name='GMT_FFT')
import c_int,c_ptr
type(c_ptr),value :: API,X,K
integer(c_int),value :: direction,mode
end function
! ----------------------------------
! int GMT_FFT_Destroy(void *API, void *K);
! ----------------------------------
integer(c_int) function GMT_FFT_Destroy(API,K) bind(c,name='GMT_FFT_Destroy')
import c_int,c_ptr
type(c_ptr),value :: API,K
end function
! ----------------------------------
! int GMT_FFT_1D(void *API, float *data, uint64_t n, int direction, unsigned int mode);
! ----------------------------------
integer(c_int) function GMT_FFT_1D(API,data,n,direction,mode) bind(c,name='GMT_FFT_1D')
import c_int,c_ptr,c_float
type(c_ptr),value :: API
real(c_float) :: data(*)
integer(c_int),value :: n,direction,mode
end function
! ----------------------------------
! int GMT_FFT_2D(void *API, float *data, unsigned int nx, unsigned int ny, int direction, unsigned int mode);
! ----------------------------------
integer(c_int) function GMT_FFT_2D(API,data,nx,ny,direction,mode) bind(c,name='GMT_FFT_2D')
import c_int,c_ptr,c_float
type(c_ptr),value :: API
real(c_float) :: data(*)
integer(c_int),value :: nx,ny,direction,mode
end function
! ----------------------------------
end interface
! ----------------------------------------------------------------------
! gmt.h Fortran 77 interfaces
! ----------------------------------------------------------------------
interface
! ----------------------------------
! int GMT_F77_readgrdinfo_(unsigned int dim[], double wesn[], double inc[], char *title, char *remark, char *file);
! ----------------------------------
integer(c_int) function GMT_F77_readgrdinfo(dim,wesn,inc,title,remark,file) bind(c,name='GMT_F77_readgrdinfo_')
import c_int,c_float,c_double,c_char
integer(c_int) :: dim(*)
real(c_double) :: wesn(*),inc(*)
character(1,c_char) :: title(*),remark(*),file(*)
end function
! ----------------------------------
! int GMT_F77_readgrd_(float *array, unsigned int dim[], double wesn[], double inc[], char *title, char *remark, char *file);
! ----------------------------------
integer(c_int) function GMT_F77_readgrd(array,dim,wesn,inc,title,remark,file) bind(c,name='GMT_F77_readgrd_')
import c_int,c_float,c_double,c_char
real(c_float) :: array(*)
integer(c_int) :: dim(*)
real(c_double) :: wesn(*),inc(*)
character(1,c_char) :: title(*),remark(*),file(*)
end function
! ----------------------------------
! int GMT_F77_writegrd_(float *array, unsigned int dim[], double wesn[], double inc[], char *title, char *remark, char *file);
! ----------------------------------
integer(c_int) function GMT_F77_writegrd(array,dim,wesn,inc,title,remark,file) bind(c,name='GMT_F77_writegrd_')
import c_int,c_float,c_double,c_char
real(c_float) :: array(*)
integer(c_int) :: dim(*)
real(c_double) :: wesn(*),inc(*)
character(1,c_char) :: title(*),remark(*),file(*)
end function
! ----------------------------------
end interface
! ----------------------------------------------------------------------
end module
! ----------------------------------------------------------------------
