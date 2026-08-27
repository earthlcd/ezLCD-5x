--Serial Test 10/11/20 in process not complete
-- does loopback so tx & rx on I/O connector must be tied together
function SerialReceiver(rxChar)
    print(rxChar)
end
function blink(seconds)
    seconds = seconds * 2
    for i = 1,seconds,1 do -- blink twice a second for 60 seconds then quit program				-- diagnostic to show we are in the loop
        -- Blink LED H to show we are still in the loop
        ez.Pin(0,0) -- Set Pin 0 low (0) led on dash 250 ms
        ez.Wait_ms(250)
        --space
        ez.Pin(0,1) -- Set Pin 0 high (1) led off space 250 ms
        ez.Wait_ms(250)
    end
end
function mainFunction()
    ez.Rs232Open("SerialReceiver")  -- Open serial
    while (true) 
    do
        ez.Cls(ez.RGB(255,255,255))
        ez.SetColor(ez.RGB(0,0,0))
        for i = 1,10,1 do -- cls and send 10 characters and repeat forever
            ez.Rs232Tx("Hello",i)
            blink(1) -- blink led and wait 1 seconds before sending more data
        end    
    end
end    
--  ez.Rs232Close()
function errorHandler(errmsg)
    print(debug.traceback())
    print(errmsg)
end
-- Call mainFunction() protected by errorHandler
rc, err = xpcall(function() mainFunction() end, errorHandler)
