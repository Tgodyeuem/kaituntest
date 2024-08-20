local CommitID = '146306d7bc15cdbead017f08b3081964a8deffff'
function LoadSI(ScriptName,commit)
    if not commit then commit = CommitID end 
    if not commit then commit = 'main' end
    local scripturl = 'https://raw.githubusercontent.com/Tgodyeuem/kaituntest/'..commit..'/'..ScriptName
    loadstring(game:HttpGet(scripturl))()
end
LoadSI('NewFastAttackLoader.lua')
LoadSI('StatusGuiV2.lua')
LoadSI('EnviromentFunctionBF.lua')
LoadSI('ConfigLoader.lua')
LoadSI('AutoL.lua')  
LoadSI('Checks.lua') 
task.spawn(function()
    LoadSI('FpsBoost.lua')
end)
task.spawn(function()
    game.Players.LocalPlayer.Data.Level:GetPropertyChangedSignal('Value'):Connect(autoStats) 
    local CodesHttp = game:HttpGet("https://raw.githubusercontent.com/Tgodyeuem/kaituntest/main/BloxFruitCodes.lua")
    CodesHttp = CodesHttp:split(" ")
    if not CodesHttp or typeof(CodesHttp) ~= 'table' then return end
    for i,v in pairs(CodesHttp) do 
        if #v > 0 then 
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(v)
        end
    end 
end)  
____QueueOnTeleport = queue_on_teleport or queue_on_tp or function() end
if ____QueueOnTeleport then 
    ____QueueOnTeleport([[
        --loadstring(game:HttpGet("https://raw.githubusercontent.com/Tgodyeuem/kaituntest/main/Kaitun.lua"))()
    ]])
end 
getgenv().SnipeFruit = true
getgenv().FruitSniping = {
    'T-Rex-T-Rex',
    'Venom-Venom'
}
local LastWarn = tick()-1 
local NoneTick = tick()
getgenv().LastTask = '' 
repeat task.wait() until getgenv().LoadedData
wait(.5)
while task.wait() do 
    task.wait()
    if (getgenv().CurrentTask and getgenv().CurrentTask ~= '') or (getgenv().MeleeTask ~= '' and getgenv().MeleeTask ~= 'None') then  
        NoneTick = tick()
        if tick()-LastWarn > .5 and getgenv().LastTask ~= getgenv().CurrentTask then 
            warn('Current task:',getgenv().CurrentTask,getgenv().MeleeTask) 
            getgenv().LastTask = getgenv().CurrentTask 
            LastWarn =tick() 
        end
        if not (getgenv().ServerData["PlayerBackpack"]['Special Microchip'] or CheckIsRaiding()) and getgenv().MeleeTask and getgenv().MeleeTask ~= '' and getgenv().MeleeTask ~= 'None' then 
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
        elseif getgenv().CurrentTask == 'Getting Tushita' then 
            AutoTushita()
        elseif getgenv().CurrentTask == 'Hunting Elite' then 
            AutoElite() 
        elseif getgenv().CurrentTask == 'Getting Soul Guitar' then
            AutoSoulGuitar()
        elseif getgenv().CurrentTask == 'Getting Yama' then 
            AutoYama() 
        elseif getgenv().CurrentTask == 'Auto Raid Boss' then 
            AutoRaidBoss()
        elseif getgenv().CurrentTask == 'Getting Hallow Scythe' then 
            AutoHallowScythe()
        elseif getgenv().CurrentTask == 'Cake Prince Raid Boss Event' then  
            AutoCakePrinceEvent() 
        elseif getgenv().CurrentTask == 'Getting Cursed Dual Katana' then 
            AutoCDK(getgenv().CDKQuest)
        elseif getgenv().CurrentTask == 'Auto Raid Boss' then 
            AutoRaidBoss() 
        elseif getgenv().CurrentTask == 'Auto Race V3' then  
            AutoV3()
        elseif getgenv().CurrentTask == "Using God's Chalice" then 
            AutoUseGodChalice()
        elseif getgenv().CurrentTask == 'Auto Dough King' then 
            AutoDoughKing()
        end  
    elseif tick()-NoneTick >= 5 then
        AutoL()
    end
end
