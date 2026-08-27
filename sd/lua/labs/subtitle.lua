function subtitle() -- Show a tille sequence for the program
	fn = 14
	ez.Cls(ez.RGB(255,255,255))
	ez.SetColor(ez.RGB(0,0,255))

	ez.SetFtFont(14,32,0) -- Font Number, Height, Width
	print()
	print()
	print("   EarthLCD Demo     ")
	print("    subtitle.lua     ")

	ez.Wait_ms(2500)
end
