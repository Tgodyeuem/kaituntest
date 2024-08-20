local ConfigName = 'WhatABadConfig'..game.Players.LocalPlayer.Name..'.json'
local HttpService = game:GetService("HttpService")
getgenv().Config = {} 
function SaveConfig()
    writefile(ConfigName,HttpService:JSONEncode(getgenv().Config))
end
function LoadConfig()
    local IsFile,Data = pcall(function()
        return HttpService:JSONDecode(readfile(ConfigName))
    end)
    if IsFile then 
        getgenv().Config = Data 
        return Data 
    else
        SaveConfig()
        LoadConfig()
    end
end
LoadConfig()
task.delay(.1,function()
    while task.wait(.5) do 
        SaveConfig()
    end
end)  
getgenv().LoadedData = true
warn('Loaded Data!')