local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

local Window = Rayfield:CreateWindow({
   Name = "Kaziz Hub ⚽",
   LoadingTitle = "Injetando Sistema...",
   LoadingSubtitle = "by gabybellaaaaa",
   Theme = "DarkBlue"
})

local MainTab = Window:CreateTab("Principal", 4483362458)
local AutoFollow = false

local function getBall()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower() == "ball" or obj.Name:lower() == "soccerball" or obj.Name == "Bola") then
            return obj
        end
    end
    return nil
end

MainTab:CreateToggle({
   Name = "Auto Seguir Bola",
   CurrentValue = false,
   Flag = "AutoFollowFlag",
   Callback = function(Value)
       AutoFollow = Value
       task.spawn(function()
           while AutoFollow do
               task.wait(0.01)
               local player = game.Players.LocalPlayer
               if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                   local ball = getBall()
                   if ball then
                       player.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, Vector3.new(ball.Position.X, player.Character.HumanoidRootPart.Position.Y, ball.Position.Z))
                       player.Character:FindFirstChildOfClass("Humanoid"):MoveTo(ball.Position)
                   end
               end
           end
       end)
   end,
})

MainTab:CreateSlider({
   Name = "Velocidade",
   Min = 16, max = 150, CurrentValue = 16, Flag = "Speed",
   Callback = function(v) if game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = v end end
})
