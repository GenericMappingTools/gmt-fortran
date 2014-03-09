! ======================================================================
! Miscellaneous procedures (not needed but useful) for GMT Fortran API
! ======================================================================
! List: 
! +                           to overload the operator for strings and integers
! integer function newunit()  to return a unique unit number (pre-Fortran 2008)
! subroutine echo(lines,file) to write a character array into a file
! subroutine rm(file)         to remove a file
! ======================================================================
module gmt_misc
! ======================================================================
implicit none
! ----------------------------------
! overload + operator for blank-separated string and int operands
! combine with // for separation without blanks
! usage: 'psxy'+file+args+'->'//ps  for 'psxy file01.dat -J -R -B ->file.ps'
!        trim('file'+11)//'.dat'    for 'file11.dat'
! ----------------------------------
interface operator (+)
module procedure ChPlusCh,ChPlusInt
end interface
! ======================================================================
contains
! ======================================================================
! return blank-separated trimmed string + string
! ----------------------------------
function ChPlusCh(a,b)
implicit none
character(*),intent(in) :: a,b
character(len_trim(a)+1+len_trim(b)) ChPlusCh
ChPlusCh=trim(a)//' '//trim(b)
end function
! ----------------------------------
! return trimmed string + integer
! ----------------------------------
function ChPlusInt(a,ib)
implicit none
character(*),intent(in) :: a
integer,intent(in) :: ib
character(10) chb
character(len_trim(a)+len(chb)) ChPlusInt
write (chb,'(i0)') ib
ChPlusInt=trim(a)//chb
end function
! ----------------------------------
! return a unique unit number
! usage: id=newunit(); open (id,file=...)
! or use a Fortran 2008 feature: open (newunit=id,file=...)
! ----------------------------------
integer function newunit()
implicit none
real x
call random_number(x)
newunit=int(765+4321*x)
end function
! ----------------------------------
! write character array lines into a file
! ----------------------------------
subroutine echo(lines,file)
implicit none
character(*) lines(:)
character(*) file
integer :: id,i
id=newunit(); open (id,file=file)
! open (newunit=id,file=file) ! Fortran 2008 feature
do i=1,size(lines)
write (id,'(a)') trim(lines(i))
enddo
close (id)
end subroutine
! ----------------------------------
subroutine echofl(file,lines)
implicit none
character(*) file
character(*) lines(:)
call echo(lines,file)
end subroutine
! ----------------------------------
! remove a file
! ----------------------------------
subroutine rm(file)
implicit none
character(*) file
integer :: id
id=newunit(); open (id,file=file)
! open (newunit=id,file=file) ! Fortran 2008 feature
close (id,status='delete')
end subroutine
! ======================================================================
end module
! ======================================================================
