! $Id$
! ----------------------------------------------------------------------
! Fortran handling of 
! .. float, float*, float** function arguments
! .. float, float*, float** struct components 
! ----------------------------------------------------------------------
! to compile: gfortran ptr-ptr-c.c ptr-ptr-f.f90
! works also with ifort and pgfortran, but not with g95
! ----------------------------------------------------------------------
! C counterpart:
! #include <stdio.h>
! struct tS {float x; float *px; float **ppx;};
! void f(float x, float *px, float **ppx, struct tS *ps) {
!   printf("C.. x: %f, px: %f, ppx: %f, ps: %f %f %f\n",x,*px,**ppx,ps->x,*(ps->px),**ps->ppx);
! };
! ----------------------------------------------------------------------
module mInterface
! ----------------------------------------------------------------------
use iso_c_binding

type,bind(c) :: tS
real(c_float) x
type(c_ptr) px
type(c_ptr) ppx
end type

interface
subroutine s(x,px,ppx,ps) bind(c,name='f')
import c_float,c_ptr
real(c_float),value :: x ! target by value
type(c_ptr),value :: px  ! pointer by value, target by reference
type(c_ptr) :: ppx       ! pointer by reference
type(c_ptr),value :: ps
end subroutine
end interface

end module

! ----------------------------------------------------------------------
program TestPtrPtr
! ----------------------------------------------------------------------
use mInterface
implicit none
real,target :: x
type(c_ptr),target :: px
type(c_ptr) :: ppx
type(tS),pointer :: Fs
type(c_ptr) :: ps
real,pointer :: Fx,sFx
type(c_ptr),pointer :: Fpx,sFpx
real,pointer :: FFx,sFFx

x=1.                          ! target
px=c_loc(x)                   ! pointer to target
ppx=c_loc(px)                 ! pointer to pointer
allocate (Fs)
Fs=tS(x,px,ppx)               ! Fortran pointer to struct
ps=c_loc(Fs)                  ! C pointer to struct

call s(x,px,px,ps)            ! passing: target by value, pointer by value, pointer by reference, pointer by value

call c_f_pointer(px,Fx)       ! Fortran pointer to real variable
call c_f_pointer(ppx,Fpx)     ! Fortran pointer to C pointer
call c_f_pointer(Fpx,FFx)     ! Fortran pointer to target of C pointer
call c_f_pointer(ps,Fs)       ! Fortran pointer to struct
call c_f_pointer(Fs%px,sFx)   ! Fortran pointer to float* component
call c_f_pointer(Fs%ppx,sFpx) ! Fortran pointer to C pointer
call c_f_pointer(sFpx,sFFx)   ! Fortran pointer to float** component

print "('F.. x:',f9.6,', Fx:',f9.6,', FFx:',f9.6,', Fs:',3f9.6)",x,Fx,FFx,Fs%x,sFx,sFFx
end program
