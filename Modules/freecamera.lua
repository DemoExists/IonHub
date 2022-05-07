local FreeCamera = {
    Speed = 0.5,
    CFrame = CFrame.new(0, 0, 0)
}

-- Services
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local NetworkClient = game:GetService("NetworkClient")
local Mouse = LocalPlayer:GetMouse()
local ContextActionService = game:GetService("ContextActionService")

-- Main
local Wheld, Sheld, Aheld, Dheld, Eheld, Qheld = false, false, false, false, false, false
local Input = {}; do
    function Input:Block()
        ContextActionService:BindActionAtPriority("__FC", function(Action, State, Input)
            local oldSpeed = FreeCamera.Speed
            if Input.KeyCode.Name == "W" or Input.KeyCode.Name == "Up" then
                Wheld = State.Name == "Begin" and true or false
            end
            if Input.KeyCode.Name == "S" or Input.KeyCode.Name == "Down" then
                Sheld = State.Name == "Begin" and true or false
            end
            if Input.KeyCode.Name == "A" or Input.KeyCode.Name == "Left" then
                Aheld = State.Name == "Begin" and true or false
            end
            if Input.KeyCode.Name == "D" or Input.KeyCode.Name == "Right" then
                Dheld = State.Name == "Begin" and true or false
            end
            if Input.KeyCode.Name == "E" or Input.KeyCode.Name == "Space" then
                Eheld = State.Name == "Begin" and true or false
            end
            if Input.KeyCode.Name == "Q" or Input.KeyCode.Name == "LeftControl" then
                Qheld = State.Name == "Begin" and true or false
            end
            return Enum.ContextActionResult.Sink
        end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.E, Enum.KeyCode.Q, Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Right, Enum.KeyCode.Left, Enum.KeyCode.Space, Enum.KeyCode.LeftControl, Enum.KeyCode.LeftShift, Enum.KeyCode.LeftAlt)
    end
    function Input:Unblock()
        ContextActionService:UnbindAction("__FC")
        Wheld, Sheld, Aheld, Dheld, Eheld, Qheld = false, false, false, false, false, false
    end
    Input.__index = Input
end

local Connection
do
    function FreeCamera:Start()
        local Character = LocalPlayer.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.AutoRotate = false
            end
        end
        FreeCamera.CFrame = Camera.CFrame
        if Connection ~= nil then Connection:Disconnect() Connection = nil end
        Input:Block()
        Connection = RunService.RenderStepped:Connect(function()
            local Character = LocalPlayer.Character
            if Character then
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    Humanoid.AutoRotate = false
                    local Speed = FreeCamera.Speed
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                        Speed = Speed * 3
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then
                        Speed = Speed / 3
                    end
                    local newCFrame = FreeCamera.CFrame * CFrame.new((Aheld and Dheld and 0) or (Aheld and -Speed) or (Dheld and Speed), (Eheld and Qheld and 0) or (Qheld and -Speed) or (Eheld and Speed), (Wheld and Sheld and 0) or (Wheld and -Speed) or (Sheld and Speed))
                    FreeCamera.CFrame = CFrame.lookAt(newCFrame.p, newCFrame.p + Camera.CFrame.LookVector)
                    Camera.CFrame = FreeCamera.CFrame
                end
            end
        end)
    end
    function FreeCamera:Stop()
        if Connection ~= nil then Connection:Disconnect() Connection = nil end
        Input:Unblock()
        Wheld, Sheld, Aheld, Dheld, Eheld, Qheld = false, false, false, false, false, false
        local Character = LocalPlayer.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.AutoRotate = true
            end
        end
    end
    function FreeCamera:Unload()
        if Connection ~= nil then Connection:Disconnect() Connection = nil end
        Input:Unblock()
        local Character = LocalPlayer.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.AutoRotate = true
            end
        end
        Input, FreeCamera, Wheld, Sheld, Aheld, Dheld, Eheld, Qheld, Workspace, Camera, Players, LocalPlayer, RunService, UserInputService, HttpService, Lighting, NetworkClient, Mouse, ContextActionService = nil
    end
    FreeCamera.__index = FreeCamera
end

return FreeCamera
