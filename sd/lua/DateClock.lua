-- Read the OS Date / Time and display it on the LCD

ez.SetColor(ez.RGB(0,255,0)) -- Set Drawing Color (foreground) to Green

  ::Start::
    ez.Cls(ez.RGB(0,0,0))        -- Set Screen (background) to Black
    ez.SetFtFont(0,50,0)         --
    ez.SetXY(10,100) -- Set X, Y start location

    print(os.date("%H:%M:%S %p"));

    ez.SetFtFont(0,30,0)         --
    ez.SetXY(30,180) -- Set X, Y start location

    print(os.date("%a, %b. %d, %Y"));

    ez.Wait_ms(1000)
  goto Start

-- end

