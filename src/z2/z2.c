/* $Id: z2.c 2 2014-01-28 10:25:41Z remko $
 * ----------------------------------------------------------------------
 * Test of GMT API
 * with modules psxy and ps2raster 
 * and GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
 * GMT_Create_Data, GMT_Get_ID and GMT_Encode_ID
 * ----------------------------------------------------------------------
 * To compile:
 * ----------------------------------------------------------------------
 * Linux
 *   gcc z2.c -I/opt/gmt/include/gmt -lgmt
 *   icc z2.c -I/opt/gmt/include/gmt -lgmt
 *   pgcc z2.c -I/opt/gmt/include/gmt -L/opt/gmt/lib -lgmt
 * ----------------------------------------------------------------------
 * Windows
 *   gcc z2.c -Ic:\programs\gmt5\include\gmt -Lc:\programs\gmt5\lib -lgmt
 *   pgcc z2.c -Ic:\programs\gmt5\include\gmt -Lc:\programs\gmt5\lib -lgmt
 * ----------------------------------------------------------------------
 */

#include <gmt.h>

int main() {
	/* user data declarations */
	const int nmax=10;
	double x[nmax+1],y[nmax+1];
	int i;

	/* GMT related declarations */
	id *API=NULL;
	ruct GMT_VECTOR *v=NULL;
	uble *wesn,*inc;
	nt64_t dim[2]; /* alias par */
	ar filename[16],args[100];
	t idIn,ierr;

/* user data */
	for (i=0; i<=nmax; i++) {
		x[i]=i; y[i]=i*i;
	}

/* create GMT session */
	API=GMT_Create_Session("Test",2,0,0);
	printf("Create_Session: %c\n",API!=NULL?'T':'F');

/* create GMT data */
	dim[GMT_X]=(uint64_t) 2;
	dim[GMT_Y]=(uint64_t) nmax+1;
	wesn=NULL;
	inc=NULL;
	v=GMT_Create_Data(API,GMT_IS_VECTOR,GMT_IS_POINT,0,dim,wesn,inc,0,0,NULL);
	printf("Create_Data: %c\n",v!=NULL?'T':'F');

/* associate GMT_VECTOR components with user data */
	v->type[0]=GMT_DOUBLE;
	v->data[0].f8=(double *) x;
	v->type[1]=GMT_DOUBLE;
	v->data[1].f8=(double *) y;
	printf("Create_Data cols&rows: %d %d\n",(int) v->n_columns,(int) v->n_rows);

	/* get id for GMT_VECTOR */
	idIn=GMT_Get_ID(API,GMT_IS_DATASET,GMT_IN,v);
	printf("Get_ID: %d\n",idIn);

	/* get a filename for GMT_VECTOR */
	ierr=GMT_Encode_ID(API,filename,idIn);
	printf("Encode_ID: %s\n",filename);

	/* call psxy */
	sprintf(args,"%s %s %s",filename,"-JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P","->xy.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","psxy",ierr);

	/* call ps2raster */
	ierr=GMT_Call_Module(API,"ps2raster",GMT_MODULE_CMD,"xy.ps -Tg");
	printf("Call_Module: %s %d\n","ps2raster",ierr);

	/* clean up */
	ierr=GMT_Destroy_Session(API);
	printf("Destroy_Session: %d\n",ierr);
}
