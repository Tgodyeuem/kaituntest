repeat task.wait() until getgenv().EnLoaded 
getgenv().CurrentTask = ""  
getgenv().TaskUpdateTick = tick()  
getgenv().PirateRaidTick = 0
function refreshTask() 
    if tick()-getgenv().TaskUpdateTick >= 60 then 
        getgenv().CurrentTask = ''
    end
    if getgenv().CurrentTask == '' then  
        if getgenv().ServerData["PlayerBackpack"]['Special Microchip'] or CheckIsRaiding() then 
            getgenv().CurrentTask = 'Auto Raid'
        elseif getgenv().ServerData['PlayerData'].DevilFruit == '' and getgenv().SnipeFruit and getgenv().FruitSniping and checkFruittoEat(getgenv().FruitSniping,getgenv().IncludeStored) then 
            getgenv().CurrentTask = 'Eat Fruit'
        elseif #getgenv().ServerData['Workspace Fruits'] > 0 then 
            getgenv().CurrentTask = 'Collect Fruit' 
        elseif Sea3 and getgenv().CurrentElite then 
            getgenv().CurrentTask = 'Hunting Elite'  
        elseif Sea3 and getgenv().ServerData['PlayerData'].Level >= 2000 and not getgenv().ServerData["Inventory Items"]["Tushita"] and (getgenv().ServerData['Server Bosses']['rip_indra True Form'] or (not game:GetService("Workspace").Map.Turtle:FindFirstChild("TushitaGate"))) then 
            getgenv().CurrentTask = 'Getting Tushita'
        elseif Sea3 and not getgenv().ServerData["Inventory Items"]["Yama"] and (getgenv().ServerData['PlayerData']["Elite Hunted"] >= 30 or getgenv().ServerData['PlayerData'].Level >= 2100) then 
            getgenv().CurrentTask = 'Getting Yama' 
        elseif Sea3 and getgenv().CDKQuest and getgenv().CDKQuest ~= '' then 
            getgenv().CurrentTask = 'Getting Cursed Dual Katana' 
        elseif (Sea2 or Sea3) and getgenv().ServerData['PlayerData'].Beli >= 2000000 and getgenv().ServerData['PlayerData'].Level >= 2550 and not table.find({'Skypiea',"Fishman","Ghoul"},getgenv().ServerData['PlayerData'].Race) and (getgenv().ServerData['PlayerData'].RaceVer == 'V2') then 
            getgenv().CurrentTask = 'Auto Race V3'
        elseif getgenv().ServerData['PlayerData'].Level > 200  and not getgenv().ServerData["Inventory Items"]["Saber"] then 
            getgenv().CurrentTask = 'Saber Quest'
        elseif getgenv().Config and getgenv().Config["Melee Level Values"] and getgenv().Config["Melee Level Values"]['Godhuman'] > 0 and getgenv().ServerData['PlayerData'].Level >= 2300 and not getgenv().ServerData["Inventory Items"]["Soul Guitar"] then 
            getgenv().CurrentTask = 'Getting Soul Guitar'
        elseif Sea3 and (getgenv().HallowEssence or getgenv().SoulReaper or getgenv().ServerData['Server Bosses']['Soul Reaper'] or getgenv().ServerData["PlayerBackpack"]['Hallow Essence']) then 
            getgenv().CurrentTask = 'Getting Hallow Scythe'
        elseif Sea3 and getgenv().ServerData['PlayerData'].Level > 2550 and not getgenv().ServerData["Inventory Items"]["Mirror Fractal"] then
            getgenv().CurrentTask = 'Auto Dough King'
        elseif getgenv().ServerData['PlayerData'].Level > 150 
        and not getgenv().ServerData["Inventory Items"]["Pole (1st Form)"] 
        and (getgenv().ServerData['Server Bosses']['Thunder God']) then 
            getgenv().CurrentTask = 'Pole Quest'
        elseif Sea1 and getgenv().ServerData['PlayerData'].Level >= 700 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then 
            getgenv().CurrentTask = 'Sea 2 Quest'
        elseif Sea3 and (getgenv().CakePrince or (getgenv().ServerData['Server Bosses']['Cake Prince'] or getgenv().ServerData['Server Bosses']['Dough King'] ))  then 
            getgenv().CurrentTask = 'Cake Prince Raid Boss Event'
        elseif (Sea2 or Sea3) and (getgenv().ServerData['Server Bosses']['Core'] or (Sea3 and getgenv().PirateRaidTick and tick()-getgenv().PirateRaidTick < 60)) then 
            getgenv().CurrentTask = '3rd Sea Event'
        elseif Sea2 and getgenv().ServerData['PlayerData'].Level >= 850 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") ~= 3 then
            getgenv().CurrentTask = 'Bartilo Quest'
        elseif Sea2 and getgenv().ServerData['PlayerData'].Level >= 1500 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Zou") ~= 0 then 
            getgenv().CurrentTask = 'Auto Sea 3' 
        elseif (Sea2 or Sea3) and (getgenv().RaidBossEvent or getgenv().ServerData['Server Bosses']['Darkbeard'] or getgenv().ServerData['Server Bosses']['rip_indra True Form']) then 
            getgenv().CurrentTask = 'Auto Raid Boss' 
        elseif Sea3 and (getgenv().ServerData['PlayerBackpack']["God's Chalice"] and (not UnCompleteColor() or HasColor(UnCompleteColor().BrickColor.Name))) then 
            getgenv().CurrentTask = "Using God's Chalice"
        elseif getgenv().ServerData['PlayerData'].Beli >= 500000 and getgenv().ServerData["Inventory Items"]["Warrior Helmet"] and getgenv().ServerData['PlayerData'].RaceVer == 'V1' then 
            getgenv().CurrentTask = 'Race V2 Quest' 
        end  
        getgenv().TaskUpdateTick = tick()
    end
end 
if hookfunction then 
    hookfunction(require(game.ReplicatedStorage.Notification).new,function(v1,v2) 
        v1 = tostring(v1):gsub("<Color=[^>]+>", "") 
        local Nof = game.Players.LocalPlayer.Character:FindFirstChild('Notify') or (function() 
            if not game.Players.LocalPlayer.Character:FindFirstChild('Notify') then 
                local nof = Instance.new('StringValue',game.Players.LocalPlayer.Character)
                nof.Name = 'Notify'
                nof.Value = ''
                return nof
            end 
        end)()
        Nof.Value = v1 
        local FakeLOL = {}
        function FakeLOL.Display(p18)
            return true;
        end; 
        function FakeLOL.Dead()
        end
        return FakeLOL
    end)   
    task.delay(5,function() 
        warn('Disabling effects') 
        if hookfunction and not islclosure(hookfunction) then 
            --[[
                        for i,v in pairs(require(game.ReplicatedStorage.Effect.Container.Misc.Damage)) do 
                if typeof(v) == 'function' then 
                    hookfunction(
                        v, 
                        function()
                            return {
                                Run = function() end,
                                Stop = function() end,
                            }
                        end
                    )
                end
            end 
            ]]
            for i,v in pairs(game.ReplicatedStorage.Assets.GUI:GetChildren()) do 
                v.Enabled = false 
            end
            hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death), function()end)
            hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Respawn), function()end)
            hookfunction(require(game:GetService("ReplicatedStorage"):WaitForChild("GuideModule")).ChangeDisplayedNPC,function() end)
            task.spawn(function()
                local NGU,NGUVL
                repeat 
                    NGU,NGUVL = pcall(function()
                        for i,v in pairs(getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))[2].activeController.data) do  
                            if typeof(v) == 'function' then 
                                hookfunction(v,function() end )
                            end
                        end
                    end)
                    task.wait(1.5)
                    NGU,NGUVL = pcall(function()
                        for i,v in pairs(getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))[2].activeController.data) do  
                            if typeof(v) == 'function' then 
                                hookfunction(v,function() end )
                            end
                        end
                    end)
                    NGU,NGUVL = pcall(function()
                        for i,v in pairs(getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))[2].activeController.data) do  
                            if typeof(v) == 'function' then 
                                hookfunction(v,function() end )
                            end
                        end
                    end)
                    NGU,NGUVL = pcall(function()
                        for i,v in pairs(getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))[2].activeController.data) do  
                            if typeof(v) == 'function' then 
                                hookfunction(v,function() end )
                            end
                        end
                    end)
                until NGU 
            end) 
            task.delay(0.1,function()
                for i,v2 in pairs(game.ReplicatedStorage.Effect.Container:GetDescendants()) do 
                    pcall(function()
                        if v2.ClassName =='ModuleScript' and typeof(require(v2)) == 'function' then 
                            hookfunction(require(v2),function()end) 
                            task.wait(1)
                        end
                    end)
                end
            end)
        end
    end)
end
local rF1,rF2 
task.delay(.1,function()
    while task.wait(.5) do 
        task.wait()
        rF1,rF2  = pcall(function()
            refreshTask() 
        end)
        if not rF1 then 
            warn('Refreshing task error:',rF2)
        end
    end
end)    
getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(
    child)
    if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
        wait()
        local CurrentErrorTitle = child.TitleFrame.ErrorTitle.Text
        local CurrentErrorMessage = child.MessageArea.ErrorFrame.ErrorMessage.Text 
        if CurrentErrorTitle ~= 'Teleport Failed' and not Hopping then 
            Hopping = true 
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)  
        end
    end
end)
AutoDoughKing = function()
    if getgenv().ServerData['Server Bosses']['Dough King'] then 
        KillBoss(getgenv().ServerData['Server Bosses']['Dough King'])
    elseif getgenv().ServerData["PlayerBackpack"]['Sweet Chalice'] then 
        local MobLeft = tonumber(string.match(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true),'%d+')) or 0
        task.spawn(function()
            if MobLeft <= 8 then
                if not getgenv().SpamSpawnCakePrince then 
                    getgenv().SpamSpawnCakePrince = game.RunService.Heartbeat:Connect(function()
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner") 
                    end)
                end
            elseif MobLeft >= 400 then 
                if getgenv().SpamSpawnCakePrince then 
                    getgenv().SpamSpawnCakePrince:Disconnect()
                    getgenv().SpamSpawnCakePrince = nil 
                end
            end
        end)
        if MobLeft > 1 then 
            KillMobList({
                "Cookie Crafter",
                "Cake Guard",
                "Head Baker",
                "Baking Staff"
            })
        end
    elseif getgenv().ServerData["PlayerBackpack"]["God's Chalice"] then 
        if CheckMaterialCount('Conjured Cocoa') >= 10 then 
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
        else
            KillMobList({
                "Cocoa Warrior",
                "Chocolate Bar Battler"
            })
        end
    elseif CheckMaterialCount('Conjured Cocoa') < 10 then 
        KillMobList({
            "Cocoa Warrior",
            "Chocolate Bar Battler"
        })
    else
        if getgenv().CurrentElite then 
            KillBoss(getgenv().CurrentElite)
            return
        else
            HopServer(10,true,'Elite (Auto Dough King)')
        end
    end
end
AutoV3 = function()  
    if getgenv().ServerData['PlayerData'].RaceVer == "V3" then 
        getgenv().CurrentTask = ''
        return 
    elseif getgenv().ServerData['PlayerData'].Beli <2000000 then 
        getgenv().CurrentTask = ''
        return 
    elseif not Sea2 then 
        TeleportWorld(2)
    else 
        local CurrentR = getgenv().ServerData['PlayerData'].Race  
        local v113 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
        if v113 == 0 then
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
        end
        if CurrentR == 'Human' then  
            if getgenv().ServerData['Server Bosses']['Diamond'] and getgenv().ServerData['Server Bosses']['Jeremy'] and getgenv().ServerData['Server Bosses']['Fajita'] then 
                repeat 
                    task.wait() 
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3")
                    if getgenv().ServerData['Server Bosses']['Diamond'] then 
                        KillBoss(getgenv().ServerData['Server Bosses']['Diamond'])
                    elseif getgenv().ServerData['Server Bosses']['Jeremy'] then 
                        KillBoss(getgenv().ServerData['Server Bosses']['Jeremy'])
                    elseif getgenv().ServerData['Server Bosses']['Fajita'] then 
                        KillBoss(getgenv().ServerData['Server Bosses']['Fajita']) 
                    end
                until not getgenv().ServerData['Server Bosses']['Diamond'] and not getgenv().ServerData['Server Bosses']['Jeremy'] and not getgenv().ServerData['Server Bosses']['Fajita'] 
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3")
                SetContent('NIGGA ON FIRE 🔥🔥🔥')
                TeleportWorld(3)
            else
                HopServer(10,true,"Find 3 bosses to get Human V3")
            end 
        elseif CurrentR == 'Cyborg' then  
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3") 
            local CheckAgain = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
            if CheckAgain and CheckAgain == 1 then 
                local FruitBelow1M = getFruitBelow1M()
                if FruitBelow1M then 
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", FruitBelow1M) 
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3") 
                end 
            end 
        elseif CurrentR == 'Mink' then 
            repeat 
                local NearestChest = getNearestChest()
                if NearestChest then 
                    PickChest(NearestChest) 
                else
                    warn('Not Chest')
                end 
                task.wait(.1)
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3") 
            until game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") ~= 1
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3") 
        end
    end
end
AutoCDK = function(questTitle) 
    SetContent(questTitle)
    getgenv().WeaponType = 'Sword'
    LoadItem('Tushita')
    if questTitle == 'The Final Boss' then  
        repeat task.wait()
            if GetDistance(game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3) > 10 and game:GetService("Workspace").Map.Turtle.Cursed.PlacedGem.Transparency ~= 0 then
                Tweento(game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.CFrame * CFrame.new(0, 0, -2)) 
            end 
            if game:GetService("Workspace").Map.Turtle.Cursed.PlacedGem.Transparency == 0 then 
                if not getgenv().ServerData['Server Bosses']['Cursed Skeleton Boss'] then
                    Tweento(CFrame.new(-12341.66796875, 603.3455810546875, -6550.6064453125))
                else
                    KillBoss(getgenv().ServerData['Server Bosses']['Cursed Skeleton Boss'])
                    getgenv().CurrentTask = ''
                end
            else 
                if GetDistance(game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3) < 10 and game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.ProximityPrompt.Enabled then 
                    fireproximityprompt(game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.ProximityPrompt) 
                    wait(10)
                end
            end 
        until CheckItem("Cursed Dual Katana")
    elseif questTitle == 'Pedestal1' then 
        if GetDistance(game:GetService("Workspace").Map.Turtle.Cursed["Pedestal1"]) < 10 then
            fireproximityprompt(game:GetService("Workspace").Map.Turtle.Cursed['Pedestal1'].ProximityPrompt)
        else
            Tweento(game:GetService("Workspace").Map.Turtle.Cursed['Pedestal1'].CFrame * CFrame.new(0, 0, -2))
        end
    elseif questTitle == 'Pedestal2' then  
        if GetDistance(game:GetService("Workspace").Map.Turtle.Cursed["Pedestal2"]) < 10 then
            fireproximityprompt(game:GetService("Workspace").Map.Turtle.Cursed['Pedestal2'].ProximityPrompt)
        else
            Tweento(game:GetService("Workspace").Map.Turtle.Cursed['Pedestal2'].CFrame * CFrame.new(0, 0, -2))
        end
    elseif questTitle == 'Tushita Dimension' then
        repeat task.wait()
            if game:GetService("Workspace").Map.HeavenlyDimension.Exit.BrickColor == BrickColor.new("Cloudy grey") then 
                Tweento(game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame)
                wait(2) 
            else
                if CheckTorchDimension("Tushita") then 
                    local Torch = CheckTorchDimension("Tushita")
                    Tweento(Torch.CFrame)  
                    wait(.5)
                    fireproximityprompt(Torch.ProximityPrompt)  
                    local CurrentCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
                    local TickTorch = tick()
                    repeat task.wait()
                        for i,v in pairs(workspace.Enemies:GetChildren()) do 
                            pcall(function()
                                if v:FindFirstChildOfClass('Humanoid') then 
                                    v:FindFirstChildOfClass('Humanoid').Health = 0 
                                end
                            end) 
                        end
                        Tweento(CurrentCFrame * CFrame.new(0,250,0))
                    until #game.workspace.Enemies:GetChildren() <= 0 and tick()-TickTorch >= 5
                    Tweento(CurrentCFrame)
                end
            end
            task.wait()
        until not IsPlayerAlive() or GetDistance(game:GetService("Workspace")["_WorldOrigin"].Locations["Heavenly Dimension"]) > 2000
    elseif questTitle == 'Cake Queen' then 
        if getgenv().ServerData['Server Bosses']['Cake Queen'] then 
            CDKTICK = tick()
            repeat task.wait()
                KillBoss(getgenv().ServerData['Server Bosses']['Cake Queen'])  
                wait(1)
            until GetDistance(game:GetService("Workspace")["_WorldOrigin"].Locations["Heavenly Dimension"]) <= 2000
            getgenv().CDKQuest = 'Tushita Dimension'
        else
            SetContent('Hopping for Cake Quen',5)
            HopServer(10,true,"Cake Queen")
        end 
    elseif questTitle == 'Tushita Quest -4' then 
        if getgenv().PirateRaidTick and tick()-getgenv().PirateRaidTick < 60 then 
            Auto3rdEvent() 
        else
            AutoL()
        end
    elseif questTitle == 'Tushita Quest -3' then 
        for v50, v51 in pairs(getnilinstances()) do
            if v51.Name:match("Luxury Boat Dealer") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v51.HumanoidRootPart.CFrame
                local args = {
                    [1] = "CDKQuest",
                    [2] = "BoatQuest",
                    [3] = workspace.NPCs:FindFirstChild("Luxury Boat Dealer")
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
        end
    elseif questTitle == 'Yama Dimension' then 
        repeat task.wait()
            if game:GetService("Workspace").Map.HellDimension.Exit.BrickColor == BrickColor.new("Olivine") then 
                Tweento(game:GetService("Workspace").Map.HellDimension.Exit.CFrame)
                wait(2) 
            else 
                if CheckTorchDimension("Yama") then 
                    local Torch = CheckTorchDimension("Yama")
                    Tweento(Torch.CFrame)  
                    wait(.5)
                    fireproximityprompt(Torch.ProximityPrompt)  
                    local CurrentCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
                    local TickTorch = tick()
                    repeat task.wait()
                        for i,v in pairs(workspace.Enemies:GetChildren()) do 
                            pcall(function()
                                if v:FindFirstChildOfClass('Humanoid') then 
                                    v:FindFirstChildOfClass('Humanoid').Health = 0 
                                end
                            end)  
                        end
                        Tweento(CurrentCFrame * CFrame.new(0,250,0))
                    until #game.workspace.Enemies:GetChildren() <= 0 and tick()-TickTorch >= 5
                    Tweento(CurrentCFrame)
                end
            end
        until GetDistance(game:GetService("Workspace")["_WorldOrigin"].Locations["Hell Dimension"]) > 2000 
    elseif questTitle == 'Soul Reaper' then 
        if getgenv().ServerData['Server Bosses']['Soul Reaper'] then 
            repeat 
                if not getgenv().DimensionLoading and not (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild('Hell Dimension') or GetDistance(game:GetService("Workspace")["_WorldOrigin"].Locations["Hell Dimension"]) <    2000) then 
                    if GetDistance(getgenv().ServerData['Server Bosses']['Soul Reaper'].PrimaryPart) > 300 then 
                        Tweento(getgenv().ServerData['Server Bosses']['Soul Reaper'].PrimaryPart.CFrame * CFrame.new(0,1.5,-1.5)) 
                        wait(3)
                    else
                        game.Players.LocalPlayer.Character.PrimaryPart.CFrame = getgenv().ServerData['Server Bosses']['Soul Reaper'].PrimaryPart.CFrame * CFrame.new(0,1.5,-1.5) 
                    end  
                end
            until getgenv().DimensionLoading or (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild('Hell Dimension') and GetDistance(game:GetService("Workspace")["_WorldOrigin"].Locations["Hell Dimension"]) <= 2000) 
            if getgenv().DimensionLoading then 
                getgenv().DimensionLoading = false 
                wait(5)
            end
        elseif getgenv().ServerData["PlayerBackpack"]['Hallow Essence'] then 
            EquipWeapon("Hallow Essence")
            Tweento(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
        else
            local v316, v317, v318, v319 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones", "Check")
            if v318 and v318 > 0 then 
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1) 
                if getgenv().ServerData['PlayerData'].Level >= 2000 then  
                    if not game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("Quest").Visible then 
                        FarmMobByLevel(2000)
                    else 
                        KillMobList({
                            "Reborn Skeleton [Lv. 1975]",
                            "Living Zombie [Lv. 2000]",
                            "Demonic Soul [Lv. 2025]",
                            "Posessed Mummy [Lv. 2050]"
                        })
                    end
                else 
                    KillMobList({
                        "Reborn Skeleton [Lv. 1975]",
                        "Living Zombie [Lv. 2000]",
                        "Demonic Soul [Lv. 2025]",
                        "Posessed Mummy [Lv. 2050]"
                    })
                end
            elseif v316 < 5000 then 
                if getgenv().ServerData['PlayerData'].Level >= 2000 then  
                    if not game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("Quest").Visible then 
                        FarmMobByLevel(2000)
                    else 
                        KillMobList({
                            "Reborn Skeleton [Lv. 1975]",
                            "Living Zombie [Lv. 2000]",
                            "Demonic Soul [Lv. 2025]",
                            "Posessed Mummy [Lv. 2050]"
                        })
                    end
                else 
                    KillMobList({
                        "Reborn Skeleton [Lv. 1975]",
                        "Living Zombie [Lv. 2000]",
                        "Demonic Soul [Lv. 2025]",
                        "Posessed Mummy [Lv. 2050]"
                    })
                end
            end  
        end
    elseif questTitle == 'Yama Quest -4' then 
        local MobSP = NearestHazeMob()
        if MobSP then 
            KillMobList({MobSP})
        end
    elseif questTitle == 'Yama Quest -3' then 
        if FindMobHasHaki() then 
            repeat 
                pcall(function()
                    task.wait()
                    Tweento(FindMobHasHaki().PrimaryPart.CFrame * CFrame.new(0,0,-2))
                end)
            until not IsPlayerAlive()
        end
    end        
end
AutoUseGodChalice = function()
    local UnCompleteColorr = UnCompleteColor()
    if not UnCompleteColorr then 
        EquipWeapon("God's Chalice") 
        Tweento(game:GetService("Workspace").Map["Boat Castle"].Summoner.Detection.CFrame)
        getgenv().CurrentTask = ''
    elseif HasColor(UnCompleteColorr.BrickColor.Name) then
        if UnCompleteColorr then 
            Tweento(UnCompleteColorr.CFrame)
        end
    end
end
AutoRaidBoss = function()
    warn('Auto Raid Boss')
    local RaidBoss = getgenv().ServerData['Server Bosses']['Darkbeard'] or getgenv().ServerData['Server Bosses']['rip_indra True Form']
    if RaidBoss then 
        KillBoss(RaidBoss)
    else
        getgenv().RaidBossEvent =false
        getgenv().CurrentTask = ''
    end
end
AutoCakePrinceEvent = function()
    local CPB = getgenv().ServerData['Server Bosses']['Cake Prince'] or getgenv().ServerData['Server Bosses']['Dough King'] 
    if not CPB or not CPB:FindFirstChildOfClass('Humanoid') then 
        getgenv().CakePrince = false 
        getgenv().CurrentTask =''  
    else  
        KillBoss(CPB)
        getgenv().CurrentTask ='' 
    end
end
AutoHallowScythe = function()
    if getgenv().SoulReaper then 
        if not getgenv().ServerData['Server Bosses']['Soul Reaper'] then 
            getgenv().SoulReaper = false 
        end 
        if getgenv().SoulReaper then 
            KillBoss(getgenv().ServerData['Server Bosses']['Soul Reaper'] )
            getgenv().SoulReaper = false 
            getgenv().CurrentTask =''
        end
    elseif getgenv().HallowEssence then 
        if not getgenv().ServerData["PlayerBackpack"]['Hallow Essence'] then 
            getgenv().SoulReaper = false 
        end
        if getgenv().SoulReaper then 
            EquipWeapon('Hallow Essence') 
            Tweento(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
        end
    end
end
AutoSoulGuitar = function() 
    if Sea1 then 
        TeleportWorld(3)
        return
    end
    local BlankTablets = {
        "Segment6",
        "Segment2",
        "Segment8",
        "Segment9",
        "Segment5"
    }
    local Trophy = {
        ["Segment1"] = "Trophy1",
        ["Segment3"] = "Trophy2",
        ["Segment4"] = "Trophy3",
        ["Segment7"] = "Trophy4",
        ["Segment10"] = "Trophy5",
    }
    local Pipes = {
        ["Part1"] = "Really black",
        ["Part2"] = "Really black",
        ["Part3"] = "Dusty Rose",
        ["Part4"] = "Storm blue",
        ["Part5"] = "Really black",
        ["Part6"] = "Parsley green",
        ["Part7"] = "Really black",
        ["Part8"] = "Dusty Rose",
        ["Part9"] = "Really black",
        ["Part10"] = "Storm blue",
    }
    local CurrnetPuzzle = game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("GuitarPuzzleProgress", "Check")
    if not getgenv().SoulGuitarPuzzlePassed then 
        getgenv().SoulGuitarPuzzlePassed = (function()
            local LLL = CurrnetPuzzle
            return LLL and LLL.Trophies and LLL.Ghost and LLL.Gravestones and LLL.Swamp and LLL.Pipes 
        end)()
    end 
    if not getgenv().SoulGuitarPuzzlePassed then 
        if not CurrnetPuzzle then  
            SetContent("Unlocking Soul Guitar's Puzzle (Praying Grave Stone)",5)
            if not Sea3 then 
                TeleportWorld(3)
            elseif game.Lighting.Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" and (game.Lighting.ClockTime > 15 or game.Lighting.ClockTime < 5) then   
                if game.Lighting.ClockTime > 18 or game.Lighting.ClockTime < 5 then
                    Tweento(CFrame.new(-8654.314453125, 140.9499053955078, 6167.5283203125)) 
                    if GetDistance(CFrame.new(-8654.314453125, 140.9499053955078, 6167.5283203125)) < 10 then
                        CheckRemote = game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("gravestoneEvent", 2) 
                        if CheckRemote ~= true then return end 
                        require(game.ReplicatedStorage.Effect).new("BlindCam"):replicate({
                            Color = Color3.new(0.03, 0.03, 0.03), 
                            Duration = 2, 
                            Fade = 0.25, 
                            ZIndex = -10
                        });
                        require(game.ReplicatedStorage.Util.Sound):Play("Thunder", workspace.CurrentCamera.CFrame.p); 
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
                        SetContent('Completed')  
                        getgenv().CurrentTask = ''
                        return
                    end  
                end
            else 
                HopServer(10,true,"Full Moon")
            end 
        elseif not CurrnetPuzzle.Swamp then  
            SetContent("Unlocking Soul Guitar's Puzzle (Swamp: Kill 6 Zombie at same time)",5)
            if not Sea3 then 
                TeleportWorld(3)
            elseif GetDistance(CFrame.new(-10171.7607421875, 138.62667846679688, 6008.0654296875)) > 300 then
                Tweento(CFrame.new(-10171.7607421875, 138.62667846679688, 6008.0654296875) * CFrame.new(0,25,-20))
            else
                if CheckAnyPlayersInCFrame(CFrame.new(-10171.7607421875, 138.62667846679688, 6008.0654296875), 500) then
                    SetContent('Players In Area | Hopping for peace',5)
                    HopServer(10,true,"Peace Area")
                else
                    if (function() 
                        local Cos = 0   
                        for i ,v in pairs(game.workspace.Enemies:GetChildren()) do 
                            if RemoveLevelTitle(v.Name) == "Living Zombie" and v.Humanoid.Health > 0 then
                                if GetDistance(CFrame.new(-10171.7607421875, 138.62667846679688, 6008.0654296875),v.HumanoidRootPart) <= 20 then 
                                    Cos += 1
                                end
                            end
                        end
                        return Cos
                    end)() == 6 then
                        warn('Zombie Near')
                        for i, v in pairs(game.workspace.Enemies:GetChildren()) do
                            if
                                RemoveLevelTitle(v.Name) == "Living Zombie" and v:FindFirstChild("HumanoidRootPart") and
                                    v:FindFirstChild("Humanoid") and
                                    v.Humanoid.Health > 0
                            then
                                repeat
                                    wait()
                                    KillNigga(v)
                                until v.Humanoid.Health <= 0 or not v.Parent
                            end
                        end
                    else
                        warn('Not 6 Zombie');
                        (function()
                            for i, v in pairs(game.workspace.Enemies:GetChildren()) do
                                if RemoveLevelTitle(v.Name) == "Living Zombie" and v:FindFirstChild("Humanoid") and
                                        v:FindFirstChild("HumanoidRootPart") --and isnetworkowner(v.HumanoidRootPart)
                                    then
                                    v.HumanoidRootPart.CFrame = CFrame.new(-10171.7607421875, 138.62667846679688, 6008.0654296875)
                                    v.Humanoid:ChangeState(14)
                                    v.PrimaryPart.CanCollide = false
                                    v.Head.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.Humanoid.JumpPower = 0
                                    if v.Humanoid:FindFirstChild("Animator") then
                                        v.Humanoid.Animator:Destroy()
                                    end
                                end
                            end
                        end)()
                    end
                end
            end
        elseif not CurrnetPuzzle.Gravestones then 
            SetContent("Unlocking Soul Guitar's Puzzle (Grave Stones: Clicking Signs)")
            if not Sea3 then 
                TeleportWorld(3)
            elseif GetDistance(CFrame.new(-8761.4765625, 142.10487365722656, 6086.07861328125)) > 50 then
                Tweento(CFrame.new(-8761.4765625, 142.10487365722656, 6086.07861328125))
            else
                local ClickSigns = {
                    game.workspace.Map["Haunted Castle"].Placard1.Right.ClickDetector,
                    game.workspace.Map["Haunted Castle"].Placard2.Right.ClickDetector,
                    game.workspace.Map["Haunted Castle"].Placard3.Left.ClickDetector,
                    game.workspace.Map["Haunted Castle"].Placard4.Right.ClickDetector,
                    game.workspace.Map["Haunted Castle"].Placard5.Left.ClickDetector,
                    game.workspace.Map["Haunted Castle"].Placard6.Left.ClickDetector,
                    game.workspace.Map["Haunted Castle"].Placard7.Left.ClickDetector
                }
                for i, v in pairs(ClickSigns) do
                    fireclickdetector(v)
                end
            end  
        elseif not CurrnetPuzzle.Ghost then 
            SetContent("Unlocking Soul Guitar's Puzzle (Ghost: Talking to the ghost)") 
            if not Sea3 then 
                TeleportWorld(3)
            elseif GetDistance(CFrame.new(-9755.6591796875, 271.0661315917969, 6290.61474609375)) > 7 then
                Tweento(CFrame.new(-9755.6591796875, 271.0661315917969, 6290.61474609375))
                game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("GuitarPuzzleProgress", "Ghost") 
                wait(3)
            end 
        elseif not CurrnetPuzzle.Trophies then 
            SetContent("Unlocking Soul Guitar's Puzzle (Trophies: Unlock the Trophies's Puzzle)") 
            if not Sea3 then 
                TeleportWorld(3)
            elseif GetDistance(CFrame.new(-9530.0126953125, 6.104853630065918, 6054.83349609375)) > 30 then
                Tweento(CFrame.new(-9530.0126953125, 6.104853630065918, 6054.83349609375)) 
            else 
                local DepTraiv4 = game.workspace.Map["Haunted Castle"].Tablet
                for i, v in pairs(BlankTablets) do
                    local x = DepTraiv4[v]
                    if x.Line.Position.X ~= 0 then
                        repeat
                            wait()
                            fireclickdetector(x.ClickDetector)
                        until x.Line.Position.X == 0
                    end
                end
                for i, v in pairs(Trophy) do
                    local x = game.workspace.Map["Haunted Castle"].Trophies.Quest[v].Handle.CFrame
                    x = tostring(x)
                    x = x:split(", ")[4]
                    local c = "180"
                    if x == "1" or x == "-1" then
                        c = "90"
                    end
                    if not string.find(tostring(DepTraiv4[i].Line.Rotation.Z), c) then
                        repeat
                            wait()
                            fireclickdetector(DepTraiv4[i].ClickDetector)
                        until string.find(tostring(DepTraiv4[i].Line.Rotation.Z), c)
                    end
                end
            end 
        elseif not CurrnetPuzzle.Pipes then 
            SetContent("Unlocking Soul Guitar's Puzzle (Pipes)") 
            if not Sea3 then 
                TeleportWorld(3)
            else
                for i, v in pairs(Pipes) do
                    pcall(function()
                        local x = game.workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model[i]
                        if x.BrickColor.Name ~= v then
                            repeat
                                wait()
                                fireclickdetector(x.ClickDetector)
                            until x.BrickColor.Name == v
                        end
                    end) 
                end
            end 
        end 
    elseif CheckMaterialCount('Bones') < 500 then  
        SetContent('Farming Bones for soul guitar')
        if not Sea3 then 
            TeleportWorld(3) 
        else
            KillMobList({
                "Reborn Skeleton [Lv. 1975]",
                "Living Zombie [Lv. 2000]",
                "Demonic Soul [Lv. 2025]",
                "Posessed Mummy [Lv. 2050]"
            })
        end
    elseif CheckMaterialCount('Ectoplasm') < 250 then 
        if not Sea2 then 
            TeleportWorld(2)
        else
            KillMobList({
                "Ship Deckhand [Lv. 1250]",
                "Ship Engineer [Lv. 1275]",
                "Ship Steward [Lv. 1300]",
                'Ship Officer'
            }) 
        end
    elseif CheckMaterialCount('Dark Fragment') < 1 then   
        if not getgenv().ChestCollect then getgenv().ChestCollect = 0 end
        if not Sea2 then 
            TeleportWorld(2)
        else
            if getgenv().ServerData['Server Bosses']['Darkbeard'] then
                KillBoss(getgenv().ServerData['Server Bosses']['Darkbeard'])
                TeleportWorld(3)
            elseif getgenv().ServerData["PlayerBackpack"]['Fist of Darkness'] then 
                if GetDistance(game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection) <= 5 then 
                    EquipWeaponName("Fist of Darkness")
                    pcall(
                        function()
                            firetouchinterest(
                                game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
                                game.Players.LocalPlayer.Character["Fist of Darkness"].Handle,
                                0
                            )
                            firetouchinterest(
                                game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
                                game.Players.LocalPlayer.Character["Fist of Darkness"].Handle,
                                1
                            )
                        end
                    )
                else 
                    Tweento(game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.CFrame)
                end
            elseif getgenv().ChestCollect >= 20 then 
                HopServer(9,true,"Find new server for Fist of Darkness")
            else 
                local NearestChest = getNearestChest()
                if not NearestChest then 
                    SetContent('Ngu')
                end 
                if NearestChest then 
                    PickChest(NearestChest) 
                elseif #getgenv().ServerData['Chest'] <= 0 then 
                    HopServer(9,true,"Find Chest") 
                end
            end
        end
    elseif getgenv().ServerData['PlayerData'].Fragments < 5000 then  
        print('Frag < 5000')
        repeat 
            task.wait() 
            getgenv().FragmentNeeded =true 
            if not getgenv().ServerData['Nearest Raid Island'] then 
                buyRaidingChip() 
            else 
                AutoRaid() 
            end 
        until getgenv().ServerData['PlayerData'].Fragments >= 5000
        TeleportWorld(3) 
        getgenv().FragmentNeeded =false 
    else
        if not Sea3 then 
            TeleportWorld(3)
        else
            game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("soulGuitarBuy", true)
            SetContent(tostring(game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("soulGuitarBuy")))
            wait(10)
            getgenv().CurrentTask = ''
        end
    end
end
AutoTushita = function()
    if not getgenv().ServerData["Inventory Items"]["Tushita"] then 
        if getgenv().ServerData['Server Bosses']['rip_indra True Form'] then 
            if not game:GetService("Workspace").Map.Turtle:FindFirstChild("TushitaGate") then 
                if getgenv().ServerData['Server Bosses']['Longma'] then 
                    KillBoss(getgenv().ServerData['Server Bosses']['Longma'])
                    getgenv().CurrentTask = '' 
                else
                    HopServer(9,true,"Find Long Ma")
                end
            elseif game:GetService("Workspace").Map.Turtle:FindFirstChild("TushitaGate") then
                if getgenv().ServerData["PlayerBackpack"]['Holy Torch'] then
                    EquipWeaponName("Holy Torch") 
                    SetContent('Finding new torch touching template...')
                    if (function() 
                        for i = 1,5,1 do 
                            if not game:GetService("Workspace").Map.Turtle.QuestTorches['Torch'..tostring(i)].Particles.Main.Enabled then 
                                return game:GetService("Workspace").Map.Turtle.QuestTorches['Torch'..tostring(i)]
                            end 
                        end
                    end)() then
                        SetContent('Tweening to torch touching template')
                        Tweento((function() 
                            for i = 1,5,1 do 
                                if not game:GetService("Workspace").Map.Turtle.QuestTorches['Torch'..tostring(i)].Particles.Main.Enabled then 
                                    return game:GetService("Workspace").Map.Turtle.QuestTorches['Torch'..tostring(i)]
                                end 
                            end
                        end)().CFrame)
                        SetContent('Uhm') 
                        if not game:GetService("Workspace").Map.Turtle:FindFirstChild("TushitaGate") then  
                            getgenv().CurrentTask = ''  
                        end
                    end
                else
                    SetContent('Getting Holy Torch...')
                    repeat 
                        Tweento(game:GetService("Workspace").Map.Waterfall.SecretRoom.Room.Door.Door.Hitbox.CFrame)
                        task.wait(1)
                    until getgenv().ServerData["PlayerBackpack"]['Holy Torch']
                    SetContent('Got Holy Torch.')
                end 
            else
                KillBoss(getgenv().ServerData['Server Bosses']['rip_indra True Form'])
            end
        elseif not game:GetService("Workspace").Map.Turtle:FindFirstChild("TushitaGate") then 
            if getgenv().ServerData['Server Bosses']['Longma'] then 
                KillBoss(getgenv().ServerData['Server Bosses']['Longma'])
                getgenv().CurrentTask = '' 
            else
                HopServer(9,true,"Find Long Ma")
            end
        end
    end
end
AutoYama = function()
    if Sea3 then 
        if getgenv().ServerData['PlayerData']["Elite Hunted"] >= 30 then  
            if GetDistance(game.Workspace.Map.Waterfall.SealedKatana.Handle.CFrame) > 50 then 
                SetContent('Tweening to temple to get yama...')
                Tweento(game.Workspace.Map.Waterfall.SealedKatana.Handle.CFrame * CFrame.new(0, 20, 0))
            else
                repeat 
                    task.wait()
                    repeat 
                        task.wait()
                        for i,v in pairs(workspace.Enemies:GetChildren()) do 
                            if v:FindFirstChildOfClass('Humanoid') then 
                                v:FindFirstChildOfClass('Humanoid').Health = 0 
                            end 
                        end  
                    until not game.Workspace.Enemies:FindFirstChild("Ghost [Lv. 1500]")
                    if not game.Workspace.Enemies:FindFirstChild("Ghost [Lv. 1500]") then
                        SetContent('Getting Yama')
                        fireclickdetector(game.Workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
                    end
                until getgenv().ServerData["Inventory Items"]["Yama"] 
                getgenv().CurrentTask = '' 
            end 
        else 
            HopServer(9,true,'Elite, getting yama')
        end
    end
end
AutoElite = function() 
    if getgenv().CurrentElite then  
        if
            not string.find(
                game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,
                getgenv().CurrentElite.Name
            ) or
                not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
            then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                "AbandonQuest"
            )
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                "EliteHunter"
            )
        else
            KillBoss(getgenv().CurrentElite)
            getgenv().CurrentTask = ''
        end
    end
end
AutoSea3 = function()
    if Sea2 and getgenv().ServerData['PlayerData'].Level >= 1000 then  
        local v135 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1")
        if v135 and v135 ~= 0 then  
            if checkFruit1M() then 
                EquipWeaponName(checkFruit1M().Name)
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1")
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "2")
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "3")  
                return 
            end
            local v136666 = checkFruit1M(true) 
            if v136666 then 
                EquipWeaponName(v136666.Name)
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1")
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "2")
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "3")  
            elseif checkFruit1MWS() then  
                SetContent('Picking up '..getRealFruit(checkFruit1MWS()))
                Tweento(checkFruit1MWS().Handle.CFrame)
                task.wait(.1) 
                getgenv().CurrentTask = ''
            else 
                SetContent('Dont Have Fruit So We Must Farm')
                if _G.HopFruit1M then 
                    SetContent('Hoping for 1M Fruit',5)
                    HopServer(9,math.random(1,2) == 1)  
                end
                if getgenv().ServerData['Server Bosses']['Core'] then 
                    KillBoss(getgenv().ServerData['Server Bosses']['Core']) 
                elseif #getgenv().ServerData['Workspace Fruits'] > 0 then 
                    collectAllFruit_Store()
                else
                    AutoL()
                end
            end
        elseif v135 == 0 then
            local ZQuestProgress = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check")
            if not ZQuestProgress then 
                if getgenv().ServerData['Server Bosses']['Don Swan'] then 
                    KillBoss(getgenv().ServerData['Server Bosses']['Don Swan'])
                else 
                    SetContent('Hopping for Don Swan',5)
                    HopServer(9,true,"Don Swan")
                end
            elseif ZQuestProgress == 0 and GetDistance(game:GetService("Workspace").Map.IndraIsland.Part) > 1000 then
                local RedHeadCFrame =
                    CFrame.new(
                    -1926.78772,
                    12.1678171,
                    1739.80884,
                    0.956294656,
                    -0,
                    -0.292404652,
                    0,
                    1,
                    -0,
                    0.292404652,
                    0,
                    0.956294656
                )
                if GetDistance(RedHeadCFrame) <= 50 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
                else
                    Tweento(RedHeadCFrame)
                end
            elseif getgenv().ServerData['Server Bosses']['rip_indra'] then 
                task.spawn(function()
                    while task.wait(0.1) do 
                        local timetry = 0 
                        if timetry > 500 then break; end 
                        timetry+=1 
                        local args = {
                            [1] = "TravelZou"
                        }
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    end
                end)
                repeat 
                    KillBoss(getgenv().ServerData['Server Bosses']['rip_indra'])
                until not getgenv().ServerData['Server Bosses']['rip_indra']
            end 
        end
    end
end














AutoRaid = function()
    if getgenv().ServerData['Nearest Raid Island'] then 
        local RaidDis = GetDistance(getgenv().ServerData['Nearest Raid Island'])
        if RaidDis < 5000 then
            Tweento(getgenv().ServerData['Nearest Raid Island'].CFrame  *CFrame.new(0,60,0)) 
        end
    elseif getgenv().ServerData["PlayerBackpack"]['Special Microchip'] then
        SetContent('Firing raid remote...',3)
        getgenv().NextRaidIslandId = 1
        if Sea2 then
            fireclickdetector(Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)  
            requestEntrance(
                Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125)
            )
        elseif Sea3 then
            fireclickdetector(Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
            requestEntrance(Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
        end
        if getgenv().ServerData["PlayerBackpack"]['Special Microchip'] then 
            getgenv().ServerData["PlayerBackpack"]['Special Microchip'] = nil 
        end
        wait(12) 
    end
    SetContent('Doing raid')   
    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 3000+300)
    for i,v in pairs(workspace.Enemies:GetChildren()) do 
        if v:FindFirstChildOfClass('Humanoid') then 
            v:FindFirstChildOfClass('Humanoid').Health = 0 
        end 
    end     
    if not getgenv().KillAuraConnection then 
        getgenv().KillAuraConnection = workspace.Enemies.ChildAdded:Connect(function(v)  
            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 3000+300)   
            local V5Hum = v:FindFirstChildOfClass('Humanoid') or v:WaitForChild('Humanoid')
            if V5Hum then 
                V5Hum.Health = 0 
            end
        end) 
    end
end
Auto3rdEvent = function() 
    if Sea2 then
        KillBoss(getgenv().ServerData['Server Bosses']['Core']) 
        getgenv().CurrentTask = ''
    else  
        if getgenv().PirateRaidTick <= 0 then 
            getgenv().CurrentTask = ''
            return 
        end 
        local CastleCFrame = CFrame.new(-5543.5327148438, 313.80062866211, -2964.2585449219)
        if GetDistance(CastleCFrame) > 1500 then 
            Tweento(CastleCFrame * CFrame.new(0,-100,0))
        else
            for i,v in pairs(game.workspace.Enemies:GetChildren()) do 
                if v:FindFirstChildOfClass("Humanoid") and v.Humanoid.Health > 0 and GetDistance(v.PrimaryPart,CastleCFrame) <= 1500 then 
                    KillNigga(v)
                end
            end
        end
    end
end
AutoMeleeFunc = function()
    if getgenv().MeleeTask == 'Find Library Key' then
        if not Sea2 then TeleportWorld(2) end  
        if getgenv().ServerData["PlayerBackpack"]['Library Key'] then 
            EquipWeaponName('Library Key')
            Tweento(CFrame.new(
                6375.9126,
                296.634583,
                -6843.14062,
                -0.849467814,
                1.5493983e-08,
                -0.527640462,
                3.70608895e-08,
                1,
                -3.0301031e-08,
                0.527640462,
                -4.5294577e-08,
                -0.849467814
            ))
        elseif getgenv().ServerData['Server Bosses']['Awakened Ice Admiral'] then 
            KillBoss(getgenv().ServerData['Server Bosses']['Awakened Ice Admiral'])  
            if getgenv().ServerData["PlayerBackpack"]['Library Key'] then 
                EquipWeaponName('Library Key')
                Tweento(CFrame.new(
                    6375.9126,
                    296.634583,
                    -6843.14062,
                    -0.849467814,
                    1.5493983e-08,
                    -0.527640462,
                    3.70608895e-08,
                    1,
                    -3.0301031e-08,
                    0.527640462,
                    -4.5294577e-08,
                    -0.849467814
                )) 
            end
            getgenv().MeleeTask = ''
        else  
            SetContent('Hopping for Ice Admiral',5)
            HopServer(10,true,"Ice Admiral")
        end
    elseif getgenv().MeleeTask == 'Find Waterkey' then  
        if not Sea2 then TeleportWorld(2) end  
        if getgenv().ServerData["PlayerBackpack"]['Water Key'] then 
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true) 
        elseif getgenv().ServerData['Server Bosses']['Tide Keeper'] then 
            KillBoss(getgenv().ServerData['Server Bosses']['Tide Keeper']) 
            local ABC,XYZ = pcall(function()
                if type(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)) ~='string' then   
                    getgenv().MeleeTask = '' 
                end
            end)
            task.wait(1) 
            repeat 
                ABC,XYZ = pcall(function()
                    if type(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)) ~='string' then   
                        getgenv().MeleeTask = '' 
                    end
                end)
                task.wait(1)
            until ABC
        elseif getgenv().ServerData['PlayerData'].Level >= 1450 then
            SetContent('Hopping for Tide Keeper',5)
            HopServer(10,true,"Tide Keeper")
        end 
    elseif getgenv().MeleeTask == 'Previous Hero Puzzle' then   
        if not Sea3 then TeleportWorld(3) end
        Tweento(GetNPC('Previous Hero').PrimaryPart.CFrame * CFrame.new(0,0,-2.5))
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start")
        Tweento(CFrame.new(-12548.8, 332.378, -7617.77)) 
        getgenv().MeleeTask = '' 
    elseif getgenv().MeleeTask == 'Find Fire Essence' then  
        if getgenv().ServerData['Server Bosses']['Soul Reaper'] then
            KillBoss(getgenv().ServerData['Server Bosses']['Soul Reaper'] )
        elseif getgenv().ServerData["PlayerBackpack"]['Hallow Essence'] then 
            EquipWeapon('Hallow Essence') 
            Tweento(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame) 
        elseif getgenv().ServerData['PlayerData'].Level >= 2000 then  
            if not game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("Quest").Visible then 
                FarmMobByLevel(2000)
            else 
                KillMobList({
                    "Reborn Skeleton [Lv. 1975]",
                    "Living Zombie [Lv. 2000]",
                    "Demonic Soul [Lv. 2025]",
                    "Posessed Mummy [Lv. 2050]"
                })
            end
        else 
            KillMobList({
                "Reborn Skeleton [Lv. 1975]",
                "Living Zombie [Lv. 2000]",
                "Demonic Soul [Lv. 2025]",
                "Posessed Mummy [Lv. 2050]"
            })
        end
    elseif getgenv().MeleeTask == 'Farm Godhuman' or getgenv().Config.FarmmingForGodhuman then 
        local FishTails = CheckMaterialCount('Fish Tail')
        local MagmaOre = CheckMaterialCount('Magma Ore')
        local MysticDroplet = CheckMaterialCount('Mystic Droplet') 
        local DragonScale = CheckMaterialCount('Dragon Scale') 
        if FishTails < 20 then 
            if not Sea1 then 
                TeleportWorld(1)
            else
                KillMobList({"Fishman Warrior","Fishman Commando"})
            end
        elseif MagmaOre < 20 then 
            if not Sea1 then 
                TeleportWorld(1)
            else
                KillMobList({"Military Spy","Military Soldier"})
            end
        elseif MysticDroplet < 10 then 
            if not Sea2 then 
                TeleportWorld(2)
            else
                KillMobList({"Sea Soldier","Water Fighter"})
            end
        elseif DragonScale < 10 then 
            if not Sea3 then 
                TeleportWorld(3)
            else
                KillMobList({"Dragon Crew Archer","Dragon Crew Warrior"})
            end 
        else
            getgenv().DoneMaterial = true   
            TeleportWorld(3) 
        end
    end
end    
AutoMeleeMasteryCheck = function() 
    task.spawn(function()
        getgenv().FragmentNeeded = false
        getgenv().MeleeTask = 'None' 
        getgenv().MeleeWait = ''
        repeat task.wait() until getgenv().CheckAllMelee and getgenv().Config and getgenv().Config["Melee Level Values"] 
        while task.wait(1) do 
            local MLLV = getgenv().Config["Melee Level Values"]
            pcall(function()
                if MLLV["Superhuman"] == 0 then 
                    BuyMelee('Superhuman')
                    if MLLV["Black Leg"] < 300 then 
                        BuyMelee('Black Leg') 
                        SetMeleeWait('Black Leg',300)  
                    elseif MLLV["Electro"] < 300 then 
                        BuyMelee('Electro')    
                        SetMeleeWait('Electro',300)
                    elseif MLLV["Fishman Karate"] < 300 then 
                        BuyMelee('Fishman Karate')  
                        SetMeleeWait('Fishman Karate',300)
                    elseif MLLV["Dragon Claw"] < 300 then 
                        if MLLV['Dragon Claw'] == 0 then 
                            if getgenv().ServerData['PlayerData'].Fragments < 1500 then 
                                getgenv().FragmentNeeded = true 
                            else 
                                BuyMelee('Dragon Claw') 
                                getgenv().FragmentNeeded = false 
                            end
                        else 
                            BuyMelee('Dragon Claw') 
                            SetMeleeWait('Dragon Claw',300)
                        end 
                    else
                        BuyMelee('Superhuman')
                    end 
                elseif MLLV['Sharkman Karate'] == 0 or MLLV['Death Step'] == 0 or MLLV['Electric Claw'] == 0 or MLLV['Dragon Talon'] == 0 then 
                    if MLLV['Fishman Karate'] < 400 then 
                        BuyMelee('Fishman Karate')   
                        SetMeleeWait('Fishman Karate',400)
                    elseif MLLV['Black Leg'] < 400 then 
                        BuyMelee('Black Leg') 
                        SetMeleeWait('Black Leg',400)
                    elseif MLLV['Electro'] < 400 then 
                        BuyMelee('Electro') 
                        SetMeleeWait('Electro',400)
                    elseif MLLV['Dragon Claw'] < 400 then 
                        BuyMelee('Dragon Claw')  
                        SetMeleeWait('Dragon Claw',400)  
                    elseif MLLV['Superhuman'] < 400 then
                        BuyMelee('Superhuman')
                        SetMeleeWait('Superhuman',400)
                    elseif MLLV['Sharkman Karate'] > 0 and MLLV['Sharkman Karate'] < 400 then 
                        BuyMelee('Sharkman Karate')  
                        SetMeleeWait('Sharkman Karate',400)
                    elseif MLLV['Death Step'] > 0 and MLLV['Death Step'] < 400 then 
                        BuyMelee('Death Step')  
                        SetMeleeWait('Death Step',400)
                    elseif MLLV['Electric Claw'] > 0 and MLLV['Electric Claw'] < 400 then 
                        BuyMelee('Electric Claw')  
                        SetMeleeWait('Electric Claw',400)
                    elseif MLLV['Dragon Talon'] > 0 and MLLV['Dragon Talon'] < 400 then 
                        SetMeleeWait('Dragon Talon',400)
                        BuyMelee('Dragon Talon')
                    end   
                    if MLLV['Sharkman Karate'] == 0 then 
                        BuyMelee('Sharkman Karate')  
                    elseif MLLV['Death Step'] == 0 then 
                        BuyMelee('Death Step')  
                    elseif MLLV['Electric Claw'] == 0 then 
                        BuyMelee('Electric Claw')  
                    elseif MLLV['Dragon Talon'] == 0 then 
                        BuyMelee('Dragon Talon')   
                    end  
                elseif MLLV['Superhuman'] < 400 then
                    BuyMelee('Superhuman')
                    SetMeleeWait('Superhuman',400)
                elseif MLLV['Sharkman Karate'] < 400 then 
                    BuyMelee('Sharkman Karate')  
                    SetMeleeWait('Sharkman Karate',400)
                elseif MLLV['Death Step'] < 400 then 
                    BuyMelee('Death Step')  
                    SetMeleeWait('Death Step',400)
                elseif MLLV['Electric Claw'] < 400 then 
                    BuyMelee('Electric Claw')  
                    SetMeleeWait('Electric Claw',400)
                elseif MLLV['Dragon Talon'] < 400 then 
                    SetMeleeWait('Dragon Talon',400)
                    BuyMelee('Dragon Talon') 
                elseif MLLV['Godhuman'] == 0 then 
                    if not getgenv().Config.AllV2MeleeStyles400Mastery then 
                        getgenv().Config.AllV2MeleeStyles400Mastery = true 
                    end 
                    if (getgenv().ServerData["Inventory Items"]['Yama'] and getgenv().ServerData["Inventory Items"]['Yama'].Mastery < 350) or (getgenv().ServerData["Inventory Items"]['Tushita'] and getgenv().ServerData["Inventory Items"]['Tushita'].Mastery < 350) then 
                        getgenv().WeaponType = 'Sword'
                        if getgenv().ServerData["Inventory Items"]['Yama'] and getgenv().ServerData["Inventory Items"]['Yama'].Mastery < 350 then 
                            LoadItem('Yama')
                        elseif getgenv().ServerData["Inventory Items"]['Tushita'] and getgenv().ServerData["Inventory Items"]['Tushita'].Mastery < 350 then 
                            LoadItem('Tushita')
                        end
                    end
                    if getgenv().DoneMaterial and getgenv().ServerData['PlayerData'].Fragments >= 5000 and getgenv().ServerData['PlayerData'].Beli >= 5000000 then 
                        BuyMelee('Godhuman')
                    end 
                else
                    local SwordMasteryFarm,SwordMasteryFarm2 = getNextSwordToFarm()
                    if (getgenv().ServerData["Inventory Items"]['Yama'] and getgenv().ServerData["Inventory Items"]['Yama'].Mastery < 350) or (getgenv().ServerData["Inventory Items"]['Tushita'] and getgenv().ServerData["Inventory Items"]['Tushita'].Mastery < 350) then 
                        getgenv().WeaponType = 'Sword'
                        if getgenv().ServerData["Inventory Items"]['Yama'] and getgenv().ServerData["Inventory Items"]['Yama'].Mastery < 350 then 
                            LoadItem('Yama')
                        elseif getgenv().ServerData["Inventory Items"]['Tushita'] and getgenv().ServerData["Inventory Items"]['Tushita'].Mastery < 350 then 
                            LoadItem('Tushita')
                        end
                    elseif MLLV['Godhuman'] < 401 then 
                        BuyMelee('Godhuman') 
                        getgenv().WeaponType = "Melee"
                        SetMeleeWait('Godhuman',600)
                    elseif MLLV['Sharkman Karate'] < 401 then 
                        BuyMelee('Sharkman Karate')
                        getgenv().WeaponType = "Melee"
                        SetMeleeWait('Sharkman Karate',600)
                    elseif MLLV['Death Step'] < 401 then 
                        BuyMelee('Death Step')
                        getgenv().WeaponType = "Melee"
                        SetMeleeWait('Death Step',600)
                    elseif MLLV['Electric Claw'] < 401 then 
                        BuyMelee('Electric Claw')
                        getgenv().WeaponType = "Melee"
                        SetMeleeWait('Electric Claw',600)
                    elseif MLLV['Dragon Talon'] < 401 then 
                        BuyMelee('Dragon Talon')
                        getgenv().WeaponType = "Melee"
                        SetMeleeWait('Dragon Talon',600)
                    elseif MLLV['Superhuman'] < 401 then 
                        BuyMelee('Superhuman')
                        getgenv().WeaponType = "Melee"
                        SetMeleeWait('Superhuman',600)
                    else
                        getgenv().MasteryFarm = false
        
                        if SwordMasteryFarm and not SwordMasteryFarm.Equipped then 
                            LoadItem(SwordMasteryFarm.Name) 
                        elseif SwordMasteryFarm and SwordMasteryFarm.Equipped then 
                            getgenv().WeaponType = 'Sword'   
                            SetMeleeWait(SwordMasteryFarm.Name,tonumber(SwordMasteryFarm2))
                        else
                            getgenv().WeaponType = 'Melee'
                        end
                    end
                end  
            end)
        end
    end)
end 
AutoMeleeMasteryCheck()
AutoMeleeCheck = function()
    task.spawn(function()
        getgenv().FragmentNeeded = false
        getgenv().MeleeTask = 'None'
        repeat task.wait() until getgenv().CheckAllMelee and getgenv().Config and getgenv().Config["Melee Level Values"]  
        local PreviousHeroRemoteFired = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", true)  
        local MonkRemote = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman", true)
        
        getgenv().Config.PreviousHeroPassed = typeof(PreviousHeroRemoteFired) ~= 'string' 
        getgenv().Config.PreviousHeroPassed2 =  PreviousHeroRemoteFired ~= 4  
        getgenv().Config.WaterkeyPassed = typeof(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)) ~= 'string';   
        getgenv().Config.FireEssencePassed = typeof(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon", true))~= 'string'   
        getgenv().Config.IceCastleDoorPassed = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("OpenLibrary")
        getgenv().Config.GodhumanMaterialPassed = typeof(MonkRemote) ~= 'string' and MonkRemote ~= 3        
        while task.wait() do 
            local MLLV = getgenv().Config["Melee Level Values"] 
            local v316, v317, v318, v319 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones", "Check")  
            if MLLV['Sharkman Karate'] == 0 or MLLV['Death Step'] == 0 or MLLV['Electric Claw'] == 0 or MLLV['Dragon Talon'] == 0  then 
                pcall(function()  
                    if not getgenv().Config.WaterkeyPassed then 
                        getgenv().Config.WaterkeyPassed = typeof(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)) ~= 'string'; 
                    end  
                    
                    if not getgenv().Config.PreviousHeroPassed2 then  
                        local PreviousHeroRemoteFired = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw", true) 
                        getgenv().Config.PreviousHeroPassed = typeof(PreviousHeroRemoteFired) ~= 'string' 
                        getgenv().Config.PreviousHeroPassed2 =  PreviousHeroRemoteFired ~= 4  
                    end                    
                    if not getgenv().Config.FireEssencePassed then 
                        getgenv().Config.FireEssencePassed = typeof(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon", true))~= 'string' 
                    end     
                    if not getgenv().Config.IceCastleDoorPassed then 
                        getgenv().Config.IceCastleDoorPassed = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("OpenLibrary")   
                    end 
                    if not getgenv().Config.GodhumanMaterialPassed then 
                        local MonkRemote = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman", true)
                        getgenv().Config.GodhumanMaterialPassed = typeof(MonkRemote) ~= 'string' and MonkRemote ~= 3
                    end
                end) 
                if (not getgenv().Config.IceCastleDoorPassed) and (getgenv().ServerData["PlayerBackpack"]['Library Key'] or getgenv().ServerData['Server Bosses']['Awakened Ice Admiral'] or getgenv().ServerData['PlayerData'].Level >= 1450) then 
                    getgenv().MeleeTask = 'Find Library Key'
                elseif not getgenv().Config.WaterkeyPassed and (getgenv().ServerData["PlayerBackpack"]['Water Key'] or getgenv().ServerData['Server Bosses']['Tide Keeper'] or getgenv().ServerData['PlayerData'].Level >= 1450) then 
                    getgenv().MeleeTask = 'Find Waterkey' 
                elseif getgenv().ServerData['PlayerData'].Level >= 1650 and getgenv().Config.PreviousHeroPassed and not getgenv().Config.PreviousHeroPassed2 then  
                    if not Sea3 then 
                        TeleportWorld(3) 
                    else
                        getgenv().MeleeTask = 'Previous Hero Puzzle' 
                    end
                elseif not getgenv().HavingX2 and ((Sea3 and v318 and v318 > 0) or getgenv().ServerData['PlayerData'].Level >= 1650) and not getgenv().Config.FireEssencePassed then   
                    if not Sea3 then 
                        TeleportWorld(3) 
                    else 
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
                        if v316 and v316 < v318*50 then 
                            getgenv().MeleeTask = 'Find Fire Essence' 
                        else
                            print(v316,'v316')
                            getgenv().MeleeTask = ''
                        end
                    end
                else
                    getgenv().MeleeTask = ''
                end  
            elseif getgenv().Config.AllV2MeleeStyles400Mastery and MLLV['Godhuman'] == 0 then 
                getgenv().Config.FarmmingForGodhuman = true  
                if not getgenv().Config.GodhumanMaterialPassed then 
                    getgenv().MeleeTask = 'Farm Godhuman' 
                else  
                    getgenv().MeleeTask = ''    
                end
            else   
                getgenv().Config.FarmmingForGodhuman = false
                getgenv().MeleeTask = ''
            end 
            task.wait(3)
        end
    end)
end
AutoMeleeCheck()
AutoRaceV2 = function()
    if not Sea2 then 
        repeat 
            TeleportWorld(2)
            task.wait(3)
        until Sea2 
    end
    if getgenv().ServerData["PlayerBackpack"]['Flower 1'] and getgenv().ServerData["PlayerBackpack"]['Flower 2'] and getgenv().ServerData["PlayerBackpack"]['Flower 3'] then 
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3")
        wait(5)
        getgenv().CurrentTask = '' 
        SetContent('Upgraded V2 Race | Returning task...')
        return
    else
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "2") 
        if not getgenv().ServerData["PlayerBackpack"]['Flower 1'] then 
            SetContent('Getting Blue Flower (Flower 1)')
            if workspace.Flower1.Transparency ~= 1 then
                Tweento(workspace.Flower1.CFrame)   
            else  
                SetContent('Hopping for Blue Flower',5)
                HopServer(10,true,"Blue Flower")
            end
        elseif not getgenv().ServerData["PlayerBackpack"]['Flower 2'] then 
            SetContent('Getting Red Flower (Flower 2)')
            Tweento(workspace.Flower2.CFrame)
        else 
            SetContent('Getting Yellow Flower (Flower 3)')
            KillMobList({"Swan Pirate"})
        end
    end
end

AutoBartiloQuest = function()
    local QuestBartiloId = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo")
    if QuestBartiloId == 0 then 
        SetContent('First Bartilo task...')
        if game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text:find("Swan Pirate") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text:find("50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then 
            KillMobList({"Swan Pirate"})
        else
            Tweento(CFrame.new(-456.28952, 73.0200958, 299.895966))
            if GetDistance(CFrame.new(-456.28952, 73.0200958, 299.895966)) < 10 then 
                local args = {
                    [1] = "StartQuest",
                    [2] = "BartiloQuest",
                    [3] = 1
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
        end 
    elseif QuestBartiloId == 1 then 
        SetContent('Finding Jeremy...')
        if getgenv().ServerData['Server Bosses']['Jeremy'] then 
            KillBoss(getgenv().ServerData['Server Bosses']['Jeremy'])
            getgenv().CurrentTask = ''
        elseif getgenv().ServerData['PlayerData'].Level > 500 then  
            SetContent('Hopping for Bartilo',5)
            HopServer(9,true,"Jeremy Boss")
        end
    elseif QuestBartiloId == 2 then 
        local StartCFrame =
        CFrame.new(
        -1837.46155,
        44.2921753,
        1656.19873,
        0.999881566,
        -1.03885048e-22,
        -0.0153914848,
        1.07805858e-22,
        1,
        2.53909284e-22,
        0.0153914848,
        -2.55538502e-22,
        0.999881566
    )
        if GetDistance(StartCFrame) > 400 then 
            SetContent('Starting templates puzzle...')
            Tweento(StartCFrame)
        else
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-1836, 11, 1714)
                task.wait(.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-1850.49329, 13.1789551, 1750.89685)
                task.wait(.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-1858.87305, 19.3777466, 1712.01807)
            task.wait(.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-1803.94324, 16.5789185, 1750.89685)
                task.wait(.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-1858.55835, 16.8604317, 1724.79541)
                task.wait(.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-1869.54224, 15.987854, 1681.00659)
                task.wait(.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-1800.0979, 16.4978027, 1684.52368)
                task.wait(.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-1819.26343, 14.795166, 1717.90625)
                task.wait(.5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(-1813.51843, 14.8604736, 1724.79541)
                getgenv().CurrentTask = ''
                SetContent('Done task | Returning task...')
        end
    end
end 

AutoSea2 = function()  
    if game.Workspace.Map.Ice.Door.CanCollide then
        if not getgenv().ServerData["PlayerBackpack"]['Key'] then  
            SetContent('Getting key to pass the door...')
            Tweento(CFrame.new(4852.2895507813, 5.651451587677, 718.53070068359))
            if GetDistance(CFrame.new(4852.2895507813, 5.651451587677, 718.53070068359)) < 5 then
                game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("DressrosaQuestProgress", "Detective")
                if getgenv().ServerData["PlayerBackpack"]['Key'] then EquipWeaponName("Key") end
            end 
        else 
            SetContent('Opening door...')
            EquipWeaponName("Key")
            if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Key") then
                Tweento(game.Workspace.Map.Ice.Door.CFrame)
            end
        end
    else 
        SetContent('Finding Ice Admiral...')
        if getgenv().ServerData['Server Bosses']['Ice Admiral'] then 
            KillBoss(getgenv().ServerData['Server Bosses']['Ice Admiral']) 
            refreshTask()
            task.delay(5,function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") 
            end)
            getgenv().CurrentTask = ''
        elseif getgenv().ServerData['PlayerData'].Level >= 700 then  
            SetContent('Hopping for Ice Admiral',5)
            HopServer(9,true,"Ice Admiral")
        end
    end
end
AutoPole = function()
    if not Sea1 then 
        --TeleportWorld(1)
    end
    if getgenv().ServerData["Inventory Items"]["Pole (1st Form)"] then 
        refreshTask()
        return
    end 
        if getgenv().ServerData['Server Bosses']['Thunder God'] then 
            KillBoss(getgenv().ServerData['Server Bosses']['Thunder God'])
            getgenv().CurrentTask = ''
        elseif getgenv().ServerData['PlayerData'].Level > 500 then  
            SetContent('Hopping for Thunder God',5)
            HopServer(9,true,'Thunder God')
        end
end
local function IsUnlockedSaberDoor()
    for i, v in next, game:GetService("Workspace").Map.Jungle.Final:GetChildren() do
        if v:IsA("Part") and not v.CanCollide then
            return true
        end
    end
end  
local function SaberTouchTemplate()
    for i, v in next, game:GetService("Workspace").Map.Jungle.QuestPlates:GetChildren() do
        if v:IsA("Model") then
            if v.Button:FindFirstChild("TouchInterest") then
                return v
            end
        end
    end
end 
local function CupDoor()
    return workspace.Map.Desert.Burn.Part.CanCollide == false
end
AutoSaber = function()
    if not Sea1 then 
        --TeleportWorld(1)
        return;
    end
    task.wait()
    local RichSonProgress = -999
    if getgenv().ServerData["Inventory Items"]["Saber"] then 
        getgenv().CurrentTask = ''
        return
    end
    if IsUnlockedSaberDoor() then 
        SetContent('Finding Saber Expert...')
        if getgenv().ServerData['Server Bosses']['Saber Expert'] then 
            KillBoss(getgenv().ServerData['Server Bosses']['Saber Expert'])  
            if not getgenv().ServerData['Server Bosses']['Saber Expert'] or not getgenv().ServerData['Server Bosses']['Saber Expert']:FindFirstChildOfClass('Humanoid') or getgenv().ServerData['Server Bosses']['Saber Expert']:FindFirstChildOfClass('Humanoid').Health <= 0 then 
                getgenv().CurrentTask = ''
            end
        elseif getgenv().ServerData['PlayerData'].Level > 200 then  
            SetContent('Hopping for Shanks',5)
            HopServer(9,true,"Shanks")
        end 
    elseif game:GetService("Workspace").Map.Jungle.QuestPlates.Door.CanCollide then 
        SetContent('Touching templates in jungle...')
        local Template = SaberTouchTemplate()
        if Template then 
            Tweento(Template.Part.CFrame)
        end
    elseif CupDoor() then 
        RichSonProgress = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
        if RichSonProgress ~= 0 and RichSonProgress ~= 1 then
            if not getgenv().ServerData["PlayerBackpack"]['Cup'] then 
                Tweento(CFrame.new(1113.66992,7.5484705,4365.27832,-0.78613919,-2.19578524e-08,-0.618049502,1.02977182e-09,1,-3.68374984e-08,0.618049502,-2.95958493e-08,-0.78613919)) 
                SetContent('Getting cup')
            else
                EquipWeaponName('Cup')
                if getgenv().ServerData["PlayerBackpack"]['Cup'].Handle:FindFirstChild('TouchInterest') then 
                    SetContent('Filling cup with water...')
                    Tweento(CFrame.new(1395.77307,37.4733238,-1324.34631,-0.999978602,-6.53588605e-09,0.00654155109,-6.57083277e-09,1,-5.32077493e-09,-0.00654155109,-5.3636442e-09,-0.999978602))  
                else 
                    SetContent('Feeding sick man...')
                    Tweento(CFrame.new(1457.8768310547, 88.377502441406, -1390.6892089844))
                    if GetDistance(CFrame.new(1457.8768310547, 88.377502441406, -1390.6892089844)) < 10 then 
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                            "ProQuestProgress",
                            "SickMan"
                        )
                    end
                end
            end
        elseif RichSonProgress == 0 then
            SetContent('Finding Mob Leader...')
            if getgenv().ServerData['Server Bosses']['Mob Leader'] then 
                KillBoss(getgenv().ServerData['Server Bosses']['Mob Leader']) 
            elseif getgenv().ServerData['PlayerData'].Level > 500 then  
                SetContent('Hopping for Mob Leader',5)
                HopServer(9,true,"Mob Leader")  
            end
        elseif RichSonProgress == 1 then
            if getgenv().ServerData["PlayerBackpack"]['Relic'] then 
                EquipWeaponName("Relic") 
                Tweento(CFrame.new(-1405.3677978516, 29.977333068848, 4.5685839653015))
            else
                Tweento(CFrame.new(-1404.07996,29.8520069,5.26677656,0.888123989,-4.0340602e-09,0.459603906,7.5884703e-09,1,-5.8864642e-09,-0.459603906,8.71560069e-09,0.888123989))
                if GetDistance(CFrame.new(-1404.07996,29.8520069,5.26677656,0.888123989,-4.0340602e-09,0.459603906,7.5884703e-09,1,-5.8864642e-09,-0.459603906,8.71560069e-09,0.888123989)) < 10 then 
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
                end
            end
        end
    else 
        SetContent('Getting torch...')
        if not getgenv().ServerData["PlayerBackpack"]['Torch'] then  
            Tweento(game:GetService("Workspace").Map.Jungle.Torch.CFrame)
        else  
            EquipWeaponName("Torch") 
            Tweento(CFrame.new(1115.23499,4.92147732,4349.36963,-0.670654476,-2.18307523e-08,0.74176991,-9.06980624e-09,1,2.1230365e-08,-0.74176991,7.51052998e-09,-0.670654476))
        end  
    end
end
