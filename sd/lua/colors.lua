-- Colors Example  (Updated 04/14/2022)
-- Cycles through colors red, green, & blue, for 2 seconds each
 ez.Cls(ez.RGB(255,0,0))    -- RED Only
 ez.Wait_ms(2000)           -- Delay
 ez.Cls(ez.RGB(0,255,0))    -- GREEN Only
 ez.Wait_ms(2000)           -- Delay
 ez.Cls(ez.RGB(0,0,255))    -- BLUE Only
 ez.Wait_ms(2000)           -- Delay
 ez.SetColor(ez.RGB(0,0,0)) -- Set Drawing Color (foreground) to Black
 ez.SetXY(150,100)          -- Set X, Y start location 
 print ("END")
  
 -----------------------