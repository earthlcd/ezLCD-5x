-- gasout meter/guage
-- 'animotion' play group of images as short motion sequence like a gif or movieclip
-- todo use index for pics, make it a function, do version that reads from SD card (put icon)
-- todo use timer to calculate frames per second
delay  = 100	-- set frame delay in milliseconds
for loop = 1,5,1 -- show it a 10 times
do
    for image = 0,29,1  -- Choose images 0-29 incremental by 1
    do
        filename = string.format("/gas/g-%d.jpg", image)
        ez.PutPictFile(0,0,filename) -- draw image n (can be bmp or jpg) jpg will be much faster
        ez.Wait_ms(delay)	-- delay display of next frame
    end
    for image = 29,0,-1  -- Choose images 0-29 decremental by 1
    do
        filename = string.format("/gas/g-%d.jpg", image)
        ez.PutPictFile(0,0,filename) -- draw image n (can be bmp or jpg) jpg will be much faster
        ez.Wait_ms(delay)	-- delay display of next frame
    end
end
--
--
delay = 10
for loop = 1,5,1 -- show it a 10 times
do
    for image = 0,29,1  -- Choose images 0-29 incremental by 1
    do
        filename = string.format("/gas/g-%d.jpg", image)
        ez.PutPictFile(0,0,filename) -- draw image n (can be bmp or jpg) jpg will be much faster
        ez.Wait_ms(delay)	-- delay display of next frame
    end
    for image = 29,0,-1  -- Choose images 0-29 decremental by 1
    do
        filename = string.format("/gas/g-%d.jpg", image)
        ez.PutPictFile(0,0,filename) -- draw image n (can be bmp or jpg) jpg will be much faster
        ez.Wait_ms(delay)	-- delay display of next frame
    end
end






