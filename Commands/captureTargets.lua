function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Asks scouts except the last one to capture selected target",
		parameterDefs = {
			{ 
				name = "scouts",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			},
			{ 
				name = "targets",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			},
			{ 
				name = "targetID",
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

local lastTargetID = -1

function Run(self, unitIds, parameter)

    local scouts = parameter.scouts
    local targets = parameter.targets
    local currTargetID = parameter.targetID

	if currTargetID < 1 or currTargetID > #targets then
		return RUNNING
	end

	local currTarget = targets[currTargetID]
	local targetPos = Vec3(currTarget[1], 0, currTarget[3])

	if (lastTargetID ~= currTargetID) then
		for id=currTargetID, #scouts-1 do
			Spring.GiveOrderToUnit(scouts[id], CMD.MOVE, targetPos:AsSpringVector(), {})
		end
	end

	return RUNNING
end