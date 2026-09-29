local chat = peripheral.find("chat_box")

--WeatherBot
local detector = peripheral.find("environmentDetector")
local time = detector.getTime()
local weather
local target = {
    ["time"] = -1,
    ["weather"] = -1
}
weatherkey = {
    [0] = "clear",
    ["clear"] = 0,
    [1] = "raining",
    ["raining"] = 1,
    [2] = "thunder",
    ["thunder"] = 2
}


if not chat then
    print("chatbox error")
    return
end
print("Chat Initialized")
 
 
function ParseCommand(args)
    if args[1] == "!weather" or args[1] == "!Weather" then
        if #args == 1 then
        chat.sendMessage("Expected following arguments, for help use !weather help", "WeatherBot")
        return
        end
        if args[2] == "help" then
            chat.sendMessage([=[
Weather: weather [command] [args]  
Set weather state to mantain it until further notice
Handles both daytime and weather states as seperate conditions to maintain

[command]

query [target]: Operates on target state
current [target]: Operates on current weather state
stop [target]: Stops target
set [state]: sets state, adapts based on state
 
[state]

clear
raining
thunder
 
day
night

[target]

weather
time


]=], "WeatherBot")
        elseif args[2] == "query" then
            local state
            if args[3] == "weather" then
                state = weatherkey[weather]
            elseif args[3] == time then
                state = time
            else
                chat.sendMessage(string.format("\"%s\" not valid [target]"), "WeatherBot")
                return
            end
            chat.sendMessage(state,"WeatherBot")
        else
        chat.sendMessage(string.format("Could not parse argument \"%s\"", args[2]),"WeatherBot")
        end 
    end
end


local CommandBot = function()
    while true do

        local event, arg1, arg2,arg3 = os.pullEvent()

        if event:find("chat") then

            local username, message = arg1, arg2
            print(string.format("[%s]: %s", username, message))
            if string.sub(message,1,1) == "!" then -- detect that its command
                local args = {}
                for token in string.gmatch(message, "%S+") do
                    table.insert(args, token)
                end
                ParseCommand(args)
            end
        end

    end
end
local WeatherWorker = function() dofile("Weather.lua") end
parallel.waitForAny(CommandBot, WeatherWorker)
chat.sendMessage("A command worker has crashed", "ERROR")



