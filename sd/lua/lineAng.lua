-- Draw a line of a given radius at x,y,radius
-- a // b: Floor division that rounds down the result towards -infinity
cloX = ez.Width // 2
cloY = ez.Height // 2
radius = ez.Height // 2 * 0.8

-- x,y: start postion
-- theta: angle in radians
-- r: radius of line out from x,y
-- color: color of the line
function lineAng(x,y,theta,radius,color)
	ez.Line(x,y,math.floor(x+radius*math.cos(theta)+0.5),math.floor(y-radius*math.sin(theta)+0.5),color)
end	

ez.Cls(ez.RGB(40, 40, 40))

hhand=2
hhandth=(-1*(hhand*math.pi//6))+(math.pi//2)

theta = 0
while theta < 2 * math.pi
do
	red = math.floor(255 * math.sin(theta))
	green = math.floor(255 * math.sin(theta + math.pi*2/3))
	blue = math.floor(255 * math.sin(theta + math.pi*4/3))

	lineAng(cloX/2,cloY,theta,radius//2,ez.RGB(255,255,255)) -- star 1
	lineAng(cloX + cloX/2,cloY,theta,radius//2,ez.RGB(255,255,255)) -- star 2
	lineAng(cloX,cloY,theta,radius-10,ez.RGB(red,green,blue)) -- color star
	theta = theta + 0.1
end
