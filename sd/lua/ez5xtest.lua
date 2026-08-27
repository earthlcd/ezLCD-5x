-- ezLCD-5xxx Demo 11/01/20 for Software API Sized Screen
-- Demonstration the following features of the ezLCD:
--   - Touch Screen
--   - Displaying images
--   - Controlling backlight brightness
--   - Clearing the screen
--   - Drawing a gradients with ezVLine

function TouchGo()
	pressed = false -- set pressed to false
	::start::
	if not pressed then
		goto start	-- loop until pressed set to true but button event.accuracy
	else
		pressed = false
	end
end
function ButtonHandler(id,state)
	--print("data -", id," ", state, "pressed",pressed) --print id and state for diagn.
	--print("\r\n")
	if (state==2)  -- check for button released
	then pressed = true
	end
end
function RedGradient()
	ez.Cls(ez.RGB(0,0,0))
	for x = 0,ez.Width-1,1 do	 -- increment color intensity
		ez.SetColor(ez.RGB(math.floor(x/(ez.Width-1)*255),0,0))
		ez.SetXY(x,0) 	-- increment (y)screen line position 
		ez.VLine(ez.Height)	-- draw line height of screen
	end
end
function GreenGradient()
	ez.Cls(ez.RGB(0,0,0))
	for x = 0,ez.Width-1,1 do	 -- increment color intensity
		ez.SetColor(ez.RGB(0,math.floor(x/(ez.Width-1)*255),0))
		ez.SetXY(x,0) 	-- increment (y)screen line position 
		ez.VLine(ez.Height)	-- draw line height of screen
	end
end
function BlueGradient()
	ez.Cls(ez.RGB(0,0,0))
	for x = 0,ez.Width-1,1 do	 -- increment color intensity
		ez.SetColor(ez.RGB(0,0,math.floor(x/(ez.Width-1)*255)))
		ez.SetXY(x,0) 	-- increment (y)screen line position 
		ez.VLine(ez.Height)	-- draw line height of screen
	end
end

-- Start of Main
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
--ez.SetFtFont(0,28,28)--before enabling be sure font set in config.txt
--
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(0,10)
print("Lua ezLCD-5xxx Demo Program")
print("")
print("Touch Screen to Step Through Demo")
print("")
print("Size of Screen - ",ez.Width, "x", ez.Height)
while 1 do
TouchGo()	-- wait till screen touched to proceed
ez.Cls(0,0,0)
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(0,10)
print("Test Image")
TouchGo()
ez.PutPictFile(0,0,"/Images/EarthLCD_320x240_Splash.jpg")
TouchGo()
ez.Cls(0,0,0)
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(0,10)
print("Backlite Brightness")
ez.SetXY(0,0)
TouchGo()
ez.Cls(ez.RGB(255,255,255)) -- white screen
for clr = 0,255,10 do	 -- increment color intensity
	ez.LightBright(clr)
	ez.Wait_ms(250)
end
TouchGo()
ez.Cls(ez.RGB(255,255,255)) -- white screen
TouchGo()
ez.Cls(ez.RGB(0,0,0)) -- black screen 
TouchGo()
ez.Cls(ez.RGB(255,0,0)) -- red screen
TouchGo()	
ez.Cls(ez.RGB(0,255,0)) -- green screen
TouchGo()
ez.Cls(ez.RGB(0,0,255)) -- blue screen
TouchGo()
RedGradient()
TouchGo()
GreenGradient()
TouchGo()
BlueGradient()
TouchGo()
end
ez.Cls(ez.RGB(0,0,0))
ez.PutPictFile(0,0, "/Images/EarthLCD_640x480_Splash.jpg")
ez.DelButtons()

