-- Clock Rotory Test Script 
--v1.00  10/04/22  -Peter Fitzpatrick

--Pins:
--A(CLK)- User2 / Pin 20 (I2S_MCK)
--B (DT)- User2 / Pin 26 (GPIO6)			-- This pin is NOT an Interupt Input
--  SW - User2 / Pin 8  (GPIO1)			-- This pin is an Interupt Input
--  V+ - +3.3v (take from RTC Batt Sel)
-- GND - GND

--goal: have a clock that can be set via rotary

--bugs: cant get off ground. maybe its a hardware thing

--os.clock() - returns runtime of system in seconds


ez.Wait_ms(50)

leave = false
virgin=true
textSize = 12
clockSize = 48
selection = 1
hours = 00
minutes = 00
seconds = 00
QuadValue = 0
OldQuadValue = 0
delQuad = QuadValue - OldQuadValue
hrsX = ez.Width // 6		--the X for the hours
minX = ez.Width * 5 // 12	--the X for the minutes
secX = ez.Width * 2 // 3	--the X for the seconds
cloX = ez.Width // 2        --the X for the clock
cloY = ez.Height // 2		--the height for our clock
radius = ez.Height // 2 * 0.8
--sysTimeOld = 0 -- the previous systime check value
--sysTime = 0 --the time the system has been running
currTime = (hours * 3600) + (minutes * 60) + seconds --our time formula for copypasta

function lineAng(x,y,theta,r,color)
	ez.Line(x,y,math.floor(x+r*math.cos(theta)+0.5),math.floor(y-r*math.sin(theta)+0.5),color)
end	

function showClock (timeIn) --displays current clock
	clockSize=0
	ez.CircleFill(cloX,cloY,radius*0.9,0x000000)
	ez.SetFtFont(1, clockSize, 0)
	ez.SetXY(hrsX , cloY)
	print (os.date("%X", timeIn))
	if virgin then
		ez.Cls(ez.RGB(0,0,0))
		ez.Circle(cloX,cloY,radius,0xffffff)
		ez.Line(cloX,cloY,cloX,cloY-radius,0xffffff)
		ez.Line(cloX,cloY,cloX+radius//2,cloY-radius*math.sqrt(3)//2,0xffffff)
		ez.Line(cloX,cloY,cloX+radius*math.sqrt(3)//2,cloY-radius//2,0xffffff)
		ez.Line(cloX,cloY,cloX+radius,cloY,0xffffff)
		ez.Line(cloX,cloY,cloX+radius*math.sqrt(3)//2,cloY+radius//2,0xffffff)
		ez.Line(cloX,cloY,cloX+radius//2,cloY+radius*math.sqrt(3)//2,0xffffff)
		ez.Line(cloX,cloY,cloX,cloY+radius,0xffffff)
		ez.Line(cloX,cloY,cloX-radius//2,cloY+radius*math.sqrt(3)//2,0xffffff)
		ez.Line(cloX,cloY,cloX-radius*math.sqrt(3)//2,cloY+radius//2,0xffffff)
		ez.Line(cloX,cloY,cloX-radius,cloY,0xffffff)
		ez.Line(cloX,cloY,cloX-radius*math.sqrt(3)//2,cloY-radius//2,0xffffff)
		ez.Line(cloX,cloY,cloX-radius//2,cloY-radius*math.sqrt(3)//2,0xffffff)
		ez.CircleFill(cloX,cloY,radius-10,0x000000)
		virgin = false
	end
	hhand=(os.date("%I", timeIn))+(os.date("%M", timeIn))/60
	hhandth=(-1*(hhand*2*math.pi/12))+(math.pi/2)
	mhand=(os.date("%M", timeIn))+(os.date("%S", timeIn))/60
	mhandth=(-1*(mhand*2*math.pi/60))+(math.pi/2)
	lineAng(cloX,cloY,hhandth,(radius*0.9)//3,0xffffff)
	lineAng(cloX,cloY,mhandth,(radius*0.9)//2,0xffffff)
end

function setTime () --sets the clock
	
	ez.Cls(ez.RGB(0,0,0))
	selection = 0
	while (selection <= 6) do
		--ez.Cls(ez.RGB(0,75,0))
		ez.SetXY(0,0)
		ez.SetFtFont(1, textSize, 0)
		print("Please set the time.")
		ez.SetFtFont(1, clockSize, 0)
		
		if selection == 1 or selection == 2 then ez.SetColor (ez.RGB(255,0,0)) end -- sets the selected entry red 
		ez.SetXY(hrsX, cloY)
		print(string.format("%02d", hours) .. ":")
	
		ez.SetColor (ez.RGB(255,255,255))
		if selection == 3 or selection == 4 then ez.SetColor (ez.RGB(255,0,0)) end -- sets the selected entry red 
	
		ez.SetXY(minX, cloY)
		print(string.format("%02d", minutes) .. ":")
	
		ez.SetColor (ez.RGB(255,255,255))
		if selection == 5 or selection == 6 then ez.SetColor (ez.RGB(255,0,0)) end -- sets the selected entry red 
	
		ez.SetXY(secX, cloY)
		print(string.format("%02d", seconds))
	
		ez.SetColor (ez.RGB(255,255,255))
	
		delQuad = QuadValue - OldQuadValue
		if (QuadValue ~= OldQuadValue) then --checks for change in rotary
			
			if ((delQuad < 0) or (delQuad == 16)) then
				ez.SetColor (ez.RGB(0,0,0))
				if selection <= 2 then
					ez.SetXY(hrsX, cloY)
					print(string.format("%02d", hours) .. ":")
					hours = hours + 1
					if hours == 24 then hours = 0 end
					
				elseif selection <= 4 then
					ez.SetXY(minX, cloY)
					print(string.format("%02d", minutes) .. ":")
					minutes = minutes + 1
					if minutes == 60 then minutes = 0 end
					
				elseif selection <= 6 then
					ez.SetXY(secX, cloY)
					print(string.format("%02d", seconds))
					seconds = seconds + 1
					if seconds == 60 then seconds = 0 end 
					
				end
				ez.SetColor (ez.RGB(255,255,255))
				--ez.Cls(ez.RGB(0,0,0))
			end
			
			if ((delQuad > 0) or (delQuad == -16)) then
				ez.SetColor (ez.RGB(0,0,0))
				if selection <= 2 then
					ez.SetXY(hrsX, cloY)
					print(string.format("%02d", hours) .. ":")
					hours = hours - 1
					if hours == -1 then hours = 23 end
				elseif selection <= 4 then
					ez.SetXY(minX, cloY)
					print(string.format("%02d", minutes) .. ":")
					minutes = minutes - 1
					if minutes == -1 then minutes = 59 end
				elseif selection <= 6 then
					ez.SetXY(secX, cloY)
					print(string.format("%02d", seconds))
					seconds = seconds - 1
					if seconds == -1 then seconds = 59 end 
				end
				--ez.Cls(ez.RGB(0,0,0))
			end
			
		end
		OldQuadValue = QuadValue
		end
		currTime = (hours * 3600) + (minutes * 60) + seconds
	end



function QuadInterrupt(value) --reads the rotary input
  QuadValue = value
end

function ButtonInterrupt(value) --reads the button input
   if selection < 7 then
   selection = selection +1
   --selection = selection - 0.5
   else 
   --selection = 1
   end
  -- ez.Cls(ez.RGB(75,75,75))
end
                
ez.SetPinIntr(1, "ButtonInterrupt",1)		-- ez.SetPinIntr(GPIO Pin to use, "Name of ISR Function")
ez.QuadOpen("QuadInterrupt",16)			-- ez.QuadOpen("Name of ISR Function", Max Count before Rollover)

ez.Cls(ez.RGB(0,0,0))
ez.SetColor(ez.RGB(255,255,255))


setTime()
sysTime = os.clock()
bench = os.clock()
currTime = currTime - bench
while (0) do
 
 if sysTime ~= sysTimeOld then
 showClock(currTime + sysTime)
 end
 sysTimeOld = sysTime
 sysTime = os.clock()
end
print("end")

