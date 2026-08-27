--cycle rgb colors 2 seconds with goto
 ::start::
 ez.Cls(ez.RGB(255,0,0))
 ez.Wait_ms(2000)
 ez.Cls(ez.RGB(0,255,0))
 ez.Wait_ms(2000)
 ez.Cls(ez.RGB(0,0,255))
 ez.Wait_ms(2000)
 goto start