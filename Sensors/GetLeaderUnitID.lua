local sensorInfo = {
	name = "GetLeaderUnitID",
	desc = "Get leader of definite type from the current group",
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

return function (unitTypeName)

	local unitDef = UnitDefNames[unitTypeName]
	if (unitDef == nil) then return nil end
	local leader = nil
	for idx = 1, #units do
		local unitDefID = Spring.GetUnitDefID(units[idx])
		if (unitDefID == unitDef.id) then 
			leader = units[idx]
			break
		end
	end
	return leader
end