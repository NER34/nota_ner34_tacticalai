function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Asks cargo unit to load other units at position in range",
		parameterDefs = {
			{ 
				name = "cargoUnits",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			},
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

    local cargoUnits = parameter.cargoUnits
    local targets = parameter.targets

	local finished = true
	local currTargetID = 1
	for id=1, #cargoUnits do
		if (currTargetID > #targets) then
			break
		end
		local cargoUnit = cargoUnits[id]
		if CheckUnitValid(cargoUnit) then
			local transported = Spring.GetUnitIsTransporting(cargoUnit)
			if #transported <= 0 then
				finished = false
				local position = { Spring.GetUnitPosition(targets[currTargetID]) }
				Spring.GiveOrderToUnit(
					cargoUnit, CMD.LOAD_UNITS, 
					{position[1], position[2], position[3], 1}, 
					{}
				)
			end
			currTargetID = currTargetID + 1
		end
	end
	if finished then return SUCCESS end
	return RUNNING
end