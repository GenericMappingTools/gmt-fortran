! $Id: test-union-f.f90 2 2014-01-28 10:25:41Z remko $
! gfortran test-union-c.c test-union-f.f90

use iso_c_binding
interface
subroutine s(pu) bind(c,name='f')
import c_ptr
type(c_ptr),value :: pu
end subroutine
end interface

integer,target :: i
real,target :: x
i=1
call s(c_loc(i))
x=1.
call s(c_loc(x))
end program
