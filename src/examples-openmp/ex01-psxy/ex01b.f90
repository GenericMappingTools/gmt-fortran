! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API with OpenMP
! time series of 2D plots
!   y(x,t)=sin(k.x+w.t), x=0..2*pi, t=0..2*pi, k=const, w=const,
! nthread threads create (ntime+1) plots of (nmax+1) points [x,y(x,t)]
! session structures API are threadprivate (not just private) to survive across parallel regions
! calls to Create_Session are serialized, otherwise conflicts emerge when reading gmt.conf
! calls to ps2raster are serialized, otherwise results are errorneous
! ----------------------------------------------------------------------

program ex04c
use gmt
use gmt_misc
use omp_lib
implicit none
logical,parameter :: runParallel= .true. ! run parallel?
integer,parameter :: nthread    =      4 ! number of threads
integer,parameter :: ntime      =    100 ! number of time steps
integer,parameter :: nmax       = 100000 ! number of spatial points
logical,parameter :: makeJPG    = .false.! make bitmaps?
real(8),parameter :: pi=3.14159265358979_8
real(8),allocatable :: x(:),y(:)
real(8) k,w,t
integer(8) dim(0:1)
character(16) filedat,fileps
character(80) title
character(200) cmd
integer i,id,it
character(4) ch,chd,cht
type(c_ptr),save :: API
!$OMP THREADPRIVATE (API)

! initialization of shared data
allocate (x(0:nmax),y(0:nmax))
x=pi*2.*[(i,i=0,nmax)]/nmax
k=1.
w=1.
dim=[2,size(x)]

! parallel region
!$OMP PARALLEL IF (runParallel) NUM_THREADS (nthread) &
!$OMP DEFAULT (NONE) SHARED (x,k,w,dim) PRIVATE (it,t,y,id,filedat,fileps,title,cmd,ch,chd,cht)

! create threadprivate API sessions
  it=OMP_GET_THREAD_NUM()              ! thread number
  write (cht,'(i4.4)') it
!$OMP CRITICAL
  API=GMT_Create_Session("Test "//cht) ! conflicts when reading gmt.conf in parallel
!$OMP END CRITICAL
  print '(a,i4,a)','session',it,' created'

! run a parallel loop to create plots
!$OMP DO SCHEDULE (DYNAMIC)
do i=0,ntime
  write (ch,'(i4.4)') i
  fileps=ch//".ps"                     ! PostScript output
  t=pi*2.*i/ntime                      ! time
  y=sin(k*x+w*t)                       ! y data
  call sGMT_Create_Init_Encode(API,dim=dim,c1=x,c2=y,object_ID=id,string=filedat)
  write (chd,'(i4.4)') id              ! object_ID for y data
  print '(a,3i5)','i,id,it = ',i,id,it
  title='"i/id/it = '//ch//'/'//chd//'/'//cht//'"'
  cmd="psxy"+filedat+"-JX15c/10c -R0/7/-1/1 -Bx1+lx -By0.5+ly -BWS+t"//title+"-Sc0.15c -N ->"//fileps
  call sGMT(API,cmd)                   ! call psxy with data from user arrays

  if (makeJPG) then                    ! convert PostScript to bitmaps
  cmd="ps2raster"+fileps+"-P"
!$OMP CRITICAL
  call sGMT(API,cmd)                   ! errorneous results when running ps2raster in parallel
!$OMP END CRITICAL
  endif
enddo

! destroy API sessions
  call sGMT_Destroy_Session(API)
  print '(a,i4,a)','session',it,' destroyed'

!$OMP END PARALLEL

deallocate (x,y)
end program
