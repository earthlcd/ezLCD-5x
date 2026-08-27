-- 10/11/20 Button Test NOT DONE NEEDS KEYPAD BITMAP GRAPHICS
-- Draws a bunch of buttons on the screen using the picture number
-- from config.txt.  Not ready for prime time. Although this program
--  works but clearly states in the comments that its not finished.

exit = false
-- Button Event function
function ProcessButtons(id, event)
  -- Display the image which corresponds to the event
  ez.Button(id, event)
  -- exit from lua if 0 pressed and released
  if (id == 0) and (event == 1) then
    exit = true
  end
end

ez.Cls(0xFFFFFF)
-- Define buttons 1-9
id = 1
x0 = 60
y0 = 10
for i = 1, 3, 1 do
  for n = 1, 3, 1 do
    ez.Button(id, 1, id, id+10, -1, (x0)+(n-1)*45, (y0)+(i-1)*45, 38, 38)
    id = id + 1
  end
end
-- Define button 0
ez.Button(0, 1, 0, 10, -1, (x0)+45, (y0)+3*45, 38, 38)

-- Start to receive button events
ez.SetButtonEvent("ProcessButtons")

-- Loop until 0 is pressed
while (not exit) do
end

-- Print message
ez.Cls(0xFFFFFF)
ez.SetColor(ez.RGB(0, 0, 150))
ez.SetXY(10, 10)
ez.SetFtFont(5, 40, 0)
print("Lua End")




