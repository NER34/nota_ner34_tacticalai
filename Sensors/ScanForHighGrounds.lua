local sensorInfo = {
	name = "ScanForHighGrounds",
	desc = "Return approximate high ground positions",
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

	return highGrounds
end