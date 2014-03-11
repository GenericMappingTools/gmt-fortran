! $Id$
! ----------------------------------------------------------------------
! Test of GMT Fortran API with OpenMP
! a series of projection plots
! nthread threads create (ntime+1) plots
! session structures API are threadprivate (not just private) to survive across parallel regions
! calls to Create_Session are serialized, otherwise conflicts emerge when reading gmt.conf
! calls to pscoast are serialized, otherwise segfaults appear
! calls to ps2raster are serialized, otherwise results are errorneous
! ----------------------------------------------------------------------

program ex02a
use gmt
use gmt_misc                              ! operators +- overloaded for strings
use omp_lib
implicit none
logical,parameter :: runParallel= .true.  ! run parallel?
integer,parameter :: nthread    =      4  ! number of threads
integer,parameter :: ntime      =    100  ! number of plots
logical,parameter :: makeJPG    = .false. ! make bitmaps?
character(1),parameter :: resolution ='c' ! resolution: c(rude)-l-i-h-f(ull)
real(8) lonmin,lonmax,latmin,latmax,lon,lat
character(16) fileline,filetext,fileps
character(80) title
character(200) cmd
integer i,it
character(4) ch
type(c_ptr),save :: API
!$OMP THREADPRIVATE (API)

lonmin=-158
lonmax=14
latmin=21
latmax=50
fileline="ex02-line.dat"
filetext="ex02-text.dat"

! parallel region
!$OMP PARALLEL IF (runParallel) NUM_THREADS (nthread) DEFAULT (NONE) &
!$OMP SHARED (lonmin,lonmax,latmin,latmax,fileline,filetext) PRIVATE (ch,it,fileps,lon,lat,title,cmd)

! create threadprivate API sessions
  it=OMP_GET_THREAD_NUM()                ! thread number
!$OMP CRITICAL
  API=GMT_Create_Session("Test"+it)      ! conflicts when reading gmt.conf in parallel
!$OMP END CRITICAL
  print *,"session"+it+"created"

! run a parallel loop to create plots
!$OMP DO SCHEDULE (DYNAMIC)
do i=0,ntime
  write (ch,'(i4.4)') i
  fileps=ch-".ps"                        ! PostScript output
  lon=lonmin+(lonmax-lonmin)*i/ntime
  lat=latmin+(latmax-latmin)*i/ntime
  print *,"i,it ="+i+it
  title='"'-i+'of'+ntime-'"'
  cmd="pscoast"+"-JG"-lon-"/"-lat-"/10c -R-0/360/-90/90 -Bxg30 -Byg15 -B+t"-title &
     +"-D"-resolution+"-Gsandybrown -Slightskyblue -P -K ->"-fileps
  print *,trim(cmd)
!$OMP CRITICAL
  call sGMT(API,cmd)                     ! segfaults when running pscoast in parallel
!$OMP END CRITICAL
  call sGMT(API,"psxy"+fileline+"-J -R -W1p,blue -O -K ->>"-fileps)
  call sGMT(API,"psxy"+fileline+"-J -R -Gyellow -Sc7p -W1p,blue -O -K ->>"-fileps)
  call sGMT(API,"pstext"+filetext+"-J -R -D0.25c/-0.4c -O ->>"-fileps)

  if (makeJPG) then                      ! convert PostScript to bitmaps
!$OMP CRITICAL
  call sGMT(API,"ps2raster"+fileps+"-P") ! errorneous results when running ps2raster in parallel
!$OMP END CRITICAL
  endif
enddo

! destroy API sessions
  call sGMT_Destroy_Session(API)
  print *,"session"+it+"destroyed"

!$OMP END PARALLEL

end program
