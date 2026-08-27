-- ezLCD-5x showall.lua modified to exercise ezLCD-5035-MA
--
function TouchGo()	-- wait till screen touched to proceed
pressed = false -- set pressed to false
::start::
if not pressed then
goto start	-- loop until pressed set to true but button event.accuracy
else pressed = false
end
--ez.Wait_ms(5000)
end
function ButtonHandler(id,state)
--print("data -", id," ", state, "pressed",pressed) --print id and state for diagn.
--print("\r\n")
if (id == 1)
then touchMain = false
elseif id == 2
then ez.CalTouch() os.exit()
end

if (state==2)  -- check for button released
then pressed = true 
end
end
function showfont(fn,t) -- function to show sample font example fn is font number t is font name
ez.Cls(ez.RGB(0,0,0))
ez.SetColor(ez.RGB(255,255,255))
ez.SetFtFont(1,14,0)
print("                1000's of Scalable Fonts")
print("         OpenType - TrueType Compatible")
ez.SetFtFont(fn,16,0)
print()
print(t)
print()
print(" 0123456789")
print(" ABCDEFGHIJKLMNOPQRSTUVWXYZ")
print(" abcdefghijklmnopqrstuvwxyz")
print(" The quick way to a touchscreen") 
print(" product is ezLCD!")
ez.SetFtFont(fn,44,0)
print("ABCDefgh")
ez.Wait_ms(2500)
end

function RedGradient()
ez.Cls(ez.RGB(0,0,0))
x = 0
	for clr = 0,255,1 do	 -- increment color intensity
	ez.SetColor(ez.RGB(clr,0,0))
	ez.SetXY(x,0) 	-- increment (y)screen line position 
	ez.VLine(ez.Height)	-- draw line height of screen
	x = x + 1
	ez.SetXY(x,0) 	-- increment (y)screen line position 
	ez.VLine(ez.Height)	-- draw line height of screen
	x = x + 1
	end
end

function GreenGradient()
ez.Cls(ez.RGB(0,0,0))
x = 0
	for clr = 0,255,1 do	 -- increment color intensity
	ez.SetColor(ez.RGB(0,clr,0))
	ez.SetXY(x,0) 	-- increment (y)screen line position 
	ez.VLine(ez.Height)	-- draw line height of screen
	x = x + 1
	ez.SetXY(x,0) 	-- increment (y)screen line position 
	ez.VLine(ez.Height)	-- draw line height of screen
	x = x + 1
	end
end

function BlueGradient()
ez.Cls(ez.RGB(0,0,0))
x = 0
	for clr = 0,255,1 do	 -- increment color intensity
	ez.SetColor(ez.RGB(0,0,clr))
	ez.SetXY(x,0) 	-- increment (y)screen line position 
	ez.VLine(ez.Height)	-- draw line height of screen
	x = x + 1
	ez.SetXY(x,0) 	-- increment (y)screen line position 
	ez.VLine(ez.Height)	-- draw line height of screen
	x = x + 1
	end 
end

function Bounce()
ez.Cls(ez.RGB(0,0,128)) -- set BACKGROUND to medium brightness BLUE
ez.SetPenSize(10,10)   -- ez.SetPenSize(height, width)
CircleRadius = 40
Xmax = ez.Width         -- Get Screen Size
Ymax = ez.Height        -- 

xLeft = CircleRadius *2
xRight = Xmax - CircleRadius *2
yTop = CircleRadius *2
yBottom = Ymax - CircleRadius *2

-- Initialize these variables before the loop
xPosition = xLeft  -- Start on the Left Edge
xIncrement = CircleRadius  -- Start with a Positive Increment
yPosition = yTop   -- Start at the Top Edge
yIncrement = CircleRadius  -- Start with a Positive Increment

for i=1, 100
 do
    if (yPosition > yBottom) or (yPosition < yTop) then  -- Reverse Direction
	  yIncrement = (yIncrement * -1)	          -- Change the Sign of Increment
	end
	yPosition = (yPosition + yIncrement)          -- Move by the Perscribed Increment
	
	if (xPosition > xRight) or (xPosition < xLeft) then  -- Reverse Direction
	  xIncrement = (xIncrement * -1)	          -- Change the Sign of Increment
	end
	xPosition = (xPosition + xIncrement)          -- Move by the Perscribed Increment
	
	-- ez.Circle(x, y, CircleRadius, ez.RGB(255,0,0))    -- Color doesn't work
	c = ez.RGB(255,215,0)  ez.SetColor(c) -- Gold
	ez.Circle(xPosition, yPosition, CircleRadius)        -- Draw Circle
    ez.Wait_ms(50)										 -- Delay between movements

	ez.SetColor(ez.RGB(0,0,128))        -- Same as Background
	ez.Circle(xPosition, yPosition, CircleRadius)        -- Erase Circle
    --    ez.Wait_ms(10)

	-- if pressed then break  end
   end
end

-- Main
-- while 1 do -- run main forever!
ez.Cls(ez.RGB(0,0,0)) -- set screen to black
touchMain = true

ez.Button(1,1,-1,-1,-1,0,0,(ez.Width // 2),ez.Height)
ez.Button(2,1,-1,-1,-1,(ez.Width // 2) + 1,0,(ez.Width // 2),ez.Height)


ez.SetColor(ez.RGB(100,100,100)) -- set color to grey
	ez.SetXY(0,0)
	ez.BoxFill((ez.Width // 2), ez.Height)
ez.SetXY(10,(ez.Height // 2))
ez.SetColor(ez.RGB(255,255,255)) -- set color to white
print("Press to ")
print ("  Run Test")

ez.SetXY((ez.Width //2) + 5,(ez.Height // 2))
print("Press to Calibrate")
ez.SetXY((ez.Width //2) + 5,(ez.Height // 2) + 10)
print ("Touch Screen")
ez.SetButtonEvent("ButtonHandler")

while touchMain do

end
ez.DelButtons()

Bounce()
ez.LightBright(255)
ez.Cls(ez.RGB(0,0,128)) -- set medium color blue
ez.SetXY(0,100) -- set position for button status to print
--
--Create Whole Screen Invisible Button ID 0 320x240 in UP state (1) 
--ID,State,iconUp,iconDown,iconDisab,x,y,width,height)
ez.Button(0,1,-1,-1,-1,0,0,320,240)	-- set up button
ez.SetButtonEvent("ButtonHandler")	-- call the button function (above)
--
-- Font issues? Comment all font commands out and ezLCD will use internal font!
-- Use scalable FreeType Font 0 in 28 point size
-- MA ez.SetFtFont(17,28,28) --before enabling be sure font set in config.txt
--
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(0,10)
print("          ezLCD-5x Test Program")
print("      ")
print("    Touch Screen to Step Through Demo")
print("")
-- print("Size of Screen - ",ez.Width, "x", ez.Height)
--tg = False -- if this line is in the demo will run automatically, take comment out prompt for touch
--
TouchGo()	-- wait till screen touched to proceed

ez.Cls(0,0,0)
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(10,10)
--print("Test Image")
--TouchGo()	-- wait till screen touched to proceed
ez.SetXY(10,0)
ez.PutPictNo(7)
TouchGo()	-- wait till screen touched to proceed

ez.Cls(ez.RGB(255,255,255)) -- WHITE screen
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(10,10)
print("Backlite Brightness Test")
ez.Wait_ms(1000)
for clr = 255,0,-2 do	    -- Decrement LCD Brightness
	ez.LightBright(clr)
	ez.Wait_ms(20)
end
ez.LightBright(255)
ez.Wait_ms(1000)

ez.SetXY(10,60)
print("Touch Screen to Proceed")
TouchGo()	-- wait till screen touched to proceed

ez.Cls(0,0,0)
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(10,10)
print("Colors & Gradients")

TouchGo()	-- wait till screen touched to proceed
ez.Cls(ez.RGB(0,0,0))       -- black screen 
ez.SetXY(10,10)
print ("BLACK")

TouchGo()	-- wait till screen touched to proceed
ez.Cls(ez.RGB(255,0,0))     -- red screen
ez.SetXY(10,10)
print ("RED")

TouchGo()	-- wait till screen touched to proceed	
ez.Cls(ez.RGB(0,255,0))     -- green screen
ez.SetXY(10,10)
print ("GREEN")

TouchGo()	-- wait till screen touched to proceed
ez.Cls(ez.RGB(0,0,255))     -- blue screen
ez.SetXY(10,10)
print ("BLUE")

TouchGo()	-- wait till screen touched to proceed
ez.Cls(ez.RGB(255,255,255)) -- white screen
ez.SetXY(10,10)
print ("WHITE")

TouchGo()	-- wait till screen touched to proceed
RedGradient()
ez.SetXY(10,10)
print ("RED")

TouchGo()	-- wait till screen touched to proceed
GreenGradient()
ez.SetXY(10,10)
print ("GREEN")

TouchGo()	-- wait till screen touched to proceed
BlueGradient()
ez.SetXY(10,10)
print ("BLUE")

TouchGo()	-- wait till screen touched to proceed
ez.Cls(ez.RGB(255,255,255)) -- white screen
print (" ")
print("      Touch screen to delete file")

TouchGo()	-- wait till screen touched to proceed
os.rename("autoexec.lua","usertest.lua")
ez.Cls(ez.RGB(255,255,255)) -- white screen
print (" ")
print("         FACTORY TEST COMPLETED")
print (" ")
print("   autoexec.lua renamed to usertest.lua")
