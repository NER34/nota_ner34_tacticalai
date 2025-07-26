local sensorInfo = {
	name = "GetRadarPosition",
	desc = "The sensor incapsulates radar position calculation logic",
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

return function (radarType, safePoint, targetPoint, offset)

	local targetPosVec 	= Vec3(targetPoint[1], 0, targetPoint[3])
	local safePosVec = Vec3(safePoint[1], 0, safePoint[3])
	local radarRadius = UnitDefNames[radarType].radarRadius
	local direction	= safePosVec - targetPosVec
	direction = direction:GetNormal()
	local defencePos = direction:Mul(radarRadius + offset) + targetPosVec

	return { defencePos.x, 0, defencePos.z }
end