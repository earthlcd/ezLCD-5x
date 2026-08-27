-- FileName: serial-ezLCD405-control.lua
--
-- The purpose of this program is to demonstrate how to send serial data from the
-- ezLCD-5035 to the ezLCD405.
--
-- Program Created on 1/17/24 by Jacob Christ for EarthLCD
--
--   Tested on Serial 1 / usart3 (Tx, Rx, DE)
--   But should also work on Serial 0 by chaning the SerialPort variable
--   Note that is will not work with RS-485 drivers becuase they are half duplex
--
-- Tie both DO & DI on your external RS422 transciever to USART3 DE (J6 - Pin19)
-- RO is "Receive OUT" and connects to USART3 Rx (J5 - Pin6)  and
-- DI is "Data In"     and connects to USART3 Tx (J5 - Pin22)

-----------------------------------------------------------------------------------------
-- 5035 -> 405 in to calibrated xy touch mode 
-- 5035 -> Read data comming from the 405 and display it on the 5035 in hex and decimal
-- 5035 -> Draw a cross hair on the 405 at the precived touch position
-----------------------------------------------------------------------------------------

CommandBuffer = ""		-- Used to hold incomming characters until we see an end of line
CommandFound = false 	-- Flag to indicate when we have received a command
Command = "" 			-- Command to parse in the parser
SerialPort = 1

Running = 1 -- Applicaiton is running
Pressed = 0 -- Button has been pressed
ButtonID = -1

-- /////////////////////////////////////////////////////////////////// 206
-- //  void  arLCD::Set_BOXH(  int xLoc, int yLoc)
-- ///////////////////////////////////////////////////////////////////
function ArLCD_Set_BOXH(xLoc, yLoc)
  ArLCD_write_cmd(0xA2, xLoc >> 8, (xLoc & 0xFF), (yLoc & 0xFF))
end

-- /////////////////////////////////////////////////////////////////// 234
-- //  void  arLCD::Set_BOXHH(  int xLoc, int yLoc)
-- ///////////////////////////////////////////////////////////////////
function  ArLCD_Set_BOXHH(xLoc, yLoc)
  ArLCD_write_cmd(0xA4, xLoc >> 8, (xLoc & 0xFF), yLoc >> 8, (yLoc & 0xFF))
end

-- /////////////////////////////////////////////////////////////////// 447
-- // void  arLCD::cls()
-- ///////////////////////////////////////////////////////////////////
function ArLCD_cls()
  ArLCD_write_cmd(0x21)
end

-- /////////////////////////////////////////////////////////////////// 705
-- //  void  arLCD::Set_Plot_XHYH( int XH, int YH)
-- ///////////////////////////////////////////////////////////////////
function ArLCD_Set_Plot_XHYH(XH, YH)
  ArLCD_write_cmd(0x87, (XH >> 8) & 0xff, XH & 0xff, YH)
end

-- /////////////////////////////////////////////////////////////////// 1479
-- //  void  arLCD::Set_ColorH(int colorRed, colorGreen, int colorBlue)
-- ///////////////////////////////////////////////////////////////////
function ArLCD_Set_ColorH(colorRed, colorGreen, colorBlue)
  local data1, data2

  -- // 0bGGGB BBBB RRRR RGGG
  data1 =  ((colorGreen << 5) & 0xE0) | ( colorBlue        & 0x1F) -- // 0bGGGB BBBB
  data2 =  ((colorRed   << 3) & 0xF8) | ((colorGreen >> 3) & 0x07) -- // 0bRRRR RGGG
  ArLCD_write_cmd(0x84, data1, data2);
  -- ArLCD_write_cmd(0x84);
  -- ArLCD_write(data1);
  -- ArLCD_write(data2);
end

-- /////////////////////////////////////////////////////////////////// 1567
-- //  void  arLCD::Set_XHYH( int curPoX, int  curPoY)
-- ///////////////////////////////////////////////////////////////////
function ArLCD_Set_XHYH(curPoX, curPoY)
  ArLCD_write_cmd(0x85, curPoX >> 8, (curPoX & 0xFF), (curPoY & 0xFF))
end

-- /////////////////////////////////////////////////////////////////// 1659
-- //  void  arLCD::Touch_Protocol( int bTouch)
-- //  0 - None (maybe ezLCD-5035 only)
-- //  1 - ezButton
-- //  2 - cuButton
-- //  64 - Calibrated XY
-- ///////////////////////////////////////////////////////////////////
-- void  arLCD::Touch_Protocol( int bTouch)
function  ArLCD_Touch_Protocol(bTouch)
  ArLCD_write_cmd(0xB2, bTouch);
end

-- /////////////////////////////////////////////////////////////////// 1764
function ArLCD_write_cmd(opcode, ...)
  -- if (data == (byte)ezLCD_OpCodes::NotImplimented)
  -- {
  --   Serial.printf("\n******************");
  --   Serial.printf("\n* NotImplimented *");
  --   Serial.printf("\n******************");
  -- }

  local printResult
  printResult = "CMD: " .. string.format('%02x', opcode)
  -- ez.SerialTx(string.char(opcode), SerialPort, 1) -- DO NOT DO THIS 0x00 WILL NOT TRANSMIT
  ez.SerialTx(opcode, SerialPort, 1)
  for i,v in ipairs({...}) do
    local operand = tonumber(v)
    printResult = printResult .. " " .. string.format('%02x', operand)
    -- ez.SerialTx(string.char(operand), SerialPort, 1) -- DO NOT DO THIS 0x00 WILL NOT TRANSMIT
    ez.SerialTx(operand, SerialPort, 1)
  end

  print(printResult)
end

-- /////////////////////////////////////////////////////////////////// 1776
function ArLCD_write(data)
  print(string.format('%02x', data))
  ez.SerialTx(data, SerialPort, 1)
end

ParseBytes = 0
PACKET_ID = -1
TEMP_X = -1
TEMP_Y = -1
TOUCH_X = -1
TOUCH_Y = -1
TouchRecieved = 0
function SerialRxIsr(rxChar)  	-- <------ Interupt Service Routine
	-- print(string.char(rxChar))		-- Uncomment to display characters as they are received
	-- ez.SerialTx(byte, debug_port, 1) -- Uncomment to echo character back as they are received
	-- if rxChar == 13 or rxChar == 10 then
  --   if string.len(CommandBuffer) > 0 then
	-- 		Command = CommandBuffer
	-- 		CommandBuffer = ""
	-- 		CommandFound = true
	-- 		-- print("Command:" .. Command .. "\r\n") -- Uncomment to display found command
	-- 	end
	-- else
  if ParseBytes <= 0 then
    PACKET_ID = rxChar
    if PACKET_ID == 0x81 then
      ParseBytes = 5
      CommandBuffer = "TOUCH_X"
    -- elseif PACKET_ID == 0x82 then
    --   ParseBytes = 3
    --   CommandBuffer = "TOUCH_Y"
    elseif PACKET_ID == 0x83 then
      ParseBytes = 1
      CommandBuffer = "PEN_UP"
      TouchRecieved = 0
      -- else
    --   ParseBytes = 1
    --   CommandBuffer = "UKN: " .. string.format('%02x', PACKET_ID)
    end
  else
    if PACKET_ID == 0x81 then
      if ParseBytes == 5 then
        TEMP_X = rxChar
      elseif ParseBytes == 4 then
        TEMP_X = TEMP_X + (rxChar << 7)
      elseif ParseBytes == 5 then
        -- Ignore TOUCH_Y Byte
      elseif ParseBytes == 2 then
        TEMP_Y = rxChar
      elseif ParseBytes == 1 then
        TEMP_Y = TEMP_Y + (rxChar << 7)

        CommandBuffer = "TOUCH " .. TOUCH_X .. ", " .. TOUCH_Y
        CommandBuffer = "" -- Suppress auto display of this packet

        TOUCH_X = TEMP_X
        TOUCH_Y = TEMP_Y
        TouchRecieved = TouchRecieved + 1
      end
    -- elseif PACKET_ID == 0x82 then
    --   if ParseBytes == 2 then
    --     TEMP_Y = rxChar
    --   elseif ParseBytes == 1 then
    --     TEMP_Y = TEMP_Y + (rxChar << 8)
    --     CommandBuffer = "TOUCH " .. TOUCH_X .. ", " .. TOUCH_Y
    --     PACKET_ID = -1
    --     TOUCH_X = TEMP_X
    --     TOUCH_Y = TEMP_Y
    --     TouchRecieved = 1
    --   end
    elseif PACKET_ID == 0x83 then
      CommandBuffer = "" -- Suppress auto display of this packet
    else
      CommandBuffer = CommandBuffer .. " " .. string.format('%02x', rxChar)
    end
    ParseBytes = ParseBytes - 1
    if ParseBytes == 0 and CommandBuffer ~= "" then
      Command = CommandBuffer
      CommandBuffer = ""
      CommandFound = true
    end
  end
    --   -- CommandBuffer = CommandBuffer .. string.char(rxChar) -- print ascii
		-- -- CommandBuffer = CommandBuffer .. string.byte(rxChar) -- print dec
		-- CommandBuffer = CommandBuffer .. " " .. string.format('%02x', rxChar) -- print hex string
		-- print("CB:" .. CommandBuffer .. "\r\n") -- Uncomment to display found command
end

function Listen(milliseconds)
  while(milliseconds > 0)
  do
    -- Display the resluts of any received data
    if CommandFound == true then
      print("Rx: " .. Command)
      -- Clear the receive buffers
      Command = ""
      CommandFound = false
    else
      -- print("Nothing Received: " .. Command)
      --break -- Uncomment to break out of the program if loopback is missing
    end
       -- Need to throw away the first touch since the 405 has a bug and sends old data
    if TouchRecieved == 2 then
      ez.Cls(ez.RGB(0,0,255))
      print("TOUCH " .. TOUCH_X .. ", " .. TOUCH_Y)

      local min_x = TOUCH_X - 10
      local min_y = TOUCH_Y - 10
      local max_x = TOUCH_X + 10
      local max_y = TOUCH_Y + 10
      if min_x < 0 then min_x = 0 end
      if min_y < 0 then min_y = 0 end
      if max_x > 320 then max_x = 320 end
      if max_y > 240 then max_y = 240 end
      ArLCD_Set_ColorH(255,255,255)
      ArLCD_Set_Plot_XHYH(TOUCH_X, TOUCH_Y)
      ArLCD_Set_XHYH(min_x, min_y)
      ArLCD_Set_BOXH(max_x, max_y)

      -- ArLCD_Set_BOXHH(TOUCH_X + 10, TOUCH_Y + 10) -- I don't think this works on the 405

      TouchRecieved = 3
    end
    milliseconds = milliseconds -1
    ez.Wait_ms(1)
  end
end

function ButtonHandler(id,state)
  print("press ", id, ":", state, " Pressed ",Pressed, " Running ", Running) --print id and state for diagn.
  --print("\r\n")

  -- state == 1 is check for button released
  -- state == 2 is check for button pressed
  if (state==1) then
    ButtonID = id
    if ( id == 0 ) then
      -- button function not defined
    end
    if ( id == 1 ) then
      -- button function not defined
    end
    if ( id == 2 ) then
      Running = 0
    end
    Pressed = 1
  end
end

function ButtonSetup()
  print("ButtonSetup()")

  -- -- Button 0 (Top Left) { x1, y1, x2, y2 }
  local B0 = { 0, 0, (ez.Width // 2) - 1, ez.Height - 41 }

  -- -- Button 1 (Top Right) { x1, y1, x2, y2 }
  local B1 = { (ez.Width // 2), 0, ez.Width, ez.Height - 41 }

  -- Button 2 (Bottom Left) { x1, y1, x2, y2 }
  local B2 = { 0, ez.Height - 40, 80, ez.Height }

  ez.Button(0,1,-1,-1,-1,B0[1],B0[2],B0[3],B0[4])	-- set up button
  ez.Button(1,1,-1,-1,-1,B1[1],B1[2],B1[3],B1[4]) -- set up button
  ez.Button(2,1,-1,-1,-1,B2[1],B2[2],B2[3],B1[4]) -- set up button
  ez.SetButtonEvent("ButtonHandler")	    -- call the button function (above)
end

function mainFunction()  -- <------ Called from "xpcall(function() mainFunction()...." at the bottom
  ez.Cls(ez.RGB(0,0,0))
  ez.SetColor(ez.RGB(255,255,255))

  print("ezLCD405 Communications Setup")
  ez.SerialOpen("SerialRxIsr", SerialPort, 115200, 8, 0, 0, 5)  -- Open serial

  ButtonSetup()

  ArLCD_Touch_Protocol(64)
  -- ez.Wait_ms(2000)
  Listen(2000)

  while Running == 1 do -- <----- Loop HERE FOREVER <-----
    if Pressed == 1 and ButtonID == 0 then
      -- Clear the ezLCD-5035 Screen
      ez.Cls(ez.RGB(255,0,0))
      print("Red")

      -- Send command to ezLCD405
      ArLCD_Set_ColorH(255,0,0)
      ArLCD_cls()
    end

    if Pressed == 1 and ButtonID == 1 then
      -- Clear the ezLCD-5035 Screen
      ez.Cls(ez.RGB(0,0,255))
      print("Blue")

      -- Send command to ezLCD405
      ArLCD_Set_ColorH(0,0,255)
      ArLCD_cls()
    end

    Pressed = 0;

    -- Wait for the data to be received
    Listen(100)
  end
  print("Exiting...")
end
--  ez.SerialClose() 			-- <------ Commented Out Because Program Loops Forever
function errorHandler(errmsg)	-- <------ Called from "xpcall(.... , errorHandler) at the bottom
    print(debug.traceback())
    print(errmsg)
    ez.Wait_ms(60000)
end

-- Call mainFunction() protected by errorHandler
ez.Cls(ez.RGB(255,255,255))  	-- <------ Program Begins Here <------
rc, err = xpcall(function() mainFunction() end, errorHandler)
-- To EXIT, you must cycle the power or press the reset button

-- Wait then display exit message
ez.Wait_ms(1000)
-- Make the screen Purple
ez.Cls(ez.RGB(128,0,128))
-- Make the font a blue-ish white color
ez.SetColor(ez.RGB(200,200,255))

print()
print("Serial Loopback Test Ended")
print()
print("When no data is received in looback")
print("the program exits")

