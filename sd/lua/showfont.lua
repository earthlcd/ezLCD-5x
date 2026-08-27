-- showfont.lua - Demonstrate how to load and use fonts.

function showfont(fn,t) -- function to show sample font example fn is font number t is font name
    ez.Cls(ez.RGB(0,0,0))
    ez.SetColor(ez.RGB(255,255,255))
    ez.SetFtFont(1,14,0)
    print("                1000's of Scalable Fonts")
    print("         OpenType - TrueType Compatible")
    ez.SetFtFont(fn,16,0)
    print()
    print(t)
    print()
    print(" 0123456789")
    print(" ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    print(" abcdefghijklmnopqrstuvwxyz")
    print(" The quick way to a touchscreen")
    print(" product is ezLCD!")
    ez.SetFtFont(fn,44,0)
    print("ABCDefgh")
    ez.Wait_ms(2500)
end

---main program 1 4 6 11 14 17 25 28
showfont(0,"Open Sans Regular") -- 
showfont(1,"PTSeriBold")
showfont(2,"Unispace Regular")
showfont(3,"Steel fishRegular")
showfont(4,"Comic Regular")
showfont(5,"Garmond Regular")
showfont(6,"Tahoma Bold")
showfont(7,"Verdana Regular")
