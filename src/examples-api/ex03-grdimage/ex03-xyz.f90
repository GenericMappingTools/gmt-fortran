! $Id$
! ----------------------------------
! Writes data for example ex03*
! Compile: gfortran ex03-xyz.f90
! Run: a > ex03-xyz.dat
! ----------------------------------
nx=200
ny=120
a=2.
b=1.
xmin=-2. ; xmax=2.
ymin=-1.2 ; ymax=1.2
do ix=0,nx
  x=xmin+(xmax-xmin)*ix/nx
  do iy=0,ny
    y=ymin+(ymax-ymin)*iy/ny
    print '(3f10.5)',x,y,a*x**2+b*y**2
  enddo
enddo
end program
