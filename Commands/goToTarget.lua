function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Move units in line formation following some leader",
		parameterDefs = {
			{ 
				name = "targets",
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

function Run(self, unitIds, parameter)
    local targets = parameter.targets
    if targets == nil then return FAILED end
    for id=1, #unitIds do
        if id > #targets then break end
        local targetPosRaw = targets[id]
        local targetPos = Vec3(targetPosRaw[1], 0, targetPosRaw[2])
        Spring.GiveOrderToUnit(unitIds[id], CMD.MOVE, targetPos:AsSpringVector(), {})
    end
    return RUNNING
end