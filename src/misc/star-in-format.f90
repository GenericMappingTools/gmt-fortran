! $Id$
! creates a string from blank-separated words
implicit none
character(80) string
! Fortran 2008 feature implemented in gfortran and ifort (as of 02/2014)
write (string,'(*(a,1x))') '1','2','3'
! workaround (multiplier can be any positive integer)
write (string,'(8(a,1x))') '1','2','3'
print *,string
end program

