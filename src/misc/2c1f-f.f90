! $Id$
! ----------------------------------------------------------------------
! Fortran overloading with iso_c_binding
! ----------------------------------------------------------------------
! to compile: gfortran 2c1f-c.c 2c1f-f.f90
! works also with g95, ifort and pgfortran
! ----------------------------------------------------------------------
! C counterpart:
! #include <stdio.h>
! void ci(int i) { printf("in ci: %d\n",i); };
! void cf(float x) { printf("in cf: %f\n",x); };
! ----------------------------------------------------------------------
module mInterface
! ----------------------------------------------------------------------
use iso_c_binding
interface cprint
subroutine iprint(i) bind(c,name='ci')
import c_int
integer(c_int),value :: i
end subroutine
subroutine rprint(x) bind(c,name='cf')
import c_float
real(c_float),value :: x
end subroutine
end interface
end module

! ----------------------------------------------------------------------
program Test2c1f
! ----------------------------------------------------------------------
use mInterface
implicit none
integer i
real x

i=1
call cprint(i)
x=1.
call cprint(x)
end program
