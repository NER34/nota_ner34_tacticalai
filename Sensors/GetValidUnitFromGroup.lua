local sensorInfo = {
	name = "GetValidUnitFromGroup",
	desc = "returns the first valid unit in group",
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

function CheckUnitValid(unitID)
    if unitID == nil then return false end
    if Spring.ValidUnitID(unitID) == false then
        return false
    end
    if Spring.GetUnitHealth(unitID) <= 0 then
        return false
    end
    return true
end

return function (group)
	for idx = 1, #group do
		if CheckUnitValid(group[idx]) then
			return group[idx]
		end
	end
end