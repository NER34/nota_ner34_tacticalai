local sensorInfo = {
	name = "GetUnitsOtherThen",
	desc = "Get list of units exept those passed into function",
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

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

return function (unitsToFilter)
	local filteredUnits = {}
	for idx=1, #units do
		if true ~= has_value(unitsToFilter, units[idx]) then
			table.insert(filteredUnits, units[idx])
		end
	end
	return filteredUnits
end