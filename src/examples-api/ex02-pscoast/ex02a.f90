! $Id$
! ----------------------------------------------------------------------
! Test of GMT API
! modules pscoast, psxy, pstext and ps2raster
! GMT API functions GMT_Create_Session, GMT_Call_Module and GMT_Destroy_Session
! ----------------------------------------------------------------------

program ex02a
use gmt
implicit none
character(16) filedat,filetxt,fileps
character(20) module
character(100) args

filedat="ex02-line.dat"
filetxt="ex02-text.dat"
fileps ="ex02.ps"

! create GMT session
print *,"Create_Session: ",GMT_Create_Default_Session("Test")

! call pscoast
module="pscoast"
args="-JG-100/50/10c -R0/360/-90/90 -Bxg30 -Byg15 -Dl -Gsandybrown -Slightskyblue -P -K ->"//trim(fileps)
print *,"Call_Module: ",trim(module),GMT_Call_Module(module=module,args=args)

! call psxy for lines
module="psxy"
args=trim(filedat)//" -J -R -W1p,blue -O -K ->>"//trim(fileps)
print *,"Call_Module: ",trim(module),GMT_Call_Module(module=module,args=args)

! call psxy for points
module="psxy"
args=trim(filedat)//" -J -R -Gyellow -Sc7p -W1p,blue -O -K ->>"//trim(fileps)
print *,"Call_Module: ",trim(module),GMT_Call_Module(module=module,args=args)

! call pstext
module="pstext"
args=trim(filetxt)//" -J -R -D0.25c/-0.4c -O ->>"//trim(fileps)
print *,"Call_Module: ",trim(module),GMT_Call_Module(module=module,args=args)

! call ps2raster
module="ps2raster"
args=trim(fileps)//" -Tg"
print *,"Call_Module: ",trim(module),GMT_Call_Module(module=module,args=args)

! clean up
print *,"Destroy_Session: ",GMT_Destroy_Session()
end program
