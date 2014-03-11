! $Id$
! ======================================================================
! Miscellaneous procedures (not needed but useful) for GMT Fortran API
! ======================================================================
! List of operators and procedures: 
! +, -                        operators overloaded for strings with numbers
! integer function newunit()  to return a unique unit number (pre-Fortran 2008)
! subroutine echo(lines,file) to write a character array into a file
! subroutine rm(file)         to remove a file
! ======================================================================
module gmt_misc
! ======================================================================
implicit none
! ----------------------------------
! overloaded + operator for blank-separated string and int/real operands
! overloaded - operator for concatenated string and int/real operands
! usage: "psxy"+dat+"-J -R -B"                     for "psxy file.dat -J -R -B"
!        "psxy"+"file"-0-1-".dat"+"->"-ps          for "psxy file01.dat ->file.ps"
!        "psxy -R"-xmin-"/"-xmax-"/"-ymin-"/"-ymax for "psxy -R0/1/.00000/1.00000"
! ----------------------------------
interface operator (+)
module procedure ChBCh,ChBInt,ChBReal4,ChBReal8
end interface
interface operator (-)
module procedure ChCh,ChInt,ChReal4,ChReal8
end interface
private ChBCh,ChBInt,ChBReal4,ChBReal8,ChCh,ChInt,ChReal4,ChReal8
! ======================================================================
contains
! ======================================================================
! a+b: return concatenated trimmed string and blank and string
! ----------------------------------
function ChBCh(a,b)
implicit none
character(*),intent(in) :: a,b
character(len_trim(a)+1+len_trim(b)) ChBCh
ChBCh=trim(a)//' '//trim(b)
end function
! ----------------------------------
! a-b: return concatenated trimmed string and string
! ----------------------------------
function ChCh(a,b)
implicit none
character(*),intent(in) :: a,b
character(len_trim(a)+len_trim(b)) ChCh
ChCh=trim(a)//trim(b)
end function
! ----------------------------------
! a+i: return concatenated trimmed string and blank and integer
! ----------------------------------
function ChBInt(a,i)
implicit none
character(*),intent(in) :: a
integer,intent(in) :: i
character(10) chi
character(len_trim(a)+1+len(chi)) ChBInt
write (chi,'(i0)') i
ChBInt=trim(a)//' '//chi
end function
! ----------------------------------
! a-i: return concatenated trimmed string and integer
! ----------------------------------
function ChInt(a,i)
implicit none
character(*),intent(in) :: a
integer,intent(in) :: i
character(10) chi
character(len_trim(a)+len(chi)) ChInt
write (chi,'(i0)') i
ChInt=trim(a)//chi
end function
! ----------------------------------
! a+r: return concatenated trimmed string and blank and real
! ----------------------------------
function ChBReal4(a,r)
implicit none
character(*),intent(in) :: a
real(4),intent(in) :: r
character(12) chr
character(len_trim(a)+1+len(chr)) ChBReal4
write (chr,'(f0.5)') r
ChBReal4=trim(a)//' '//chr
end function
function ChBReal8(a,r)
implicit none
character(*),intent(in) :: a
real(8),intent(in) :: r
character(12) chr
character(len_trim(a)+1+len(chr)) ChBReal8
write (chr,'(f0.5)') r
ChBReal8=trim(a)//' '//chr
end function
! ----------------------------------
! a-r: return concatenated trimmed string and real
! ----------------------------------
function ChReal4(a,r)
implicit none
character(*),intent(in) :: a
real(4),intent(in) :: r
character(12) chr
character(len_trim(a)+len(chr)) ChReal4
write (chr,'(f0.5)') r
ChReal4=trim(a)//chr
end function
function ChReal8(a,r)
implicit none
character(*),intent(in) :: a
real(8),intent(in) :: r
character(12) chr
character(len_trim(a)+len(chr)) ChReal8
write (chr,'(f0.5)') r
ChReal8=trim(a)//chr
end function
! ======================================================================
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
