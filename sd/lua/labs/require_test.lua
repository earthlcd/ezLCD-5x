-- Program to test lua require call
-- title.lua should be in the same folder as this file.
-- subtitle.lua should be in a lua subdirectory
--
function titleScreen() -- Show a tille sequence for the program
	fn = 14
	ez.Cls(ez.RGB(255,255,255))
	ez.SetColor(ez.RGB(0,255,0))

	ez.SetFtFont(14,32,0) -- Font Number, Height, Width
	print()
	print()
	print("   EarthLCD Demo     ")
	print("                     ")

	ez.Wait_ms(2500)
end

require("title")
require("lua/subtitle")

-- Main
while 1 do
	titleScreen()
	-- title()
	--subtitle()
end

