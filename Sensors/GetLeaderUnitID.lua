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

-- local myTeamID = Spring.GetMyTeamID()
-- local myPlayerID = Spring.GetMyPlayerID()

return function (unitTypeName)

	local unitDef = UnitDefNames[unitTypeName]
	if (unitDef == nil) then return nil end
	--return unitDef.id
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