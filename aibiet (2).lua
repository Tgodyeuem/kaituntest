local CommitID = '6626b37924005d6090d09808aaaaf570116a3590'
local CommitID = '9f1d465ee1e0b266002231869b06ccd227e975b3'
function LoadSI(ScriptName,commit)
    if not commit then commit = CommitID end 
    if not commit then commit = 'main' end
    local scripturl = 'https://raw.githubusercontent.com/Tgodyeuem/kaituntest/'..commit..'/'..ScriptName
    loadstring(game:HttpGet(scripturl))()
end 
LoadSI('StatusGuiV2.lua')
LoadSI('EnviromentFunctionBF.lua')
LoadSI('AutoL.lua') 
LoadSI('Checks.lua')
LoadSI('ConfigLoader.lua')
task.spawn(function()
    LoadSI('FpsBoost.lua')
end)
task.spawn(function()
    game.Players.LocalPlayer.Character:FindFirstChild("Fast Attack Delay").Value = 0.2
    game.Players.LocalPlayer.Character:FindFirstChild("Fast Attack").Value = false
    game.Players.LocalPlayer.Data.Level:GetPropertyChangedSignal('Value'):Connect(autoStats) 
    local CodesHttp = game:HttpGet("https://raw.githubusercontent.com/Tgodyeuem/kaituntest/main/BloxFruitCodes.lua.txt")
    CodesHttp = CodesHttp:split(" ")
    if not CodesHttp or typeof(CodesHttp) ~= 'table' then return end
    for i,v in pairs(CodesHttp) do 
        if #v > 0 then 
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(v)
        end
    end 
end)  
if queue_on_teleport then 
    queue_on_teleport([[
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Tgodyeuem/kaituntest/main/aibiet (2).lua'))()
    ]])	
end
getgenv().SnipeFruit = true
getgenv().FruitSniping = {
    'T-Rex-T-Rex',
    'Venom-Venom'
}
local LastWarn = tick()-1 
getgenv().LastTask = ''
while task.wait() do 
    task.wait()
    if (getgenv().CurrentTask and getgenv().CurrentTask ~= '') or (getgenv().MeleeTask ~= '' and getgenv().MeleeTask ~= 'None') then 
        if tick()-LastWarn > .5 and getgenv().LastTask ~= getgenv().CurrentTask then 
            warn('Current task:',getgenv().CurrentTask,getgenv().MeleeTask) 
            getgenv().LastTask = getgenv().CurrentTask 
            LastWarn =tick() 
        end
        if getgenv().MeleeTask and getgenv().MeleeTask ~= '' and getgenv().MeleeTask ~= 'None' then 
            AutoMeleeFunc()
        elseif getgenv().CurrentTask == 'Auto Raid' then 
            AutoRaid() 
        elseif getgenv().CurrentTask == '3rd Sea Event' then 
            Auto3rdEvent()
        elseif getgenv().CurrentTask == "Saber Quest" then 
            AutoSaber()
        elseif getgenv().CurrentTask == 'Pole Quest' then 
            AutoPole()
        elseif getgenv().CurrentTask == 'Sea 2 Quest' then 
            AutoSea2()
        elseif getgenv().CurrentTask == 'Bartilo Quest' then 
            AutoBartiloQuest()
        elseif getgenv().CurrentTask == 'Race V2 Quest' then
            AutoRaceV2() 
        elseif getgenv().CurrentTask == 'Eat Fruit' then 
            eatFruit(getgenv().FruitSniping,getgenv().IncludeStored) 
        elseif getgenv().CurrentTask == 'Auto Sea 3' then 
            AutoSea3()
        elseif getgenv().CurrentTask == 'Collect Fruit' then  
            collectAllFruit_Store()
        elseif getgenv().CurrentTask == 'Hunting Elite' then 
            AutoElite() 
        elseif getgenv().CurrentTask == 'Getting Yama' then
            AutoYama() 
        end 
    else 
        AutoL()
    end
end
