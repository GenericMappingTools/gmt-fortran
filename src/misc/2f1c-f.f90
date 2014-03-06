! $Id$
! ----------------------------------------------------------------------
! Fortran-C linking: double Fortran link to a C function
! ----------------------------------------------------------------------
! to compile: gfortran 2f1c-c.c 2f1c-f.f90
! works also with g95, ifort and pgfortran
! ----------------------------------------------------------------------
! C counterpart:
! #include <stdio.h>
! void ci(int i) { printf("in ci: %d\n",i); };
! ----------------------------------------------------------------------
module mInterface
! ----------------------------------------------------------------------
use iso_c_binding
! interface cprint
interface
subroutine print1(i) bind(c,name='ci')
import c_int
integer(c_int),value :: i
end subroutine
subroutine print2(i) bind(c,name='ci')
import c_int
integer(c_int),value :: i
end subroutine
end interface
end module

! ----------------------------------------------------------------------
program Test1c2f
! ----------------------------------------------------------------------
use mInterface
implicit none
integer i
real x

i=1
! call cprint(i)
call print1(i)
call print2(i)
end program
