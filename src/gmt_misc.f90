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
! ----------------------------------
interface int2char
module procedure int2char1,int2char2
end interface
interface i2ch
module procedure int2char1,int2char2
end interface
private int2char1,int2char2
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
integer,parameter :: lenchi=10
character(lenchi) chi
character(len_trim(a)+1+lenchi) ChBInt
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
integer,parameter :: lenchi=10
character(lenchi) chi
character(len_trim(a)+lenchi) ChInt
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
integer,parameter :: lenchr=12
character(lenchr) chr
character(len_trim(a)+1+lenchr) ChBReal4
write (chr,'(f0.5)') r
ChBReal4=trim(a)//' '//chr
end function
! ----------------------------------
function ChBReal8(a,r)
implicit none
character(*),intent(in) :: a
real(8),intent(in) :: r
integer,parameter :: lenchr=12
character(lenchr) chr
character(len_trim(a)+1+lenchr) ChBReal8
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
integer,parameter :: lenchr=12
character(lenchr) chr
character(len_trim(a)+lenchr) ChReal4
write (chr,'(f0.5)') r
ChReal4=trim(a)//chr
end function
! ----------------------------------
function ChReal8(a,r)
implicit none
character(*),intent(in) :: a
real(8),intent(in) :: r
integer,parameter :: lenchr=12
character(lenchr) chr
character(len_trim(a)+lenchr) ChReal8
write (chr,'(f0.5)') r
ChReal8=trim(a)//chr
end function
! ======================================================================
! convert integer to a string of a given length
! example: ch=i2ch(1,3) for "001"
! ----------------------------------
function int2char1(i)
implicit none
integer,intent(in) :: i
character(12) int2char1
write (int2char1,'(i0)') i
end function
! ----------------------------------
function int2char2(i,len)
implicit none
integer,intent(in) :: i
integer,intent(in) :: len
character(len) int2char2
character(20) format
write (format,'(a,i0,a,i0,a)') '(i',len,'.',len,')'
write (int2char2,format) i
end function
! ----------------------------------
! return a random integer
! ----------------------------------
integer function irandom()
implicit none
real x
call random_number(x)
irandom=int(765+4321*x)
end function
! ----------------------------------
! return a unique unit number
! usage: id=newunit(); open (id,file=...)
! or use a Fortran 2008 feature: open (newunit=id,file=...)
! ----------------------------------
integer function newunit()
implicit none
newunit=irandom()
end function
! ----------------------------------
! write character array lines into a file
! ----------------------------------
subroutine echo(lines,file)
implicit none
character(*),intent(in) :: lines(:)
character(*),intent(in) :: file
integer :: id,i
id=newunit(); open (id,file=file)
! open (newunit=id,file=file) ! Fortran 2008 feature
do i=1,size(lines)
write (id,'(a)') trim(lines(i))
enddo
close (id)
end subroutine
! ----------------------------------
subroutine echolf(lines,file)
implicit none
character(*),intent(in) :: lines(:)
character(*),intent(in) :: file
call echo(lines,file)
end subroutine
! ----------------------------------
subroutine echofl(file,lines)
implicit none
character(*),intent(in) :: file
character(*),intent(in) :: lines(:)
call echo(lines,file)
end subroutine
! ----------------------------------
! remove a file
! ----------------------------------
subroutine rm(file)
implicit none
character(*),intent(in) :: file
integer :: id
print *,'rm: ',trim(file)
id=newunit(); open (id,file=file)
! open (newunit=id,file=file) ! Fortran 2008 feature
close (id,status='delete')
end subroutine
! ======================================================================
end module
! ======================================================================
