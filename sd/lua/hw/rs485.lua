-- FileName: rs485.lua
-- RS485 Test updated 6/21/22    uses usart3 (Tx, Rx, DE)
--
-- Tie both DO & DI on your external RS485 transciever to USART3 DE (J6 - Pin19)
-- RO is "Receive OUT" and connects to USART3 Rx (J5 - Pin6)  and
-- DI is "Data In"     and connects to USART3 Tx (J5 - Pin22)
-- NOTE!!:  Be sure Images 0 & 1 In your "Config.txt" file are not commented out
-- 		[Images]
-- 		0 = /Images/RedClosed.jpg
-- 		1 = /Images/GreenOpen.jpg
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