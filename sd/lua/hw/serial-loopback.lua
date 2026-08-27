-- FileName: serial-loopback.lua
-- Full duplex serial loopback test program 8/27/24 by Jacob Christ for EarthLCD
--
--   Tested on Serial 1 / usart3 (Tx, Rx, DE)
--   But should also work on Serial 0 by chaning the SerialPort variable
--   Note that is will not work with RS-485 drivers becuase they are half duplex
--
-- Tie both DO & DI on your external RS422 transciever to USART3 DE (J6 - Pin19)
-- RO is "Receive OUT" and connects to USART3 Rx (J5 - Pin6)  and
-- DI is "Data In"     and connects to USART3 Tx (J5 - Pin22)

CommandBuffer = ""		-- Used to hold incomming characters until we see an end of line
CommandFound = false 	-- Flag to indicate when we have received a command
Command = "" 			-- Command to parse in the parser
SerialPort = 1

function RS422Receiver(rxChar)  	-- <------ Interupt Service Routine
	-- print(string.char(rxChar))		-- Uncomment to display characters as they are received
	-- ez.SerialTx(byte, debug_port, 1) -- Uncomment to echo character back as they are received
	if rxChar == 13 or rxChar == 10 then
		if string.len(CommandBuffer) > 0 then
			Command = CommandBuffer
			CommandBuffer = ""
			CommandFound = true
			-- print("Command:" .. Command .. "\r\n") -- Uncomment to display found command
		end
	else
		CommandBuffer = CommandBuffer .. string.char(rxChar)
	end  
end

function mainFunction()  -- <------ Called from "xpcall(function() mainFunction()...." at the bottom
  ez.SerialOpen("RS422Receiver", SerialPort, 9600, 8, 0, 0, 5)  -- Open serial
  ez.Cls(ez.RGB(0,0,0))
  ez.SetColor(ez.RGB(255,255,255))

	while (true) -- <----- Loop HERE FOREVER <-----
	do
    -- Send some data
    ez.SerialTx("serial data\r\n", SerialPort, 80)
    -- Wait for the data to be received
    ez.Wait_ms(1000)
    -- Clear the screen
    ez.Cls(ez.RGB(0,0,0))
    ez.SetColor(ez.RGB(255,255,255))
    print()
    print("Serial Loopback Test on Serial Port " .. SerialPort)
    print()
    -- Display the resluts of any received data
    if CommandFound == true then
      print("Loopback Found: " .. Command)
      -- Clear the receive buffers
      Command = ""
      CommandFound = false
    else
      print("Nothing Received: " .. Command)
      break -- Uncomment to break out of the program if loopback is missing
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

-- Wait then display exit message
ez.Wait_ms(1000)
-- Make the screen Blue
ez.Cls(ez.RGB(0,0,255))
-- Make the font a blue-ish white color
ez.SetColor(ez.RGB(200,200,255))

print()
print("Serial Loopback Test Ended")
print()
print("When no data is received in looback")
print("the program exits")

