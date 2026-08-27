-- Peteio by Peter --
-- September 2nd 2022 --
-- v 1.0
local open = io.open

local fontY = 8 --the height of the font in pixels
local fontX = 8 --the width of the font in pixels
local indentX = ez.Width // 8
local indentY = ez.Height // 16
local currX = indentX --current X
local currY = indentY --current y
thisLine = 'null'
thisWord = ""
lineCount = 0 --current number of lines on screen
lineLim = ez.Height // fontY --number of lines that can be displayed on screen at any one time
charCount = 0 -- tracks our location in current line
charTrack = 1 -- track our location in the text, only increase by adding charCount
charLim = ((ez.Width - indentX ) // fontX) --number of characters allowed per line
charSum = 0 -- sum of charCount and charTrack
page = 1
H = ez.Height
W = ez.Width
pageChar = {charTrack} -- this array keeps track of where (in characters) the pages start
flee = false
invisButt = false
bx1, bx2, by1, by2 = (ez.Width - ez.Width // 6), (ez.Width // 6), (ez.Height - (ez.Height // 6)), (ez.Height // 6)--data for exit button in order; box's x start, width, y start, height
h, w = (ez.Height // 4), (indentX - fontX)--height and width for the next and back buttons
backX, forX, butY = 0, (ez.Width - w), ((ez.Height // 2) - (h // 2)) -- x for back, x for next, y for both

--use ez.SetXY(x, y)
--ez.Button(1, 1, -1, -1, -1, x1, y1, x2, y2)
--ez.Button(ID, iState, iconUp, iconDown, iconDisabled, x, y, width, height) 
--ez.Width		returns screen pixel width
--ez.Height		returns screen pixel height
--make code around command that will return pixel width of a string

function sButtonHandler(id, state) -- button handler function

	--ez.DelButtons() -- clear invisible buttons
	if state == 1
	
		then
		if id == 1
		then page = page - 1 -- back button makes us go back a page
		--print(page)
		printPage(page)
		
		elseif id == 2
		then page = page + 1 -- forward button id makes us go forward a page
		--print (page)
		ez.Cls(ez.RGB(255,255,255))
		printPage(page)
		
		elseif id == 63
		then flee = true -- exit button pressed, flag switched for exiting program
		
	end
end
end

function read_file(path)
    local file = open(path, "r") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

fileContent = read_file("_Read Me.txt")
length = #fileContent

function printPage(pNum)

	ez.DelButtons()
	ez.SetColor(ez.RGB(0,0,0)) -- set color to black, the classic text color
	ez.Cls(ez.RGB(255,255,255))
	print ("Page: " .. pNum .. "   length: " .. length .. "  charTrack: " .. pageChar[page]) -- for debug
	ez.SetXY(indentX, indentY)
	charTrack = pageChar [pNum]
	while lineCount < lineLim do -- Prints only enough lines to not go off screen.

		while ((lineCount < lineLim)) do -- prevents the text from going offscreen horizontally
		
			charSum = charCount + charTrack --1 --tracks location in file
			
			if string.sub(fileContent, charSum + 1, charSum + 1) == '\n' then -- 
				
				charTrack = charTrack + charCount + 1
				charCount = 1
				lineCount = lineCount + 1
				
				--thisWord = thisWord .. "[]" --for debugging
				
				print(thisWord)
				currX = indentX
				currY = currY + fontY
				ez.SetXY(currX, currY)
				thisWord = ""
				
				break
				
					else
					thisWord = thisWord .. (string.sub(fileContent, charSum, charSum))
					charCount = charCount + 1
					
			end 
			
			if string.sub(thisWord, -1, -1) == ' ' then --prints the whole word including the space
			
				if (charCount + #thisWord > charLim) then -- Checks if thisWord will go off screen, if yes it moves down one line.
				
					currX = indentX
					currY = currY + fontY
					ez.SetXY(currX, currY)
					local tW = #thisWord
					--thisWord = thisWord .. charCount + tW-- For debugging
					print (thisWord)
					currX = currX + (#thisWord * fontX)
					ez.SetXY(currX, currY)
					lineCount = lineCount + 1
					charTrack = charTrack + charCount - #thisWord
					charCount = #thisWord
					thisWord = ""
					
					else 
					--thisWord = thisWord .. "XX" -- for debugging
					print (thisWord)
					currX = currX + (#thisWord * fontX)
					ez.SetXY(currX, currY)
					thisWord = ""
					end
			
			end
			
			
		end
	
		lineCount = lineCount + 1
		currX = indentX
	end
	currY = indentY
	--print ("end loop")
	if pageChar[page + 1] == nil and charTrack < length then
	pageChar[page + 1] = charTrack
	end
	
	ez.DelButtons() -- clear invisible buttons
	
	if not invisButt then -- draws the exit button
		ez.SetColor(ez.RGB(0,0,0)) -- set color to black, the classic text color
		ez.SetXY(bx1, by1)
		ez.BoxFill(bx1 + bx2, by1 + by2)
		ez.HLine(bx1, by1, ez.Width, ez.RGB(63,63,63))
		ez.VLine(bx1, by1, ez.Height, ez.RGB(63,63,63))
		ez.SetColor(ez.RGB(255,255,255)) -- white color for the black box text
		ez.SetXY((bx1 + (bx2 // 3)), (by1 + (by2 // 3)))
	print "EXIT"
	
	end
	ez.Button(63, 1, -1, -1, -1, bx1, by1, bx2, by2)-- exit button
	
	if not invisButt and not(pageChar[page - 1] == nil) then -- draws the back button
		ez.SetColor(ez.RGB(0,0,0)) -- set color to black, the classic text color
		ez.SetXY(backX, butY )
		ez.BoxFill(backX + w, butY + h)
		ez.HLine(backX, butY, backX + w, ez.RGB(63,63,63))
		ez.VLine(backX, butY, butY + h, ez.RGB(63,63,63))
		ez.SetColor(ez.RGB(255,255,0)) -- white color for the black box text
		ez.Line(backX + w, butY, backX, butY + (h // 2)) 
		ez.Line(backX, butY + (h // 2), backX + w, butY + h) 
		
	end
	ez.Button(1, 1, -1, -1, -1, backX, butY, w, h)-- back button
	
	if not invisButt and not(pageChar[page + 1] == nil)then -- draws the next button
		ez.SetColor(ez.RGB(0,0,0)) -- set color to black, the classic text color
		ez.SetXY(forX, butY )
		ez.BoxFill(forX + w, butY + h)
		ez.HLine(forX, butY, forX + w, ez.RGB(63,63,63))
		ez.VLine(forX, butY, butY + h, ez.RGB(63,63,63))
		ez.SetColor(ez.RGB(255,255,255)) -- white color for the black box text
		ez.Line(forX , butY, forX + w, butY + (h // 2)) 
		ez.Line(forX + w, butY + (h // 2), forX, butY + h)
	end
	ez.Button(2, 1, -1, -1, -1, forX, butY, w, h)-- next button
	ez.SetColor(ez.RGB(0,0,0))
	ez.SetXY(0, 0)
	
	lineCount = 0
	charCount = 0
end
--ez.Line(x1, y1, x2, y2) 

function mainFunction()

	

	ez.SetButtonEvent("sButtonHandler") 
	printPage(page)
	--print(pageChar[1].. "  pge 2 = " .. pageChar[2])
	
	while not flee do

	end

	ez.Cls(ez.RGB(255,255,255))
	print("that's all folks") -- end program text
end

--mainFunction()
	--page = page + 1
	--printPage(page)
-- error function starts here	

	function errorHandler(errmsg)
    print(debug.traceback())
    print(errmsg)
end

-- Call mainFunction() protected by errorHandler
rc, err = xpcall(function() mainFunction() end, errorHandler)


-- end of error handler
--print (fileContent);
