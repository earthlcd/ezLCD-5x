-- Display pictures by number assigned in config.txt.
-- When possible load images by file name with PutPictFile() instead to improve boot times

::start::
    for picture = 0, 255, 1 do
        -- Clear the screen
        ez.Cls(ez.RGB(0,0,0))
        -- Display the picture number
        ez.SetXY(ez.Width//2,ez.Height//2)
        print(string.format("%d", picture))
        ez.Wait_ms(500)

        -- Display the picture
        ez.SetXY(0,0)
        if ez.PutPictNo(picture) == true then
            ez.Wait_ms(1500)
        end
    end
goto start

