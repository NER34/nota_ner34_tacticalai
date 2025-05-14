function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Move units to the definite position",
		parameterDefs = {
			{ 
				name = "group",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			},
			{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			}
		--	{ 
		--		name = "enabled",
		--		variableType = "expression",
		--		componentType = "checkBox",
		--		defaultValue = "true",
		--	}
		}
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

local targetDist = 100

function Run(self, unitIds, parameter)
    local group = parameter.group
    local position = parameter.position
	local targetPos = Vec3(position[1], 0, position[3])
	
	local finished = true
	local eliminated = 0
	for id=1, #group do
		local currX, currY, currZ = Spring.GetUnitPosition(group[id])
		local currPos = Vec3(currX, 0, currZ)
		if false == CheckUnitValid(unitID) then
			eliminated = eliminated + 1
		elseif currPos:Distance(targetPos) > targetDist then
			finished = false
			Spring.GiveOrderToUnit(group[id], CMD.MOVE, targetPos:AsSpringVector(), {})
		end
	end

	if eliminated == #group then
		return FAILURE
	end

	if finished then 
		firstRun = true
		return SUCCESS 
	end
	return RUNNING
end