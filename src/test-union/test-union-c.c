/* $Id: test-union-c.c 2 2014-01-28 10:25:41Z remko $
 */

#include <stdio.h>
union tU {int i; float x;};
void f(union tU *pu) {
	printf("int view: %d; float view: %f\n",pu->i,pu->x);
};
