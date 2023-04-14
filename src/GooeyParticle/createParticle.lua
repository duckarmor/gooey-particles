local HttpService = game:GetService("HttpService")

local conditionalProperty = require(script.Parent.Parent.Utility.conditionalProperty)
local Types = require(script.Parent.Parent.Utility.Types)

local RNG = Random.new()

type Emitter = Types.Emitter
type GooeyParticleEmitter = Types.GooeyParticleEmitter
type GooeyParticleProps = Types.GooeyParticleProps
type GooeyParticle = Types.GooeyParticle

local function getParticleLifetime(lifetime: number | NumberRange): number
	if typeof(lifetime) == "number" then
		return lifetime
	end

	return RNG:NextNumber(lifetime.Min, lifetime.Max)
end

local function getParticleVelocity(spread: NumberRange, speed: number): Vector2
	local angle = RNG:NextNumber(spread.Min, spread.Max)
	local radAngle = math.rad(angle)

	local run = math.cos(radAngle) * speed
	local rise = math.sin(radAngle) * speed

	return Vector2.new(run, rise) * 5
end

local function createParticleObject(container: GuiObject, props: GooeyParticleProps): ImageLabel
	local particle = Instance.new("ImageLabel")
	particle.AnchorPoint = Vector2.new(0.5, 0.5)
	particle.BackgroundTransparency = 1
	particle.Image = props.Image
	particle.ZIndex = props.ZIndex

	conditionalProperty(
		particle,
		typeof(props.Size) == "number",
		"Size",
		UDim2.fromOffset(props.Size :: number, props.Size :: number)
	)
	conditionalProperty(particle, typeof(props.Transparency) == "number", "ImageTransparency", props.Transparency)
	conditionalProperty(particle, typeof(props.Color) == "Color3", "ImageColor3", props.Color)
	particle.Parent = container

	return particle
end

local function createParticle(emitter: Emitter | GooeyParticleEmitter)
	local id = HttpService:GenerateGUID(false)
	local lifetime = getParticleLifetime(emitter.props.Lifetime)

	local position = Vector2.zero
	local absoluteSize = emitter.container.AbsoluteSize
	if absoluteSize.Magnitude > 0 then
		position = Vector2.new(RNG:NextInteger(0, absoluteSize.X), RNG:NextInteger(0, absoluteSize.Y))
	end

	local particle: GooeyParticle = {
		lifetime = lifetime,
		obj = createParticleObject(emitter.container, emitter.props),
		remove = function()
			emitter.particles[id] = nil
		end,
		rotation = RNG:NextNumber(emitter.props.Rotation.Min, emitter.props.Rotation.Max),
		spawnedAt = os.clock(),
		position = position,
		velocity = getParticleVelocity(emitter.props.Spread, emitter.props.Speed),
	}

	emitter.particles[id] = particle
end

return createParticle
