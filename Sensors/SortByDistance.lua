local sensorInfo = {
	name = "SortByDistance",
	desc = "Sorts given targets by given position",
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

function getDistance(posVec, target)
	local targetX, _, targetZ = Spring.GetUnitPosition(target)
	local targetVec = Vec3(targetX, 0, targetZ)
	return posVec:Distance(targetVec)
end

return function (position, targets)

	local posVec = Vec3(position[1], 0, position[3])
	function compare(targetA, targetB)
		local distA = getDistance(posVec, targetA)
		local distB = getDistance(posVec, targetB)
		return distA < distB
	end
	table.sort(targets, compare)
	return targets

end