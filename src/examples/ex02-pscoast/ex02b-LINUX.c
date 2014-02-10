/* $Id$
 * ----------------------------------------------------------------------
 * Test of GMT API
 * modules pscoast, psxy, pstext and ps2raster
 * GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
 * GMT_Create_Data, GMT_Get_ID and GMT_Encode_ID
 * ----------------------------------------------------------------------
 */

#include <gmt.h>

int main() {
	/* user data declarations */
	const int nmax=2;
	double x[nmax],y[nmax];

	/* GMT related declarations */
	void *API=NULL;
	struct GMT_VECTOR *v=NULL,*v2=NULL;
	uint64_t dim[2]; /* alias par */
	char filename[16],filename2[16],args[100];
	int idIn,idIn2,ierr;

	/* create user data */
	x[0]=  14; y[0]=  50;
	x[1]=-158; y[1]=  21;

	/* create GMT session */
	API=GMT_Create_Session("Test",2,0,0);
	printf("Create_Session: %c\n",API!=NULL?'T':'F');

	/* create GMT_VECTOR */
	dim[GMT_X]=(uint64_t) 2;
	dim[GMT_Y]=(uint64_t) nmax;
	v=GMT_Create_Data(API,GMT_IS_VECTOR,GMT_IS_POINT,0,dim,NULL,NULL,0,0,NULL);
	printf("Create_Data: %c\n",v!=NULL?'T':'F');
	v2=GMT_Create_Data(API,GMT_IS_VECTOR,GMT_IS_LINE,0,dim,NULL,NULL,0,0,NULL);
	printf("Create_Data: %c\n",v2!=NULL?'T':'F');

	/* associate GMT_VECTOR components with user data */
	v->type[0]=GMT_DOUBLE;
	v->data[0].f8=(double *) x;
	v->type[1]=GMT_DOUBLE;
	v->data[1].f8=(double *) y;
	v2->type[0]=GMT_DOUBLE;
	v2->data[0].f8=(double *) x;
	v2->type[1]=GMT_DOUBLE;
	v2->data[1].f8=(double *) y;
	printf("Create_Data cols&rows: %d %d\n",(int) v->n_columns,(int) v->n_rows);

	/* call pscoast */
	sprintf(args,"%s %s","-JG-100/50/10c -R0/360/-90/90 -Bg30/g15 -Dl -Gsandybrown -Slightskyblue -P -K","->ex02.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"pscoast",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","pscoast",ierr);

	/* call psxy for points */
	idIn=GMT_Get_ID(API,GMT_IS_DATASET,GMT_IN,v);
	ierr=GMT_Encode_ID(API,filename,idIn);
	sprintf(args,"%s %s %s",filename,"-J -R -Gyellow -Sc7p -W1p,blue -O -K","->>ex02.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","psxy",ierr);

	/* call psxy for lines */
	/* Linux: segfault, Windows: ok
	idIn2=GMT_Get_ID(API,GMT_IS_DATASET,GMT_IN,v2);
	ierr=GMT_Encode_ID(API,filename2,idIn2);
	sprintf(args,"%s %s %s",filename2,"-J -R -W1p,blue -O -K","->>ex02.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","psxy",ierr);
	*/

	/* call pstext */
	sprintf(filename,"%s","ex02-text.dat");
	sprintf(args,"%s %s %s",filename,"-J -R -D0.25c/-0.4c -O","->>ex02.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"pstext",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","pstext",ierr);

	/* call ps2raster */
	ierr=GMT_Call_Module(API,"ps2raster",GMT_MODULE_CMD,"ex02.ps -Tg");
	printf("Call_Module: %s %d\n","ps2raster",ierr);

	/* clean up */
	ierr=GMT_Destroy_Session(API);
	printf("Destroy_Session: %d\n",ierr);
}
