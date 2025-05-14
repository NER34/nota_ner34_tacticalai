function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Move units in line formation following some leader",
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

local firstRun = true
local targetDist = 100

function Run(self, unitIds, parameter)
    local group = parameter.group
    local position = parameter.position
	local targetPos = Vec3(position[1], 0, position[3])
	if firstRun then
		firstRun = false
		for id=1, #group do
			Spring.GiveOrderToUnit(group[id], CMD.MOVE, targetPos:AsSpringVector(), {})
		end
		return RUNNING
	else
		local finished = true
		for id=1, #group do
			local currX, currY, currZ = Spring.GetUnitPosition(group[id])
			local currPos = Vec3(currX, 0, currZ)
            if currPos:Distance(targetPos) > targetDist then
				finished = false
			end
		end
		if finished then 
			firstRun = true
			return SUCCESS 
		end
		return RUNNING
	end
end