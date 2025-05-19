local sensorInfo = {
	name = "GetNextTargetPosition",
	desc = "Get next target position. Chosen among all targets, that have position and are not in filter",
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

return function (targets, targetPositions, filter)
	
	for id=1, #targets do
		local unitID = targets[id]
		if filter == nil or filter[unitID] == nil then
			if targetPositions[unitID] ~= nil then
				return targetPositions[unitID]
			end
		end
	end
	return nil
end