-- Created  05/16/2022  -  Robert Garito
-- Modified 05/16/2022  -  Dan Likins

-- LM75 is a temperature sensor that can measure temperature in the range from -25 to +125 degrees Celsius.

-- The LM75A has a 7-bit slave address.
-- The four most significant bits of the slave address are hard wired inside the LM75A and are “1001”.
-- The three least significant bits of the address are assigned to pins A2 --> A0, and are set by connecting
-- these pins to ground for a low(0); or to +VS for a high(1).  01001000 = x48  to  1001111 = x4F
--   https://www.ti.com/lit/ds/snos808p/snos808p.pdf

-- I2C SCL = User2 - Pin 18
-- I2C SDA = User2 - Pin  2

adrs = 0x4F   --  1001 A2 A1 A0 <--- LSB
DisplayDelay = 1000
EnableDebugMsg = true										-- <----------------------

if (EnableDebugMsg) then
  ez.LightBright(255) 				-- full brightness
  ez.Cls(ez.RGB(255,255,255)) 		-- set white 
  ez.SetXY(0,10) 					-- set position for print
  print ("Debug Messages Enabled")							-- <----------------------
end

if (EnableDebugMsg) then
  print ("Opening I2C ...") 								-- <----------------------
end

ez.I2CopenMaster(0,100,0,false) 	-- Open user I2C
if (EnableDebugMsg) then
  print("Opened I2C") 										-- <----------------------
end


if (EnableDebugMsg) then
  print ("Write I2C")										-- <----------------------
end

--ez.I2Cwrite(adrs, 1, 0) 			-- set temp pointer
if (EnableDebugMsg) then
  print ("Read I2C")										-- <----------------------
end

tempStr = ez.I2Cread(adrs, 0, 16) 	-- Read 16-bit Temperature
if (tempStr ~= nil) then
	temp = string.byte(tempStr, 1)
	if (temp > 127) then 			-- Convert temperature lower than 0°C
		temp = temp - 256
	end
	print()
	print(string.format("Temp = %d Degrees Celsius",temp))
	
--	tempf = ((temp × 1.8) + 32)
--	print(string.format("Temp = %d Degrees Fahrenheit",tempf))
	
else
	print "Error receiving from LM75"
end


