local function autofarm() 
    local lp = game.Players.LocalPlayer
    while wait() do
        if getgenv().AutoFarmEnabled then
            local toolbtn = nil
            local arr = {}
            for i,v in pairs(lp.PlayerGui.Main.HUD.Bars.Bottom.Toolbar:GetChildren()) do
                if v.Name ~= "UIListLayout" then
                    local pos = tostring(v.AbsolutePosition):split(",")[1]
                    
                    table.insert(arr, {v,pos})
                end
            end
            table.sort(arr, function(a,b)
                return a[2] > b[2]
            end)
            for a,b in pairs(arr) do
                if table.find(arr, b) == 1 then
                    toolbtn = b[1]
                end
            end
            if toolbtn.AbsolutePosition ~= arr[1][2] then
                local args = {
                    [1] = "S_Tools_Toggle",
                    [2] = {
                        [1] = "Weight4"
                    }
                }

                game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Library"):WaitForChild("Network"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
            end

            local args = {
                [1] = "S_Tools_Activate",
                [2] = {}
            }

            game:GetService("ReplicatedStorage"):WaitForChild("Common"):WaitForChild("Library"):WaitForChild("Network"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
        end
    end
end
local function music()
    while wait() do
        if getgenv().MusicEnabled == false then
            game:GetService("Workspace").Music.Playing = false
        elseif getgenv().MusicEnabled and game:GetService("Workspace").Music.Playing == false then
            game:GetService("Workspace").Music.Playing = true
        end
    end
end
local function autorebirth()
    while wait() do
        if getgenv().AutoRebirthEnabled then
            if game:GetService("Players").EMRzKRlmOZxamcmGcPtq.PlayerGui.Main.Menus.Rebirth.RebirthBtn.BackgroundColor3 ~= Color3.new(150, 161, 166) then
                local args = {
                    [1] = "S_Rebirth_Request",
                    [2] = {}
                }
                
                game:GetService("ReplicatedStorage").Common.Library.Network.RemoteFunction:InvokeServer(unpack(args))
            end
        end
    end
end

coroutine.wrap(autofarm)()
coroutine.wrap(music)()
coroutine.wrap(autorebirth)()
