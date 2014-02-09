/* $Id: z5.c 2 2014-01-28 10:25:41Z remko $
 * ----------------------------------------------------------------------
 * Test of GMT API
 * with module gmtmath
 * and GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
 * GMT_Create_Data, GMT_Get_ID and GMT_Encode_ID
 * ----------------------------------------------------------------------
 * To compile:
 * ----------------------------------------------------------------------
 * Linux
 *   gcc z5.c -I/opt/gmt/include/gmt -lgmt
 *   icc z5.c -I/opt/gmt/include/gmt -lgmt
 *   pgcc z5.c -I/opt/gmt/include/gmt -L/opt/gmt/lib -lgmt
 * ----------------------------------------------------------------------
 * Windows
 *   gcc z5.c -Ic:\programs\gmt5\include\gmt -Lc:\programs\gmt5\lib -lgmt
 *   pgcc z5.c -Ic:\programs\gmt5\include\gmt -Lc:\programs\gmt5\lib -lgmt
 * ----------------------------------------------------------------------
 * GMT 5.1.0: test not successful
 * args = -T @GMTAPI@-000000 LSQFIT =
 * gmtmath: Syntax error: Expression must contain at least one table file or -T [and -N]
 * Call_Module: gmtmath 1
 * ----------------------------------------------------------------------
 */

#include <gmt.h>

int main() {
	/* user data declarations */
	const int imax=4,jmax=5;
	double A[imax][jmax],b[imax];
	int i,j;

	/* GMT related declarations */
	void *API=NULL;
	struct GMT_MATRIX *M=NULL;
	double *wesn,*inc;
	uint64_t dim[3]; /* alias par */
	char filename[16],args[100];
	int idIn,ierr;

	/* user data */
	for (i=1; i<=imax; i++) {
		b[i-1]=1.;
		for (j=1; j<=jmax-1; j++) {A[i-1][j-1]=0.;}
		A[i-1][i-1]=i;
		A[i-1][jmax-1]=b[i-1];
	}

	/* create GMT session */
	API=GMT_Create_Session("Test",2,0,0);
	printf("Create_Session: %c\n",API!=NULL?'T':'F');

	/* create GMT data */
	dim[GMT_X]=(uint64_t) jmax; /* columns */
	dim[GMT_Y]=(uint64_t) imax; /* rows */
	dim[GMT_Z]=(uint64_t) 1;

	wesn=NULL;
	inc=NULL;
	M=GMT_Create_Data(API,GMT_IS_MATRIX,GMT_IS_POINT,0,dim,wesn,inc,0,0,NULL);
	printf("Create_Data: %c\n",M!=NULL?'T':'F');

	/* associate GMT_MATRIX components with user data */
	M->shape=GMT_ALLOC_NORMAL;         /* ALLOC_NORMAL,ALLOC_VERTICAL,ALLOC_HORIZONTAL */
	M->registration=GMT_GRID_NODE_REG; /* GRID_NODE_REG,GRID_PIXEL_REG */
	M->dim=jmax;
	M->size=sizeof(A);
	M->type=GMT_DOUBLE;
	/*M->range[0]=...; */
	M->data.f8=(double *) A;
	printf("Create_Data cols&rows: %d %d\n",(int) M->n_rows,(int) M->n_columns);

	/* get id for GMT_MATRIX */
	idIn=GMT_Get_ID(API,GMT_IS_DATASET,GMT_IN,M);
	printf("Get_ID: %d\n",idIn);

	/* get a filename for GMT_MATRIX */
	ierr=GMT_Encode_ID(API,filename,idIn);
	printf("Encode_ID: %s\n",filename);

	/* call modules */
	/* sprintf(args,"%s %s %s","-T","Ab.dat","LSQFIT ="); */
	 sprintf(args,"%s %s %s","-T",filename,"LSQFIT =");
	 printf("args = %s\n",args);
	 ierr=GMT_Call_Module(API,"gmtmath",GMT_MODULE_CMD,args);
	 printf("Call_Module: %s %d\n","gmtmath",ierr);

	/* clean up */
	/* ierr=GMT_Destroy_Session(API); */
	/* printf("Destroy_Session: %d\n",ierr); */
}
