--!strict
local function isEmpty(table)
	return next(table) == nil
end

return isEmpty
