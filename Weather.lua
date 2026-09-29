function getWeather()
    if detector.isSunny() then return 0 end
    if detector.isRaining() then return 1 end
    if detector.isThundering() then return 2 end
end

weather = getWeather()


while sleep(1) do
    time = detector.getTime()
    weather = getWeather()
    if target["time"] ~= -1 and time then
        
    end
    if target["weather"] ~= -1 then
        
    end
end