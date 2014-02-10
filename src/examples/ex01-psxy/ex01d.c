/* $Id$
 * ----------------------------------------------------------------------
 * Test of GMT API
 * modules gmtset, psxy and ps2raster 
 * GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
 * GMT_Create_Data, GMT_Get_ID, GMT_Encode_ID and GMT_Report
 * ----------------------------------------------------------------------
 */

#include <gmt.h>

int main() {
	/* user data declarations */
	const int nmax=10;
	double x[nmax+1],y[nmax+1];
	int i;

	/* GMT related declarations */
	void *API=NULL;
	struct GMT_VECTOR *v=NULL;
	unsigned int mode;
	uint64_t dim[2]; /* alias par */
	double *wesn,*inc;
	char filename[16],args[100];
	int idIn,ierr;

	/* create user data */
	for (i=0; i<=nmax; i++) {
		x[i]=i; y[i]=i*i;
	}

	/* create GMT session */
	API=GMT_Create_Session("Test",2,0,0);
	ierr=GMT_Call_Module(API,"gmtset",GMT_MODULE_CMD,"GMT_VERBOSE N");
	ierr=GMT_Report(API,GMT_MSG_NORMAL,"Create_Session: %c\n",API!=NULL?'T':'F');

	/* create GMT_VECTOR */
	mode=0;
	dim[GMT_X]=(uint64_t) 2;
	dim[GMT_Y]=(uint64_t) nmax+1;
	wesn=NULL;
	inc=NULL;
	v=GMT_Create_Data(API,GMT_IS_VECTOR,GMT_IS_POINT,mode,dim,wesn,inc,0,0,NULL);
	ierr=GMT_Report(API,GMT_MSG_NORMAL,"Create_Data: %c\n",v!=NULL?'T':'F');

	/* associate GMT_VECTOR components with user data */
	v->type[0]=GMT_DOUBLE;
	v->data[0].f8=(double *) x;
	v->type[1]=GMT_DOUBLE;
	v->data[1].f8=(double *) y;
	ierr=GMT_Report(API,GMT_MSG_NORMAL,"Create_Data cols&rows: %d %d\n",(int) v->n_columns,(int) v->n_rows);

	/* get id for GMT_VECTOR */
	idIn=GMT_Get_ID(API,GMT_IS_DATASET,GMT_IN,v);
	ierr=GMT_Report(API,GMT_MSG_NORMAL,"Get_ID: %d\n",idIn);

	/* get a filename for GMT_VECTOR */
	ierr=GMT_Encode_ID(API,filename,idIn);
	ierr=GMT_Report(API,GMT_MSG_NORMAL,"Encode_ID: %s\n",filename);

	/* call psxy */
	sprintf(args,"%s %s %s",filename,"-JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P","->ex01.ps");
	ierr=GMT_Report(API,GMT_MSG_NORMAL,"args = %s\n",args);
	ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args);
	ierr=GMT_Report(API,GMT_MSG_NORMAL,"Call_Module: %s %d\n","psxy",ierr);

	/* call ps2raster */
	ierr=GMT_Call_Module(API,"ps2raster",GMT_MODULE_CMD,"ex01.ps -Tg");
	ierr=GMT_Report(API,GMT_MSG_NORMAL,"Call_Module: %s %d\n","ps2raster",ierr);

	/* clean up */
	ierr=GMT_Destroy_Session(API);
}
