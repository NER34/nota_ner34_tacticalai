local sensorInfo = {
	name = "GetVisibleTargets",
	desc = "Get all rescue targets visible by the first valid unit in group",
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

local myTeamID = Spring.GetMyTeamID()

return function (group, targetPositions)
	local targets = {}
	for id=1, #group do
		local unitID = group[id]
		if CheckUnitValid(unitID) then
			local x, y, z = Spring.GetUnitViewPosition(unitID)
			local visibleUnits = Spring.GetUnitsInSphere(x, y, z, 500, myTeamID)
			for idx=1, #visibleUnits do
				local targetID = visibleUnits[idx]
				if targetPositions[targetID] ~= nil then
					table.insert(targets, targetID)
				end
			end
			return targets
		end
	end
	return nil
end