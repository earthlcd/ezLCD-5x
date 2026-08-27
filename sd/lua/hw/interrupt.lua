--PINS WITH INTERRUPTS WITH LUA
--Right now the interrupt fires on BOTH rising and falling edge.  The pins are sensitive enough that if you put a wire on the pin and just touch the wire, it will trigger the interrupt
--In the demo code below, D2 is the pin that I’m setting the interrupt on:
function MyInterrupt(pin)
                ez.SetBmFont(6)
                ez.SetColor(ez.RGB(255,215,0))
                ez.SetXY(100,100)

                print("Pin Interrupt Detected!");
end
                
ez.Cls(ez.RGB(0,0,128))
ez.SetPinIntr(2, "MyInterrupt")

while (1) do
end
-----------------------------