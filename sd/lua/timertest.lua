function MyInterrupt()
      print("Tick");
	  cnt=cnt+1
end
     
function mainFunction()	 
	cnt=0
	
	ez.Cls(ez.RGB(0,0,128))
	ez.SetColor(ez.RGB(255,215,0))
	ez.SetXY(0,100)

	timno=ez.Timer(1000, "MyInterrupt")
	ez.TimerStart(timno)

	while (1) do
		if cnt>10 then
			ez.TimerStop(timno)
			return
		end
	end
end

function errorHandler(errmsg)
	print(debug.traceback())
	print(errmsg)
end

-- Call mainFunction() protected by errorHandler
rc, err = xpcall(function() mainFunction() end, errorHandler)

