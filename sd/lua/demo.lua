-- ezLCD-4xxx Demo 11/01/20 for 640x480 Screen
--
function TouchGo()
	pressed = false -- set pressed to false
	::start::
	if not pressed then
		goto start	-- loop until pressed set to true but button event.accuracy
	else pressed = false
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
	x = 159
	for clr = 0,255,1 do	 -- increment color intensity
		ez.SetColor(ez.RGB(clr,0,0))
		ez.SetXY(x,0) 	-- increment (y)screen line position 
		ez.VLine(480)	-- draw line height of screen
		x = x + 1
		ez.SetXY(x,0) 	-- increment (y)screen line position 
		ez.VLine(480)	-- draw line height of screen
		x = x + 1
	end
end
function GreenGradient()
	ez.Cls(ez.RGB(0,0,0))
	x = 159
	for clr = 0,255,1 do	 -- increment color intensity
		ez.SetColor(ez.RGB(0,clr,0))
		ez.SetXY(x,0) 	-- increment (y)screen line position 
		ez.VLine(480)	-- draw line height of screen
		x = x + 1
		ez.SetXY(x,0) 	-- increment (y)screen line position 
		ez.VLine(480)	-- draw line height of screen
		x = x + 1
	end
end
function BlueGradient()
	ez.Cls(ez.RGB(0,0,0))
	x = 159
	for clr = 0,255,1 do	 -- increment color intensity
		ez.SetColor(ez.RGB(0,0,clr))
		ez.SetXY(x,0) 	-- increment (y)screen line position 
		ez.VLine(480)	-- draw line height of screen
		x = x + 1
		ez.SetXY(x,0) 	-- increment (y)screen line position 
		ez.VLine(480)	-- draw line height of screen
		x = x + 1
	end
end



ez.Cls(ez.RGB(0,0,128)) -- set medium color blue
ez.SetXY(0,200) -- set position for button status to print
--
--Create Whole Screen Invisible Button ID 0 [ez.Width] x [ez.Height] in UP state (1) 
--ID,State,iconUp,iconDown,iconDisab,x,y,width,height)
ez.Button(0,1,-1,-1,-1,0,0,ez.Width,ez.Height)	-- set up button
ez.SetButtonEvent("ButtonHandler")	-- call the button function (above)
--[[
-- Font issues? Comment all font commands out and ezLCD will use internal font!
-- Use scalable FreeType Font 0 in 28 point size
  ]]
ez.SetFtFont(3,18,0)           --before enabling be sure font set in config.txt
--
ez.SetColor(ez.RGB(255,215,0))  -- YELLOW
ez.SetXY(0,120)
print("           ezLCD-5xx Demo Program")
print(" ")
print("Touch Screen to Step Through Demo")
TouchGo()	-- wait till screen touched to proceed

ez.Cls(0)
ez.SetXY(100,100)
ez.PutPictFile(0,0,"/Images/Start.jpg")
TouchGo()

ez.Cls(0)
ez.SetXY(40,10)
ez.PutPictFile(0,0,"/Images/bwimage320.jpg")
TouchGo()

ez.Cls(0)
ez.SetXY(0,0)
ez.PutPictFile(0,0,"/Images/car320.jpg")
TouchGo()

ez.Cls(ez.RGB(255,0,0)) -- red screen
ez.SetColor(ez.RGB(0,255,0))
ez.SetXY(0,120)
print("                  RED")
TouchGo()

ez.Cls(ez.RGB(0,255,0)) -- green screen
ez.SetColor(ez.RGB(255,0,0))
ez.SetXY(0,120)
print("                  GREEN")
TouchGo()

ez.Cls(ez.RGB(0,0,255)) -- blue screen
ez.SetColor(ez.RGB(0,255,0))
ez.SetXY(0,120)
print("                  BLUE")
TouchGo()

ez.Cls(ez.RGB(0,0,0))   -- black screen
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(0,120)
print("                  BLACK")
TouchGo()

ez.Cls(ez.RGB(255,255,255)) -- white screen
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(0,120)
print("                  WHITE")

RedGradient()
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(0,120)
print("                  RedGradient")
TouchGo()

GreenGradient()
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(0,120)
print("                  GreenGradient")
TouchGo()

BlueGradient()
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(0,120)
print("                  BlueGradient")
TouchGo()

ez.Cls(0)
ez.SetXY(100,100)
ez.PutPictFile(0,0,"/Images/RedClosed.jpg")

ez.DelButtons()
