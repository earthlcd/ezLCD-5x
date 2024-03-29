-- FileName: serialcom.Lua
-- Serial Test updated 6/17/22
-- Perform loopback test on [USART2] Port(0) and [USART3] Port(1) Serial USART,
-- TTL Port 0 [USART2] J6-Pin1 (Rx) & J6-Pin17 (Tx) are to be tied together
-- TTL Port 1 [USART3] J5-Pin6 (Rx) & J5-Pin22 (Tx) are to be tied together
-- Does NOT work with RS-232 connector J3 connected in hardware loopback configuration
-- On ezLCD-5035 USART2 [Port 0] connector J6 pin 1 (RX) and J6 pin 17 (TX)
-- On ezLCD-5035 USART2 is also available at RS-232 levels on J3 pins 2 & 3
-- On ezLCD-5035 USART3 [Port 1] connector J5 pin 6 (RX) and J5 pin 22 (TX)
-- To change Port number, you must alter the "ez.SerialOpen" command near the top of the    "mainFunction()"
--          And alter the Port number in the "ez.SerialTx"   command near the bottom of the "mainFunction()"
function SerialReceiver(rxChar)  -- <------ Called from Middle of "mainFunction()"
    -- Save our position so we can undo the auto carriage return after
	curY=ez.GetY()
	curX=ez.GetX()
	print(string.char(rxChar))
	-- Simulate a Carriage Return after 5 chars (each char is 6 pixels wide)
	if (curX>=24) then
		curX=-6		-- We immediately will add 6 when doing SetX below, so this will result in X=0
		curY=curY+12
	end
	
	-- Because Lua print() always does a carriage return, undo the carriage return and set our cursor
	-- At the next position after the already-printed character
	ez.SetY(curY)
	ez.SetX(curX+6)
	
end
function blink(seconds)  -- <------ Called from Bottom of "mainFunction()"
	seconds = seconds * 2
	for i = 1,seconds,1 do					-- Blink LED H to show we are still in the loop
		ez.Pin(0,0)		ez.Wait_ms(250)		-- Set Pin 0 low  (0) led on  dash  250 ms
		ez.Pin(0,1)		ez.Wait_ms(250)		-- Set Pin 0 high (1) led off space 250 ms
	end
end
function mainFunction()  -- <------ Called from "xpcall(function() mainFunction()...." at the bottom
		-- ez.SerialOpen(RcvFunc [, PortNo [, BaudRate [, DataBits [, Parity [, StopBits [, HandShake]]]]]])
		-- For above see ezLCD Lua API Manual Section 28.1
		-- Port 0 is Usart2 and Port 1 is Usart3 on ezLCD-5035
		-- ez.SerialOpen("SerialReceiver")  	-- Open MAIN serial with default parameters in "Event Mode"
		--								   		-- 9600,N,8,1 no handshaking
		
		-- Use one of the two  "ez.SerialOpen()"  lines below BUT NOT BOTH
		-- ez.SerialOpen("SerialReceiver")		-- Port 0 [Usart2 J6 pins 1 (RX) and 17 (TX)] (default)
		ez.SerialOpen("SerialReceiver", 1, 9600, 8, 0, 0, 0)	-- Port 1 [Usart3 J5 pins 6 (RX) and 22 (TX)]
		
		ez.Cls(ez.RGB(255,255,255))
		ez.SetColor(ez.RGB(0,0,0))
		ez.Cls(ez.RGB(255,255,255))
		ez.SetColor(ez.RGB(0,0,0))
		
		while (true) do
	
			for i = 1,10,1 do 		-- cls and send 10 characters and Loop FOREVER
				
			-- ez.SerialTx(DATA, MaxLen, PortNo)   NOTE: this is a correction to Manual Section 28.4
			-- MaxLen & PortNo are not in their correct order in the manual -- Correct order is as shown above
			
			-- Use one of the two  "ez.SerialTx()"  lines below BUT NOT BOTH				
			-- ez.SerialTx("Hello", 5, 0)	--  Port 0 [Usart2  J6 connector pins 1 (RX) and 17 (TX)] (default)
			ez.SerialTx("Hello", 5, 1)		-- 	Port 1 [Usart3  J5 connector pins 6 (RX) and 22 (TX)]
						
				blink(1) -- blink led and wait 1 seconds before sending more data
		end
	end
end
--  ez.SerialClose() 			-- <------ Commented Out Because Program Loops Forever
function errorHandler(errmsg)	-- <------ Called from "xpcall(.... , errorHandler) at the bottom
    print(debug.traceback())
    print(errmsg)
end
-- Call mainFunction() protected by errorHandler
ez.Cls(ez.RGB(255,255,255))  	-- <------ Program Begins Here <------
rc, err = xpcall(function() mainFunction() end, errorHandler)
-- To EXIT, you must cycle the power or press the reset button


randy
  12:18 PM
peter's attempt at buttons
Peter Fitzpatrick
 | PUI.lua 
-- Peter's  Interface
--the goal of this program is to create a navigatable menu
--ez.Button(ID, iState, iconUp, iconDown, iconDisabled, x, y, width, height)  button reference
--ez.SetXY(x, y) use to set position
--ez.Width
Click to expand inline (246 lines)


New
Added to your saved items


Dan Likins
  3:27 PM
-- FileName: rs485Test.lua
-- RS485 Test updated 6/21/22    uses usart3 (Tx, Rx, DE)
--
-- Tie both DO & DI on your external RS485 transciever to USART3 DE (J6 - Pin19)
-- RO is "Receive OUT" and connects to USART3 Rx (J5 - Pin6)  and
-- DI is "Data In"     and connects to USART3 Tx (J5 - Pin22)
-- NOTE!!:  Be sure Images 0 & 1 In your "Config.txt" file are not commented out
-- 		[Images]
-- 		0 = /Images/RedClosed.bmp
-- 		1 = /Images/GreenOpen.bmp
function RS485Receiver(rxChar)  	-- <------ Interupt Service Routine
	print(string.char(rxChar))		--         Called from ez.SerialOpen()
end
function ButtonHandler(id, state)	-- <------ Interupt Service Routine
	if state==2 then				--         Called from ez.SetButtonEvent()
	--  ez.SerialTx(Data, MaxLen, PortNo)
		ez.SerialTx(ez.SerialNo, 24, 1)
	end
	ez.Button(id, state)
end
function blink(seconds)  -- <------ Called from Bottom of "mainFunction()"
	seconds = seconds * 2
	for i = 1,seconds,1 do					-- Blink LED H to show we are still in the loop
		ez.Pin(0,0)		ez.Wait_ms(250)		-- Set Pin 0 low  (0) led on  dash  250 ms
		ez.Pin(0,1)		ez.Wait_ms(250)		-- Set Pin 0 high (1) led off space 250 ms
	end
end
function mainFunction()  -- <------ Called from "xpcall(function() mainFunction()...." at the bottom
    ez.SerialOpen("RS485Receiver", 1, 9600, 8, 0, 0, 5)  -- Open serial
	ez.Cls(ez.RGB(255,255,255))
	ez.SetColor(ez.RGB(0,0,0))
	
	-- This creates button ID 0 in the UP state (1)
	-- Using image 0 for the UP image and
	-- Using image 1 for the DOWN image
	-- No image -1 when Button is Disabled
	-- at screen location (100, 100)
	-- No Width or Height specified
	
	ez.Button(0, 1, 0, 1, -1, 100, 100)
	ez.SetButtonEvent("ButtonHandler")
	 
	while (true) -- <----- Loop HERE FOREVER <-----
	do
		blink(1) -- blink led and wait 1 seconds before sending more data
	end
end
--  ez.SerialClose() 			-- <------ Commented Out Because Program Loops Forever
function errorHandler(errmsg)	-- <------ Called from "xpcall(.... , errorHandler) at the bottom
    print(debug.traceback())
    print(errmsg)
end
-- Call mainFunction() protected by errorHandler
ez.Cls(ez.RGB(255,255,255))  	-- <------ Program Begins Here <------
rc, err = xpcall(function() mainFunction() end, errorHandler)
-- To EXIT, you must cycle the power or press the reset button