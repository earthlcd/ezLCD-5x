-- Blink I/O Example  (Updated 04/14/2022)
-- Blinks LED on GPIO0(zero) Pin 0 which is D2 on the back right of EarthSOM

ez.Cls(ez.RGB(255,255,255)) -- Set Screen (background) to White
ez.SetColor(ez.RGB(0,0,0)) -- Set Drawing Color (foreground) to Black

-- Will print with the built in font since no font is selected
ez.SetXY(10,100)-- Set X, Y start location  
print (" LED H on the back of the ezLCD")
ez.SetXY(10,120)-- Set X, Y start location  
print (" will blink twice a second.")

::Start::
--configure pin 0 as output
ez.SetPinOut(0,0) -- Set Pin 0 to output push pull
-- dash
ez.Pin(0,0) -- Set Pin 0 low (0) led on dash 250 ms
ez.Wait_ms(250)
--space
ez.Pin(0,1) -- Set Pin 0 high (1) led off space 250 ms
ez.Wait_ms(250)
goto Start


-- Once RUNNING, You must press the RESET button to escape