/* $Id$
 * ----------------------------------------------------------------------
 * see header comments of the Fortran counterpart
 * ----------------------------------------------------------------------
 */

#include <stdio.h>

struct tS {float x; float *px; float **ppx;};

void f(float x, float *px, float **ppx, struct tS *ps) {
	printf("C.. x: %f, px: %f, ppx: %f, ps: %f %f %f\n",x,*px,**ppx,ps->x,*(ps->px),**ps->ppx);
};
