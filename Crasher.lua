if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local Chat = PlayerGui:FindFirstChild("Chat")
local MessageDisplay = Chat and Chat:FindFirstChild("Frame_MessageLogDisplay", true)
local Scroller = MessageDisplay and MessageDisplay:FindFirstChild("Scroller")

local Gsub = string.gsub

if not Scroller then return end

for _, x in next, Scroller:GetChildren() do
    local MessageTextLabel = x:FindFirstChildWhichIsA("TextLabel")
    if MessageTextLabel then
        local Message = Gsub(MessageTextLabel.Text, "^%s+", "")
        if Message:match(" ") then
            x:Destroy()
        end
    end
end

local ChatAdded = Scroller.ChildAdded:Connect(function(x)
    local MessageTextLabel = x:FindFirstChildWhichIsA("TextLabel")
    if MessageTextLabel then
        repeat task.wait() until not MessageTextLabel.Text:match("__+")
        local Message = Gsub(MessageTextLabel.Text, "^%s+", "")
        if Message:match(" ") then
            x:Destroy()
        end
    end
end)

local Unicode = " "
local Message = "⛓" .. Unicode:rep(200)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SayMessageRequest = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)

if SayMessageRequest then
    repeat
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player then
                SayMessageRequest:FireServer(Message, player.Name)
            end
        end
        task.wait(0.1)
    until false
end
