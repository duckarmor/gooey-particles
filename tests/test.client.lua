local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local GooeyParticles = require(Packages.GooeyParticles)

local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local screenGui = Instance.new("ScreenGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.Size = UDim2.fromOffset(100, 100)
frame.Parent = screenGui

local emitter = GooeyParticles.CreateEmitter(frame, UDim2.fromOffset(0, 0), {
	Acceleration = Vector2.zero,
	EmissionDirection = Enum.NormalId.Top,
	Color = Color3.fromRGB(255, 255, 255),
	Image = "rbxasset://textures/particles/sparkles_main.dds",
	Lifetime = 1,
	Rate = 5,
	Rotation = NumberRange.new(0),
	Size = 32,
	Speed = 1,
	Spread = NumberRange.new(0),
	Transparency = 0,
	ZIndex = 1,
})

emitter:SetEnabled(true)
