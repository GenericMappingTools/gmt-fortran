! $Id$
! overloads operator + for character strings and integers

module mPlus
interface operator (+)
module procedure ChPlusCh,ChPlusInt
end interface

contains

! blank-separated trimmed string+string
function ChPlusCh(a,b)
implicit none
character(*),intent(in) :: a,b
character(len_trim(a)+1+len_trim(b)) ChPlusCh
ChPlusCh=trim(a)//' '//trim(b)
end function

! blank-separated trimmed string+int
function ChPlusInt(a,ib)
implicit none
character(*),intent(in) :: a
integer,intent(in) :: ib
character(10) chb
! character(int(log10(abs(real(ib,8)))+1+merge(1,0,ib<0))) chb ! ifort 13.1.0 problem
character(len_trim(a)+1+len(chb)) ChPlusInt
write (chb,'(i0)') ib
ChPlusInt=trim(a)//' '//chb
end function

end module

program TestChPlus
use mPlus
character(60) :: file='01.dat'
print *,'File'+file+'id'+0
print *,'File'+file+'id'+1
print *,'File'+file+'id'+11
print *,'File'+file+'id'+(-1)
print *,'File'+file+'id'+(-11)
print '(i0)',0
print '(i0)',1
print '(i0)',11
print '(i0)',-1
print '(i0)',-11
end program
