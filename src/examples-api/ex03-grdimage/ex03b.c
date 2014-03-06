/* $Id$
 * ----------------------------------------------------------------------
 * Test of GMT API
 * modules xyz2grd, makecpt; psbasemap, grdimage, grdcontour, psscale; ps2raster
 * GMT API functions GMT_Create_Session, GMT_Call_Module, GMT_Destroy_Session,
 * GMT_Create_Data, GMT_Get_ID, GMT_Encode_ID,
 * GMT_Register_IO, GMT_Retrieve_Data and GMT_Duplicate_Data
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
	char fileIn[16],fileGRD[16],fileGRD2[16],fileCPT[16],args[100];
	void *pGRD,*pGRD2,*pCPT;
	int idIn,idGRD,idGRD2,idCPT,ierr;

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

	/* create and register GRD in memory */
	idGRD=GMT_Register_IO(API,GMT_IS_GRID,GMT_IS_REFERENCE,GMT_IS_SURFACE,GMT_OUT,NULL,NULL);
	ierr=GMT_Encode_ID(API,fileGRD,idGRD);
	printf("GRD Register_ID & Encode ID: %d %s\n",idGRD,fileGRD);
	sprintf(args,"%s %s%s %s",fileIn,"-G",fileGRD,"-R-2/2/-1.2/1.2 -I.02/.02");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"xyz2grd",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","xyz2grd",ierr);
	pGRD=(void *) GMT_Retrieve_Data(API,idGRD);
	idGRD=GMT_Register_IO(API,GMT_IS_GRID,GMT_IS_REFERENCE,GMT_IS_SURFACE,GMT_IN,NULL,pGRD);
	ierr=GMT_Encode_ID(API,fileGRD,idGRD);
	printf("GRD Retrieve_Data & reRegister_IO: %c %d %s\n",pGRD!=NULL?'T':'F',idGRD,fileGRD);

	/* duplicate GRD */
	/* as of v.5.1.0: using one GRD for grdimage and grdcontour breaks the latter
	 * the same for GMT_Register_IO(...,GMT_IS_REFERENCE|GMT_IO_RESET,...)
	 * the same for second registration of pGRD
	 * data duplication helps
	 * cf. http://gmt.soest.hawaii.edu/boards/2/topics/157
	 */
	pGRD2=(void *)GMT_Duplicate_Data(API,GMT_IS_GRID,GMT_DUPLICATE_DATA,pGRD);
	idGRD2=GMT_Register_IO(API,GMT_IS_GRID,GMT_IS_REFERENCE,GMT_IS_SURFACE,GMT_IN,NULL,pGRD2);
	ierr=GMT_Encode_ID(API,fileGRD2,idGRD2);
	printf("GRD2 Register_IO: %c %c %d %s\n",pGRD2!=NULL?'T':'F',pGRD2!=pGRD?'T':'F',idGRD2,fileGRD2);

	/* create and register CPT in memory */
	idCPT=GMT_Register_IO(API,GMT_IS_CPT,GMT_IS_REFERENCE,GMT_IS_NONE,GMT_OUT,NULL,NULL);
	ierr=GMT_Encode_ID(API,fileCPT,idCPT);
	printf("CPT Register_ID & Encode ID: %d %s\n",idCPT,fileCPT);
	sprintf(args,"%s%s","-Crainbow -T0/10/2 -Z ->",fileCPT);
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"makecpt",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","makecpt",ierr);
	pCPT=(void *)GMT_Retrieve_Data(API,idCPT);
	idCPT=GMT_Register_IO(API,GMT_IS_CPT,GMT_IS_REFERENCE,GMT_IS_NONE,GMT_IN,NULL,pCPT);
	ierr=GMT_Encode_ID(API,fileCPT,idCPT);
	printf("CPT Retrive_Data & reRegister_IO: %c %d %s\n",pCPT!=NULL?'T':'F',idCPT,fileCPT);

	/* create PostScript */
	sprintf(args,"%s","-JX14c/8c -R -Ba0.5 -BWeSn+tFig. -P -K ->ex03.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"psbasemap",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","psbasemap",ierr);

	sprintf(args,"%s %s%s %s",fileGRD,"-J -R -B -C",fileCPT,"-O -K ->>ex03.ps");
	printf("args = %s\n",args);
	ierr=GMT_Call_Module(API,"grdimage",GMT_MODULE_CMD,args);
	printf("Call_Module: %s %d\n","grdimage",ierr);

	sprintf(args,"%s %s",fileGRD2,"-J -R -B -C2 -O -K ->>ex03.ps");
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
