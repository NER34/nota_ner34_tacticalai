local sensorInfo = {
	name = "GetDefencePosition",
	desc = "The sensor incapsulates the logic of calculating defence line position",
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

return function (group, safePoint, targetPoint, offset)

	local targetPosVec 	= Vec3(targetPoint[1], 0, targetPoint[3])
	local nearToTarget = Vec3(safePoint[1], 0, safePoint[3])
	local nearDist = nearToTarget:Distance(targetPosVec)
	for id=1, #group do
		local currX, _, currZ = Spring.GetUnitPosition(group[id])
		local currVec = Vec3(currX, 0, currZ)
		local currDist = currVec:Distance(targetPosVec)
		if currDist < nearDist then
			nearDist = currDist
			nearToTarget = currVec
		end
	end
	local direction	= targetPosVec - nearToTarget
	direction = direction:GetNormal()
	local defencePos = direction:Mul(offset) + nearToTarget

	return { defencePos.x, 0, defencePos.z }
end