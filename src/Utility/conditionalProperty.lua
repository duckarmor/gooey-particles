local function conditionalProperty(object: GuiObject, condition: boolean, property: string, value: any)
	if condition == true then
		(object :: any)[property] = value
	end
end

return conditionalProperty
