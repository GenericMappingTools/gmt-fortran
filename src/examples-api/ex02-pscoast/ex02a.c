/* $Id$
 * ----------------------------------------------------------------------
 * Test of GMT API
 * modules pscoast, psxy, pstext and ps2raster
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

	/* call pscoast */
	sprintf(args,"%s %s","-JG-100/50/10c -R0/360/-90/90 -Bxg30 -Byg15 -Dl -Gsandybrown -Slightskyblue -P -K","->ex02.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"pscoast",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","pscoast",ierr);

	/* call psxy for lines */
	sprintf(filename,"%s","ex02-line.dat");
	sprintf(args,"%s %s %s",filename,"-J -R -W1p,blue -O -K","->>ex02.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","psxy",ierr);

	/* call psxy for points */
	sprintf(filename,"%s","ex02-line.dat");
	sprintf(args,"%s %s %s",filename,"-J -R -Gyellow -Sc7p -W1p,blue -O -K","->>ex02.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"psxy",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","psxy",ierr);

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
