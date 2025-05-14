local sensorInfo = {
	name = "GetUnitsOfType",
	desc = "Get units of definite type",
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

-- local myTeamID = Spring.GetMyTeamID()
-- local myPlayerID = Spring.GetMyPlayerID()

return function (unitTypeName)

	local unitDef = UnitDefNames[unitTypeName]
	if (unitDef == nil) then return nil end
	--return unitDef.id
	local outUnits = {}
	for idx = 1, #units do
		local unitDefID = Spring.GetUnitDefID(units[idx])
		if (unitDefID == unitDef.id) then 
			table.insert(outUnits, units[idx])
			break
		end
	end
	return outUnits
end