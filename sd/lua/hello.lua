--ezLCD Hello World Version A 09/17/20
--------------------"--" is a comment line
--hello world
ez.Cls(ez.RGB(0,0,128)) -- set medium color blue
-- Font issues? Comment all font commands out and ezLCD will use internal font!
-- Used fixed size Bitmap Font 1 
--ez.SetBmFont(1)--before enabling be sure font set in config.txt
-- Use scalable FreeType Font 2 in 28 point size
ez.SetFtFont(0,60,60)--before enabling be sure font set in config.txt
----
ez.SetColor(ez.RGB(255,215,0))
ez.SetXY(120,120)
print("Hello World!!!")
---------------------