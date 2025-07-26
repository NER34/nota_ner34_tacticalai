local sensorInfo = {
	name = "IsFullGroup",
	desc = "Check if given group is full or it require reinforcement",
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

return function (group, count)
	if #group < count then
		return false
	end
	local counter = 0
	for id = 1, #group do
		if CheckUnitValid(group[id]) then
			counter = counter + 1
		end
	end
	return counter >= count
end