local Types = require(script.Parent.Parent.Utility.Types)
local isEmpty = require(script.Parent.Parent.Utility.isEmpty)

type Emitter = Types.Emitter
type GooeyParticleEmitter = Types.GooeyParticleEmitter

local function removeEmitter(
	emitter: Emitter | GooeyParticleEmitter,
	disconnectEmitter: () -> ()
): (onComplete: () -> () | nil) -> ()
	return function(onComplete)
		emitter.props.Rate = 0

		task.spawn(function()
			repeat
				task.wait()
			until isEmpty(emitter.particles) == true

			disconnectEmitter()

			if onComplete ~= nil then
				onComplete()
			end
		end)
	end
end

return removeEmitter
