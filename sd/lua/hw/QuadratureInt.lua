-- Created  05/16/2022  -  Robert Garito
-- Modified 05/16/2022  -  Dan Likins

--QUADRATURE ENCODER WIH INTERRUPT
--Pins:
--   A - User2 / Pin 20 (I2S_MCK)
--   B - User2 / Pin 26 (GPIO6)			-- This pin is NOT an Interupt Input
--  SW - User2 / Pin 8  (GPIO1)			-- This pin is an Interupt Input
--  V+ - +3.3v (take from RTC Batt Sel)
-- GND - GND


function QuadInterrupt(value)
  QuadValue = value
end

function ButtonInterrupt(value)
  print("Pushed ~ ", value)
end
                
ez.SetPinIntr(1, "ButtonInterrupt")		-- ez.SetPinIntr(GPIO Pin to use, "Name of ISR Function")
ez.QuadOpen("QuadInterrupt",16)			-- ez.QuadOpen("Name of ISR Function", Max Count before Rollover)

ez.Cls(ez.RGB(0,0,128))
ez.SetColor(ez.RGB(255,255,255))

while (1) do

  if (QuadValue ~= OldQuadValue) then
    if (QuadValue == 0) then
      ez.Cls(ez.RGB(0,0,128))
    end
    print(" ~ ", QuadValue)
	OldQuadValue = QuadValue
  end

end
-----------------------------