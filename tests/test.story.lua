local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local GooeyParticles = require(Packages.GooeyParticles)

return function(container)
	local frame = Instance.new("Frame")
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.fromScale(0.5, 0.5)
	frame.Size = UDim2.fromOffset(100, 100)
	frame.Parent = container

	local emitter = GooeyParticles.CreateEmitter(frame, UDim2.fromOffset(0, 0), {
		Acceleration = Vector2.zero,
		Color = Color3.fromRGB(255, 255, 255),
		Image = "rbxasset://textures/particles/sparkles_main.dds",
		Lifetime = 1,
		Rate = 300,
		Rotation = NumberRange.new(0),
		Size = NumberSequence.new(32, 64),
		Speed = 10,
		Spread = NumberRange.new(-90),
		Transparency = NumberSequence.new(0, 0.5),
		ZIndex = 1,
	})

	emitter:SetEnabled(true)

	return function()
		emitter:SetEnabled(false)
		emitter:Destroy()
		frame:Destroy()
	end
end
