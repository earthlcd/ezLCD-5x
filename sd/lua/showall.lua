-- ezLCD-5x showall.lua combined demo programs to exercise ezLCD-5x
--
function TouchGo()
	--[[
	pressed = false -- set pressed to false
	::start::
	if not pressed then
	goto start	-- loop until pressed set to true but button event.accuracy
	else pressed = false
	end ]
	]]
	ez.Wait_ms(5000)
end
function ButtonHandler(id,state)
	--print("data -", id," ", state, "pressed",pressed) --print id and state for diagn.
	--print("\r\n")
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

	for i=1, 500
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
while 1 do
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
	ez.SetFtFont(1,22,22) --before enabling be sure font set in config.txt
	--
	ez.SetColor(ez.RGB(255,215,0))
	ez.SetXY(0,10)
	print("  ezLCD-5x Demo Program")
	print("       Written in Lua!")
	--print("Touch Screen to Step Through Demo")
	--print("")
	--print("Size of Screen - ",ez.Width, "x", ez.Height)
	tg = False -- if this line is in the demo will run automatically, take comment out prompt for touch
	--
	TouchGo()	-- wait till screen touched to proceed
	ez.Cls(0,0,0)
	ez.SetColor(ez.RGB(255,215,0))
	ez.SetXY(0,10)
	--print("Test Image")
	--TouchGo()
	ez.PutPictFile(0,0,"/Images/EarthLCD_320x240_Splash.jpg")
	TouchGo()
	ez.Cls(0,0,0)
	ez.SetColor(ez.RGB(255,215,0))
	ez.SetXY(0,10)
	print("Backlite Brightness")
	ez.SetXY(0,0)
	TouchGo()
	ez.Cls(ez.RGB(255,255,255)) -- white screen
	for clr = 0,255,20 do	 -- increment color intensity
		ez.LightBright(clr)
		ez.Wait_ms(250)
	end 
	TouchGo()
	ez.Cls(ez.RGB(0,0,0)) -- black screen 
	TouchGo()
	ez.Cls(ez.RGB(255,0,0)) -- red screen
	TouchGo()	
	ez.Cls(ez.RGB(0,255,0)) -- green screen
	TouchGo()
	ez.Cls(ez.RGB(0,0,255)) -- blue screen
	TouchGo()
	ez.Cls(ez.RGB(255,255,255)) -- white screen
	TouchGo()
	RedGradient()
	TouchGo()
	GreenGradient()
	TouchGo()
	BlueGradient()
	TouchGo()
	-- showfont.lua Shows fonts enabled in distribution config.txt
	---font numbers 1 4 6 11 14 17 25 28
	showfont(0,"Open Sans Regular") -- 
	showfont(1,"PTSeriBold")
	showfont(2,"Unispace Regular")
	showfont(3,"Steel fishRegular")
	showfont(4,"Comic Regular")
	showfont(5,"Garmond Regular")
	showfont(6,"Tahoma Bold")
	showfont(7,"Verdana Regular")

	---- gasguage.lua 
	ez.Cls(0,0,0)
	delay  = 100	-- set frame delay in milliseconds
	for loop = 1,5,1 -- show it a 10 times
	do
		for image = 0,29,1  -- Choose images 0-29 incremental by 1
		do
			filename = string.format("/gas/g-%d.jpg", image)
			ez.PutPictFile(0,0,filename) -- draw image n (can be bmp or jpg) jpg will be much faster
			ez.Wait_ms(delay)	-- delay display of next frame
		end
		for image = 29,0,-1  -- Choose images 0-29 decremental by 1
		do
			filename = string.format("/gas/g-%d.jpg", image)
			ez.PutPictFile(0,0,filename) -- draw image n (can be bmp or jpg) jpg will be much faster
			ez.Wait_ms(delay)	-- delay display of next frame
		end
	end
	--
	--
	delay = 10
	for loop = 1,5,1 -- show it a 10 times
	do
		for image = 0,29,1  -- Choose images 0-29 incremental by 1
		do
			filename = string.format("/gas/g-%d.jpg", image)
			ez.PutPictFile(0,0,filename) -- draw image n (can be bmp or jpg) jpg will be much faster
			ez.Wait_ms(delay)	-- delay display of next frame
		end
		for image = 29,0,-1  -- Choose images 0-29 decremental by 1
		do
			filename = string.format("/gas/g-%d.jpg", image)
			ez.PutPictFile(0,0,filename) -- draw image n (can be bmp or jpg) jpg will be much faster
			ez.Wait_ms(delay)	-- delay display of next frame
		end
	end
end
ez.Cls(ez.RGB(0,0,0))
ez.PutPictFile(0,0,"/Images/EarthLCD_640x480_Splash.jpg")
ez.DelButtons()

