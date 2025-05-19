local sensorInfo = {
	name = "UpdateTargetsFilter",
	desc = "Updates rescue targets filter adding new targets to it",
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


return function (oldFilter, filteredUnits)

	local outFilter = {}
	for key, value in pairs(oldFilter) do
		outFilter[key] = value
	end
	for index, value in ipairs(filteredUnits) do
		outFilter[value] = 1
	end 
	return outFilter
end