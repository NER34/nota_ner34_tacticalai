local sensorInfo = {
	name = "UnitDefValue",
	desc = "Return unit definition parameter value of the unit based on its name.",
	author = "PepeAmpere",
	date = "2017-04-27",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- speedups
local SpringGetUnitDefID = Spring.GetUnitDefID

-- @description return definition value of given unit
-- @argument unitID [number] unit we want to check
-- @argument paramName [string] name of the parameter
return function()
	return units[1]
	-- local thisUnitDefID = SpringGetUnitDefID(units[1])
	-- return UnitDefs[thisUnitDefID][id]
end