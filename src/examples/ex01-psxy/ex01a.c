/* $Id:$
 * ----------------------------------------------------------------------
 * Test of GMT API
 * modules psxy and ps2raster
 * GMT API functions GMT_Create_Session, GMT_Call_Module and GMT_Destroy_Session
 * ----------------------------------------------------------------------
 */

#include <gmt.h>

int main() {
	/* GMT related declarations */
	void *API=NULL;
	char filename[16],args[100];
	int ierr;

	/* create GMT session */
	API=GMT_Create_Session("Test",2,0,0);
	printf("Create_Session: %c\n",API!=NULL?'T':'F');

	/* call psxy */
	sprintf(filename,"%s","ex01-xy.dat");
	sprintf(args,"%s %s %s",filename,"-JX16c/24c -R0/11/0/110 -B2:x:/20:y:WS:.Fig.: -Sa1c -N -P","->ex01.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","psxy",ierr);

	/* call ps2raster */
	ierr=GMT_Call_Module(API,"ps2raster",GMT_MODULE_CMD,"ex01.ps -Tg");
	printf("Call_Module: %s %d\n","ps2raster",ierr);

	/* clean up */
	ierr=GMT_Destroy_Session(API);
	printf("Destroy_Session: %d\n",ierr);
}
