local sensorInfo = {
	name = "DivideForces",
	desc = "Divides forces into scouts and a strike teams",
	author = "NER34",
	date = "2025-05-13",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function(group, numScouts)

	table.sort(group, function(keyLhs, keyRhs) 
		local unitLDefID = Spring.GetUnitDefID(keyLhs)
		local unitRDefID = Spring.GetUnitDefID(keyRhs)
		return UnitDefs[unitLDefID].health < UnitDefs[unitRDefID].health 
	end)

	local scouts = {}
	local strike = {}
	for id=1, #group do
		if id <= numScouts then
			table.insert(scouts, group[id])			
		else
			table.insert(strike, group[id])
		end
	end
	return {scouts, strike}
end