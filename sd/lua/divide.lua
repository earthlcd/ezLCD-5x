-- Simple example that shows division and setting up a Lua error handler

function mainFunction()
    --hello world
    ez.Cls()
    ez.Cls(ez.RGB(0,0,255))
    --ez.SetBmFont(1)
    --ez.SetFtFont(2,30)
    ez.SetColor(ez.RGB(0,0,0))
    ez.SetXY(100,100)
    print("Hello World!!!")
    a=100
    b=20
    c=a/b
    print(c)
end
function errorHandler(errmsg)
    print(debug.traceback())
    print(errmsg)
end
-- Call mainFunction() protected by errorHandler
rc, err = xpcall(function() mainFunction() end, errorHandler)
