local defaultParticleProps = require(script.Parent.defaultParticleProps)
local Types = require(script.Parent.Parent.Types)

type GooeyParticleProps = Types.GooeyParticleProps

local function reconcileParticleProps(props: GooeyParticleProps): ()
	props = table.clone(props)

	for propertyName, defaultValue in pairs(defaultParticleProps) do
		if props[propertyName] == nil then
			props[propertyName] = defaultValue
		end
	end

	return props
end

return reconcileParticleProps
