function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Move units to the definite position. If all units are dead, command continue execution until newly created units finish it",
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
				defaultValue = "{0, 0, 0}",
			},
			{ 
				name = "targetDist",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "300",
			},
			{ 
				name = "fight",
				variableType = "expression",
				componentType = "checkBox",
				defaultValue = "false",
			}
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


function Run(self, unitIds, parameter)

    local group = parameter.group
	if #group == 0 then return RUNNING end

    local position = parameter.position
	local targetPos = Vec3(position[1], 0, position[3])
	local targetDist = parameter.targetDist
	local fight = parameter.attack

	local cmdID = CMD.MOVE
	if (fight) then cmdID = CMD.FIGHT end
	
	local finished = true
	local eliminated = 0
	for id=1, #group do
		local unitID = group[id]
		local currX, _, currZ = Spring.GetUnitPosition(unitID)
		local currPos = Vec3(currX, 0, currZ)
		if CheckUnitValid(unitID) then
			if currPos:Distance(targetPos) > targetDist then
				finished = false			
				Spring.GiveOrderToUnit(unitID, CMD.MOVE_STATE, {0}, {})
				Spring.GiveOrderToUnit(unitID, CMD.FIRE_STATE, {2}, {})
				Spring.GiveOrderToUnit(unitID, cmdID, targetPos:AsSpringVector(), {})
			end
		else
			eliminated = eliminated + 1
		end
	end

	if #group == eliminated then return RUNNING end
	if finished 			then return SUCCESS end
	return RUNNING
end