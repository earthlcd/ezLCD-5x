function SerialReceiver(rxChar)
    print(rxChar)
end
function mainFunction()
    ez.Cls(ez.RGB(255,255,255))
    ez.SetColor(ez.RGB(0,0,0))
    ez.Rs232Open("SerialReceiver")
    ez.Rs232Tx("Hello World")
    
    while (true)
    do
    end
    
    ez.Rs232Close()
end
function errorHandler(errmsg)
    print(debug.traceback())
    print(errmsg)
end
-- Call mainFunction() protected by errorHandler
rc, err = xpcall(function() mainFunction() end, errorHandler)
