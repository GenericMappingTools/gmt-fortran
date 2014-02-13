! $Id$
! ----------------------------------------------------------------------
! Test of GMT API
! modules psbasemap, pscoast, grdcontour and ps2raster
! GMT API functions GMT_Create_Session, GMT_Call_Module and GMT_Destroy_Session
! ----------------------------------------------------------------------

program example_01
   use iso_c_binding
   use gmt
   implicit none

   ! GMT related declarations
   type(c_ptr) :: API=c_null_ptr
   character(len=16, kind=c_char) :: filename
   character(len=200, kind=c_char) :: args
   integer(kind=c_int) :: ierr

   ! create GMT session
   API = GMT_Create_Session("example_01"//c_null_char, 2, 0, 0)
   if ( .not. c_associated(API)) print *, 'Create GMT session failed!'

   ! call gmtset
   write(args, "(200(a,1x))") 'MAP_GRID_CROSS_SIZE_PRIMARY=0 &
                             & FONT_ANNOT_PRIMARY=10p'
   ierr = GMT_Call_Module(API, 'gmtset'//c_null_char, &
                          GMT_MODULE_CMD, args//c_null_char)
   if (ierr /= 0)  print *, 'Call_Module: ', 'gmtset', ierr

   ! call psbasemap
   write(args, "(200(a,1x))") '-R0/6.5/0/7.5 -Jx1i -B0 -P -K', '->ex01.ps'
   ierr = GMT_Call_Module(API, 'psbasemap'//c_null_char, &
                          GMT_MODULE_CMD, args//c_null_char)
   if (ierr /= 0) print *, 'Call_Module: ','psbasemap', ierr

   ! call pscoast
   write(args, "(200(a,1x))") '-Rg -JH0/6i -X0.25i -Y0.2i -O -K -Bg30 -Dc &
                             & -Glightbrown -Slightblue', '->>ex01.ps'
   ierr = GMT_Call_Module(API, 'pscoast'//c_null_char, &
                          GMT_MODULE_CMD, args//c_null_char)
   if (ierr /= 0) print *, 'Call_Module: ','pscoast', ierr

   ! call grdcontour
   filename = 'osu91a1f_16.nc'
   write(args, "(200(a,1x))") trim(filename), '-J -C10 -A50+f7p -Gd4i &
                            & -L-1000/-1 -Wcthinnest,- -Wathin,- -O -K &
                            & -T0.1i/0.02i', '->>ex01.ps'
   ierr = GMT_Call_Module(API, 'grdcontour'//c_null_char, &
                          GMT_MODULE_CMD, args//c_null_char)
   if (ierr /= 0) print *, 'Call_Module: ', 'grdcontour', ierr

   ! call grdcontour
   write(args, "(200(a,1x))") trim(filename), '-J -C10 -A50+f7p -Gd4i &
                            & -L-1/1000 -O -K -T0.1i/0.02i', '->>ex01.ps'

   ierr = GMT_Call_Module(API , 'grdcontour'//c_null_char, &
                          GMT_MODULE_CMD, args//c_null_char)
   if (ierr /= 0) print *, 'Call_Module: ', 'grdcontour', ierr

   ! call pscoast
   write(args, "(200(a,1x))") '-Rg -JH6i -Y3.4i -O -K -B+t"Low Order Geoid" &
                             & -Bg30 -Dc -Glightbrown -Slightblue', &
                              '->>ex01.ps'
   ierr = GMT_Call_Module(API, 'pscoast'//c_null_char, &
                          GMT_MODULE_CMD,args//c_null_char)
   if (ierr /= 0) print *, 'Call_Module: ', 'pscoast', ierr

   ! call grdcontour
   write(args, "(200(a,1x))") trim(filename), '-J -C10 -A50+f7p -Gd4i &
                            & -L-1000/-1 -Wcthinnest,- -Wathin,- -O -K &
                            & -T0.1i/0.02i:-+', '->>ex01.ps'
   ierr = GMT_Call_Module(API, 'grdcontour'//c_null_char, &
                          GMT_MODULE_CMD, args//c_null_char)
   if (ierr /= 0) print *, 'Call_Module: ', 'grdcontour', ierr

   ! call grdcontour
   write(args,"(200(a,1x))") trim(filename), '-J -C10 -A50+f7p -Gd4i &
                           & -L-1/1000 -O -T0.1i/0.02i:-+', '->>ex01.ps'
   ierr = GMT_Call_Module(API, 'grdcontour'//c_null_char, &
                          GMT_MODULE_CMD, args//c_null_char)
   if (ierr /= 0) print *, 'Call_Module: ', 'grdcontour', ierr

   ! call ps2raster
   ierr = GMT_Call_Module(API, 'ps2raster'//c_null_char, &
                          GMT_MODULE_CMD, 'ex01.ps -Tg'//c_null_char)
   if (ierr /= 0) print *, 'Call_Module: ','ps2raster', ierr

   ! clean up
   ierr = GMT_Destroy_Session(API)
   if (ierr /= 0) print *, 'Destroy_Session: ', ierr

   call execute_command_line('rm -f gmt.conf')
   call execute_command_line('rm -f gmt.history')
end program example_01
