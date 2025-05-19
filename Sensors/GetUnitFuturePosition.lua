local sensorInfo = {
	name = "GetUnitsTypes",
	desc = "Returns position depending on unit current position and movement direction",
	author = "NER34",
	date = "now",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function (unitID)
	local x, y, z = Spring.GetUnitPosition(unitID)
	local dx, dy, dz = Spring.GetUnitDirection(unitID)
	return {
		x + dx * 100,
		y + dy * 100,
		z + dz * 100
	}
end