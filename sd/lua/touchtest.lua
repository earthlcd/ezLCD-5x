function TouchTest() -- should print boolean for whether or not the screen is touched, and the XY of the last touch
    ez.SetDrawFrame(ez.GetNoOfFrames() - 1)

    if ez.TouchDn() then
        ez.Cls(0xffffff)
        ez.SetXY(0,0)
        print("Touched at: (" .. ez.GetTouchX() .. ", " .. ez.GetTouchY() .. ")")
    else
        ez.Cls(0xffffff)
        ez.SetXY(0,0)
        print("Waiting for touch")
    end

    ez.CopyFrame(0,ez.GetNoOfFrames() -1)
end

ez.SetFtFont(0,48,48)
ez.Timer(10,"TouchTest")

while true do end