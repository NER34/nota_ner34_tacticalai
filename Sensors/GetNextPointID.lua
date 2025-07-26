local sensorInfo = {
	name = "GetNextPointID",
	desc = "The sensor incapsulates the logic of getting next point ID from the diven one",
	author = "NER34",
	date = "now",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function (points, pointID)

	if pointID == #points then
		return nil
	end

	local lastPointID = nil
	for id=pointID+1, #points do
		lastPointID = id
		if points[lastPointID].isStrongpoint then
			break
		end
	end
	return lastPointID
end