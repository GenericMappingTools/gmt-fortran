/* $Id:$
 * ----------------------------------------------------------------------
 * Test of GMT API
 * modules psxy and ps2raster 
 * GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
 * GMT_Read_Data, GMT_Register_IO and GMT_Encode_ID
 * ----------------------------------------------------------------------
 */

#include <gmt.h>

int main() {
	/* user data declarations */
	const int nmax=10;

	/* GMT related declarations */
	void *API=NULL;
	struct GMT_DATASET *D=NULL;
	struct GMT_DATATABLE *T=NULL;
	struct GMT_DATASEGMENT *S=NULL;
	unsigned int mode;
	double *wesn;
	char filename[16],args[100];
	int idIn,ierr;

	/* create GMT session */
	API=GMT_Create_Session("Test",2,0,0);
	printf("Create_Session: %c\n",API!=NULL?'T':'F');

	/* import data from file */
	sprintf(filename,"%s","ex01-xy.dat");
	mode=0;
	wesn=NULL;
	D=GMT_Read_Data(API,GMT_IS_DATASET,GMT_IS_FILE,GMT_IS_POINT,mode,wesn,filename,NULL);
	printf("Read_Data: %c\n",D!=NULL?'T':'F');

	/* optional: check data in GMT_DATASET - Windows gcc ok, otherwise (Linux, pgcc) runtime error */
	T=D->table[0];
	S=T->segment[0];
	printf("About D: %d %d %d\n",(int) D->n_tables,(int) D->n_columns,(int) D->n_records);
	printf("About T: %d %d %d\n",(int) T->n_segments,(int) T->n_columns,(int) T->n_records);
	printf("About S: %d %d\n",(int) S->n_columns,(int) S->n_rows);
	printf("About D: %f %f %f %f\n",D->min[0],D->max[0],D->min[1],D->max[1]);
	printf("About T: %f %f %f %f\n",T->min[0],T->max[0],T->min[1],T->max[1]);
	printf("About S: %f %f %f %f\n",S->min[0],S->max[0],S->min[1],S->max[1]);

	/* get id for GMT_DATASET */
	idIn=GMT_Register_IO(API,GMT_IS_DATASET,GMT_IS_REFERENCE,GMT_IS_POINT,GMT_IN,NULL,D);
	printf("Register_IO: %d\n",idIn);

	/* get a filename for GMT_DATASET */
	ierr=GMT_Encode_ID(API,filename,idIn);
	printf("Encode_ID: %s\n",filename);

	/* call psxy */
	sprintf(args,"%s %s %s",filename,"-JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P","->ex01.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","psxy",ierr);

	/* call ps2raster */
	/* segfault
	ierr=GMT_Call_Module(API,"ps2raster",GMT_MODULE_CMD,"ex01.ps -Tg");
	printf("Call_Module: %s %d\n","ps2raster",ierr);
	*/

	/* clean up */
	/* segfault
	ierr=GMT_Destroy_Session(API);
	printf("Destroy_Session: %d\n",ierr);
	  */
}
