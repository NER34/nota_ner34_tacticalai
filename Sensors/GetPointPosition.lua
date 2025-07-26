local sensorInfo = {
	name = "GetPointPosition",
	desc = "The sensor incapsulates a point position getting logic",
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

	local position = points[pointID].position
	return {position.x, position.y, position.z}
end