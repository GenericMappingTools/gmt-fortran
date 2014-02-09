nx=200
ny=120
a=2.
b=1.
xmin=-2. ; xmax=2.
ymin=-1.2 ; ymax=1.2
do ix=0,nx
	x=xmin+(xmax-xmin)*ix/nx
	do iy=0,ny
		y=ymin+(ymax-ymin)*iy/ny
		print '(4f10.5)',x,y,a*x**2+b*y**2,-(a*x**2+b*y**2)
	enddo
! print * ! for gnuplot
enddo
end
