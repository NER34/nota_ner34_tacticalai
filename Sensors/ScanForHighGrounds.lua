local sensorInfo = {
	name = "ScanForHighGrounds",
	desc = "Return approximate high ground positions",
	author = "NER34",
	date = "2025-05-12",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

-- speedups
local SpringGetUnitDefID = Spring.GetUnitDefID

local Filter = {
	{-1, 0},
	{1, 0},
	{0, -1},
	{0, 1}
}
local CheckLocalMax=function (x, z, height, step)
	for id=1, #Filter do
		local xTemp = x + Filter[id][1] * step[1]
		local zTemp = z + Filter[id][2] * step[2]
		if height < Spring.GetGroundHeight(xTemp, zTemp) then
			return false
		end
	end
	return true
end

-- local GetPointAndMult=function(info)
-- 	return info[1], info[2]
-- end
-- 
-- local GetPointsDists=function(point1, point2)
-- 	return math.abs(point1[1] - point2[1]), math.abs(point1[2] - point2[2])
-- end

return function(startPosition, endPosition, step, floorHeight)

	local highGrounds = {}
	for x=startPosition[1], endPosition[1], step[1] do
		for z=startPosition[2], endPosition[2], step[2] do
			local height = Spring.GetGroundHeight(x, z)
			if height > floorHeight then
				if true == CheckLocalMax(x, z, height, step) then
					table.insert(highGrounds, {x, height, z})
				end
			end
		end
	end

	-- local highGroundsMerged = {}
	-- for id=#highGrounds, 1, -1 do
	-- 	local point, mult = GetPointAndMult(highGrounds[id])
	-- 	local save = true
	-- 	for idComp=id-1, 1, -1 do
	-- 		local pointComp, multComp = GetPointAndMult(highGrounds[idComp])
	-- 		local xDist, zDist = GetPointsDists(point, pointComp)
	-- 
	-- 		if xDist == step[1] or zDist == step[2] then
	-- 			if xDist ~= step[1] or zDist ~= step[2] then
	-- 				save = false
	-- 				pointComp[1] = pointComp[1] + point[1]
	-- 				pointComp[2] = pointComp[2] + point[2]
	-- 				multComp = multComp + mult
	-- 				highGrounds[idComp] = { pointComp, multComp }
	-- 				break
	-- 			end
	-- 		end
	-- 	end
	-- 	if save then
	-- 		table.insert(highGroundsMerged, point)
	-- 	end
	-- end
	-- return highGroundsMerged
	return highGrounds
	-- local thisUnitDefID = SpringGetUnitDefID(units[1])
	-- return UnitDefs[thisUnitDefID][id]
end