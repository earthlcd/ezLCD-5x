-- Relay I/O Example  (Updated 05/04/2022)
-- Runs through I/O pins first seting them to outputs
-- Then turning them ON one at a time
-- Then turning them OFF one at a time
::Start::
    ez.Cls(ez.RGB(255,255,255)) -- Set Screen (background) to White
    ez.SetColor(ez.RGB(0,0,0))  -- Set Drawing Color (foreground) to Black
-- Will print with the built in font since no font is selected
    ez.SetXY(10,100)-- Set X, Y start location  
    print (" Turns ON I/O 1 - 8 one at a time")
    ez.SetXY(10,120)-- Set X, Y start location  
    print (" then turns them OFF again.")
   FirstIOpin = 1    LastIOpin = 8    DelayMS = 250
   ez.Cls(ez.RGB(0,255,0)) -- Set Screen (background) to Green
   ez.Wait_ms(500)
--configure Pin 1 to 8 as push pull output
-- ez.SetPinOut(PinNo, OpenDrain, PullUp, PullDn, Speed)
-- Default = Push-Pull mode   	 Default = pullup disabled	Default = pulldown disabled	Default = Very High (3)
   for p = FirstIOpin, LastIOpin, 1 do
     ez.SetPinOut(p,0)     ez.Pin(p,1)
	 print (" Pin", p, " as OUTPUT - ", ez.Pin(p))     ez.Wait_ms(50)
   end
   ez.Wait_ms(DelayMS)	print ("")
-- ez.Pin(PinNo, Value)   0 = low   >0 = high
-- Set Pin low (0) led ON
   for p = FirstIOpin, LastIOpin, 1 do
     ez.Pin(p,0)
     print (" Pin", p, " ON - ", ez.Pin(p))
     ez.Wait_ms(DelayMS)
   end
   ez.Wait_ms(500)	print ("")
-- ez.Pin(PinNo, Value)   0 = low   >0 = high
-- Set Pin high (0) led OFF
   for p = LastIOpin, FirstIOpin, -1 do
--    for p = 1, 8, 1 do
     ez.Pin(p,1)
     print (" Pin", p, " OFF - ", ez.Pin(p))
     ez.Wait_ms(DelayMS)
   end
      print ("")   print (" DONE")
   ez.Wait_ms(1000)	print ("")
goto Start
-- Once RUNNING, You must press the RESET button to escape
