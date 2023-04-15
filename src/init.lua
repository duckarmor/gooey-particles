local reconcileParticleProps = require(script.Utility.ParticleProps.reconcileParticleProps)
local registerEmitter = require(script.GooeyEmitter.registerEmitter)
local registerSingleEmitter = require(script.GooeyEmitter.registerSingleEmitter)
local Types = require(script.Utility.Types)

export type GooeyParticleProps = Types.GooeyParticleProps
export type GooeyEmitter = Types.GooeyEmitter

local GooeyParticles = {}

local function createFrame(container: GuiObject, pos: UDim2)
	local frame = Instance.new("Frame")
	frame.AnchorPoint = Vector2.new(0, 0)
	frame.BackgroundTransparency = 1
	frame.Position = pos
	frame.Size = UDim2.fromScale(1, 1)
	frame.Parent = container

	return frame
end

function GooeyParticles.Emit(container: GuiObject, pos: UDim2, props: GooeyParticleProps, emitAmount: number): ()
	reconcileParticleProps(props)

	local frame = createFrame(container, pos)

	registerSingleEmitter(frame, props, emitAmount, function()
		frame:Destroy()
		frame = nil
	end)
end

function GooeyParticles.CreateEmitter(container: GuiObject, pos: UDim2, props: GooeyParticleProps): GooeyEmitter
	reconcileParticleProps(props)

	local frame = createFrame(container, pos)

	local gooeyEmitter = {
		container = frame,
		emitter = nil,
		props = props,
	}

	function gooeyEmitter:SetEnabled(enabled: boolean): ()
		if enabled == true then
			if self.emitter == nil then
				self.emitter = registerEmitter(self.container, self.props)
			end
		elseif enabled == false then
			if self.emitter ~= nil then
				self.emitter()
				self.emitter = nil
			end
		end
	end

	function gooeyEmitter:Destroy(onComplete: () -> () | nil): ()
		if self.emitter ~= nil then
			self.emitter(function()
				self.container:Destroy()

				if onComplete ~= nil then
					onComplete()
				end
			end)
		end
	end

	return gooeyEmitter
end

return GooeyParticles
