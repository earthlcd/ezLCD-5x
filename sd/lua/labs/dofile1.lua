-- This example shows how to run a lua file from a lua file using the dofile()

ez.Cls(ez.RGB(0,0,255))
ez.SetColor(ez.RGB(255,255,255))
print("dofile1.lua")
ez.Wait_ms(3000)

dofile("lua/labs/dofile2.lua")

ez.Cls(ez.RGB(255,0,255))
ez.SetColor(ez.RGB(255,255,255))
print("dofile1.lua")

