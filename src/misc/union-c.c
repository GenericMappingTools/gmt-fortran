/* $Id$
 * ----------------------------------------------------------------------
 * see header comments of the Fortran counterpart
 * ----------------------------------------------------------------------
 */

#include <stdio.h>
union tU {int i; float x;};
void f(union tU *pu) {
	printf("int view: %d; float view: %f\n",pu->i,pu->x);
};
