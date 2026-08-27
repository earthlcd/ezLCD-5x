-- errorHandler function demo
-- illegal command ez.SetPinOut(100) will print out to ezLCD Display
-- Note: using this command will turn off the regular error messages to the Lua console
function mainFunction()
    ez.Cls(ez.RGB(255,255,255))
    ez.SetColor(ez.RGB(0,0,0))
    ez.SetPinOut(100)
end
function errorHandler(errmsg)
    print(debug.traceback())
    print(errmsg)
end
-- Call mainFunction() protected by errorHandler
rc, err = xpcall(function() mainFunction() end, errorHandler)