! $Id:$
! ----------------------------------------------------------------------
! Fortran handling of (i.e., passing data to) C unions
! ----------------------------------------------------------------------
! to compile: gfortran union-c.c union-f.f90
! works also with g95, ifort and pgfortran
! ----------------------------------------------------------------------
! C counterpart:
! #include <stdio.h>
! union tU {int i; float x;};
! void f(union tU *pu) {
!   printf("int view: %d; float view: %f\n",pu->i,pu->x);
! };
! ----------------------------------------------------------------------
module mInterface
! ----------------------------------------------------------------------
use iso_c_binding
interface
subroutine s(pu) bind(c,name='f')
import c_ptr
type(c_ptr),value :: pu
end subroutine
end interface
end module

! ----------------------------------------------------------------------
program TestUnion
! ----------------------------------------------------------------------
use mInterface
implicit none
integer,target :: i
real,target :: x

i=1
call s(c_loc(i))
x=1.
call s(c_loc(x))
end program
