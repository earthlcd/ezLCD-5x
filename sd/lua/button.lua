-- ezButton Example 10/15/20
--[[ config.txt file must contain below and have button images in /Images/ directory
[Images]
0 = /Images/RedClosed.jpg
1 = /Images/GreenOpen.jpg
]]--

-- The function below is called on a button event whether pressed or released
function ButtonHandler(id, state)
  pressed = true -- flag to tell when a button is pressed
  ez.Button(id, state) -- returns the button id & state
  print("data -", id, state) --print id and state for diagn.
  print("\r\n")
end

-- Main routine ------
ez.Cls(ez.RGB(255,255,255)) -- clear screen to white
ez.SetColor(ez.RGB(0,0,0)) -- set text color to black
ez.SetXY(0,200) -- set position for button status to print
--configure pin 0 as output for blinking LED H later
ez.SetPinOut(0,0) -- Set Pin 0 to output push pull
pressed = false -- set flag to false for a button press
--[[ (Below) Create Button ID 0 in the UP state (1) using 
  image 0 in the USER ROM for the UP image and
  image 1 for the DOWN image at screen location (100,100)
  this example uses buttons labled 'Closed' and 'Open' resepectively 
  DisabledImage (-1)=none,X location, Y Location)
  ez.Button(ID,UpImage,DownImage,Initial State (0=Up,1=Down)
--]]  
ez.Button(0,1,0,1,-1,100,100)	-- set up button
-- ez.Button(0,1)	-- enable button 0 (Closed) to up state and Image 1
ez.SetButtonEvent("ButtonHandler")	-- call the button function (above)
for i = 1,50,1 do -- loop 60 seconds or until button=true
  -- print ("in the loop") -- diagnostic to show we are in the loop
  -- Blink LED H to show we are still in the loop
  ez.Pin(0,0) -- Set Pin 0 low (0) led on dash 250 ms
  ez.Wait_ms(250)
  --space
  ez.Pin(0,1) -- Set Pin 0 high (1) led off space 250 ms
  ez.Wait_ms(250)
end
ez.Cls(ez.RGB(0,255,0)) --clear screen to green
print("Done") -- diagnostic to see flow is out of the loop
