local sensorInfo = {
	name = "GetUnitsOfTypeFromGroup",
	desc = "Takes group of units and returns subgroup of units of definite types",
	author = "NER34",
	date = "now",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT
	}
end

function CheckUnitValid(unitID)
    if unitID == nil 	then return false end
    if Spring.ValidUnitID(unitID) == false then
        return false
    end
	local health = Spring.GetUnitHealth(unitID)
	if health == nil 	then return false end
    if health <= 0 		then return false end
    return true
end

return function (group, unitTypeNames)
	local outUnits = {}
	for idx = 1, #group do
		local unitID = group[idx]
		if CheckUnitValid(unitID) then
			local unitDefID = Spring.GetUnitDefID(unitID)
			local unitName = UnitDefs[unitDefID].name
			for id=1, #unitTypeNames do
				if (unitName == unitTypeNames[id]) then 
					table.insert(outUnits, unitID)
					break
				end
			end
		end
	end
	return outUnits
end