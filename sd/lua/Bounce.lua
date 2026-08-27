-- ezLCD Bounce.lua 12/26/2020
-- rx=math.random(Xmax)
-- ry=math.random(Ymax)

  i={1,2,3,4,5,6,7,8,9,0}

function TouchGo()
  pressed = false  -- set pressed to false
  ::start::        --   <---------------------------------------------------------+
  if not pressed then    --                                                       +
    goto start	   -- loop until pressed set to true but button event.accuracy ---+
    else pressed = false
  end
end

function ButtonHandler(id,state)
  -- print("data -", id," ", state, "pressed",pressed) -- print id and state for diagn.
  -- print("\r\n")
  if (state==2)    -- check for the button is in the down state
    then pressed = true
  end
end


::main::
ez.Wait_ms(2500)      -- Allow System to stabalize

ez.Cls(ez.RGB(0,0,128)) -- set BACKGROUND to medium brightness BLUE
ez.SetFtFont(0,60,60)   -- before enabling be sure font is set in config.txt

-- Create Whole Screen Invisible Button ID 0,  in UP state (1) 
-- ID,State,iconUp,iconDown,iconDisab,x,y,width,height)
Xmax = ez.Width         -- Get Screen Size
Ymax = ez.Height        -- 
ez.Button(0,1,-1,-1,-1,0,0,Xmax,Ymax)	-- Set up button
pressed = false                  -- pressed is the button flag (true == DOWN)
ez.SetButtonEvent("ButtonHandler")	-- Call the button function (above)
--

ez.SetPenSize(10,10)   -- ez.SetPenSize(height, width)

CircleRadius = 40

xLeft = CircleRadius *2
xRight = Xmax - CircleRadius *2
yTop = CircleRadius *2
yBottom = Ymax - CircleRadius *2

-- Initialize these variables before the loop
xPosition = xLeft  -- Start on the Left Edge
xIncrement = CircleRadius  -- Start with a Positive Increment
yPosition = yTop   -- Start at the Top Edge
yIncrement = CircleRadius  -- Start with a Positive Increment

-- for i=1, 500
while (pressed == false) do
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

ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(180,190)
print(Xmax.. " X ".. Ymax)
--ez.SetXY(180,10)
--print(xIncrement.. " X ".. yIncrement)

print(string.format("     %d %d %d %d %d %d %d %d %d %d", i[1],i[2],i[3],i[4],i[5],i[6],i[7],i[8],i[9],i[10]))


