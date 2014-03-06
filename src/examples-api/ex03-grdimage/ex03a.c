/* $Id$
 * ----------------------------------------------------------------------
 * Test of GMT API
 * modules xyz2grd, makecpt; psbasemap, grdimage, grdcontour, psscale; ps2raster
 * GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
 * GMT_Create_Data, GMT_Get_ID, GMT_Encode_ID
 * ----------------------------------------------------------------------
 */

#include <gmt.h>

int main() {
	/* user data declarations */
	const int nx=200,ny=120;
	const double a=2.,b=1.;
	const double xmin=-2.,xmax=2.,ymin=-1.2,ymax=1.2; 
	double x[nx+1],y[ny+1],z[nx+1][ny+1],colx[nx+1][ny+1],coly[nx+1][ny+1];
	int ix,iy;

	/* GMT related declarations */
	void *API=NULL;
	struct GMT_VECTOR *v=NULL;
	double *wesn,*inc;
	uint64_t dim[2]; /* alias par */
	char fileIn[16],fileGRD[16],fileCPT[16],args[100];
	int idIn,ierr;

	/* user data */
	for (ix=0; ix<=nx; ix++) { x[ix]=xmin+(xmax-xmin)*ix/nx; }
	for (iy=0; iy<=ny; iy++) { y[iy]=ymin+(ymax-ymin)*iy/ny; }
	for (ix=0; ix<=nx; ix++) {
		for (iy=0; iy<=ny; iy++) {
			z[ix][iy]=a*x[ix]*x[ix]+b*y[iy]*y[iy];
			colx[ix][iy]=x[ix];
			coly[ix][iy]=y[iy];
		}
	}

	/* create GMT session */
	API=GMT_Create_Session("Test",2,0,0);
	printf("Create_Session: %c\n",API!=NULL?'T':'F');

	/* create GMT data */
	dim[GMT_X]=(uint64_t) 3;
	dim[GMT_Y]=(uint64_t) (nx+1)*(ny+1);
	wesn=NULL;
	inc=NULL;
	v=GMT_Create_Data(API,GMT_IS_VECTOR,GMT_IS_POINT,0,dim,wesn,inc,0,0,NULL);
	printf("Create_Data: %c\n",v!=NULL?'T':'F');

	/* associate GMT_VECTOR components with user data */
	v->type[0]=GMT_DOUBLE;
	v->data[0].f8=(double *) colx;
	v->type[1]=GMT_DOUBLE;
	v->data[1].f8=(double *) coly;
	v->type[2]=GMT_DOUBLE;
	v->data[2].f8=(double *) z;
	printf("Create_Data cols&rows: %d %d\n",(int) v->n_columns,(int) v->n_rows);

	/* get id and filename for GMT_VECTOR */
	idIn=GMT_Get_ID(API,GMT_IS_DATASET,GMT_IN,v);
	ierr=GMT_Encode_ID(API,fileIn,idIn);
	printf("GMT_VECTOR Get_ID & Encode ID: %d %s\n",idIn,fileIn);

	/* create GRD */
	sprintf(fileGRD,"%s","ex03-xyz.grd");
	sprintf(args,"%s %s%s %s",fileIn,"-G",fileGRD,"-R-2/2/-1.2/1.2 -I.02/.02");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"xyz2grd",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","xyz2grd",ierr);

	/* create CPT */
	sprintf(fileCPT,"%s","ex03-xyz.cpt");
	sprintf(args,"%s%s","-Crainbow -T0/10/2 -Z ->",fileCPT);
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"makecpt",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","makecpt",ierr);

	/* create PostScript */
	sprintf(args,"%s","-JX14c/8c -R -Ba0.5 -BWeSn+tFig. -P -K ->ex03.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"psbasemap",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","psbasemap",ierr);

	sprintf(args,"%s %s%s %s",fileGRD,"-J -R -B -C",fileCPT,"-O -K ->>ex03.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"grdimage",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","grdimage",ierr);

	sprintf(args,"%s %s",fileGRD,"-J -R -B -C2 -O -K ->>ex03.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"grdcontour",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","grdcontour",ierr);

	sprintf(args,"%s%s %s","-D15c/4c/8c/1c -C",fileCPT,"-O ->>ex03.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"psscale",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","psscale",ierr);

	/* create PNG */
	sprintf(args,"%s","ex03.ps -Tg");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"ps2raster",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","ps2raster",ierr);

	/* clean up */
	ierr=GMT_Destroy_Session(API);
	printf("Destroy_Session: %d\n",ierr);
}
