local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CombatFramework = require(Players.LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]

BladeHits = function(Value)
    local Hits = {}
    for _, Hit in ipairs(Workspace.Enemies:GetChildren()) do
        local Humanoid = Hit and Hit:FindFirstChildOfClass("Humanoid")
        if Humanoid and Humanoid.Health > 0 then
            local RootPart = Humanoid.RootPart
            if RootPart and Players.LocalPlayer:DistanceFromCharacter(RootPart.Position) < Value then
                table.insert(Hits, RootPart)
            end
        end
    end
    return Hits
end
PlayerHits = function(Value)
    local Hits = {}
    for _, Char in ipairs(Workspace.Characters:GetChildren()) do
        if Char.Name ~= Players.LocalPlayer.Name then
            local Humanoid = Char and Char:FindFirstChildOfClass("Humanoid")
            if Humanoid and Humanoid.RootPart and Humanoid.Health > 0 then
                if Players.LocalPlayer:DistanceFromCharacter(Humanoid.RootPart.Position) < Value then
                    table.insert(Hits, Humanoid.RootPart)
                end
            end
        end
    end
    return Hits
end
AddAttack = function(Hit)
    local ac = CombatFrameworkR.activeController
    if ac and ac.equipped then
        if #Hit > 0 then
            local agrs1 = getupvalue(ac.attack, 5)
            local agrs2 = getupvalue(ac.attack, 6)
            local agrs3 = getupvalue(ac.attack, 4)
            local agrs4 = getupvalue(ac.attack, 7)
            local agrs5 = (agrs1 * 798405 + agrs3 * 727595) % agrs2
            local agrs6 = agrs3 * 798405

            agrs5 = (agrs5 * agrs2 + agrs6) % 1099511627776
            agrs1 = math.floor(agrs5 / agrs2)
            agrs3 = agrs5 - agrs1 * agrs2
            agrs4 = agrs4 + 1

            setupvalue(ac.attack, 5, agrs1)
            setupvalue(ac.attack, 6, agrs2)
            setupvalue(ac.attack, 4, agrs3)
            setupvalue(ac.attack, 7, agrs4)
            local Blade = ac.currentWeaponModel
            if Blade then
                ReplicatedStorage.RigControllerEvent:FireServer("weaponChange", Blade.Name)
                ac.animator.anims.basic[1]:Play(0.01, 0.01, 0.01)
                ReplicatedStorage.Remotes.Validator:FireServer(math.floor(agrs5 / 1099511627776 * 16777215), agrs4)
                ReplicatedStorage.RigControllerEvent:FireServer("hit", Hit, 1, "")
            end
        end
    end
end
AttackFunc = function()
    AddAttack(BladeHits(65))
    AddAttack(PlayerHits(65))
end
local Tick = tick()
local Delay = 0.25
RunAttack = function()
    task.spawn(function()
        while task.wait() do 
            if (tick() - Tick) >= math.clamp(Delay, 0.100, 1) then
                task.spawn(AttackFunc)
                Tick = tick()
            end
        end 
    end)
end
RunAttack()
