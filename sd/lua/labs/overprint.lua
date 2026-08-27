ez.Cls(ez.RGB(0,0,0))
ez.SetBmFont(0)
-- green font
ez.SetColor(ez.RGB(0,255,0))
ez.SetXY(50,250)
print("Hello ")
-- set color to background (black) and print over original message
ez.Wait_ms(1500)
--erase
ez.SetColor(ez.RGB(0,0,0))
ez.SetXY(50,250)
print("Hello ")
ez.SetBmFont(0)
-- green font
ez.SetColor(ez.RGB(0,255,0))
ez.SetXY(50,250)
print("Hello ")
ez.SetXY(50,250)
-- set color to background (white) and print over original message
ez.Wait_ms(1500)
ez.SetColor(ez.RGB(0,0,0))
print("Hello ")