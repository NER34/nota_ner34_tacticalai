function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Asks cargo unit to load other units at position in range",
		parameterDefs = {
			{ 
				name = "cargoUnit",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			},
			{
				name = "groupToLoad",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			},
			{ 
				name = "position",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			},
			{ 
				name = "radius",
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

function Run(self, unitIds, parameter)

    local cargoUnit = parameter.cargoUnit
    local group = parameter.groupToLoad
    local position = parameter.position
    local radius = parameter.radius

	local transported = Spring.GetUnitIsTransporting (cargoUnit)
	local finished = true
	for id1=1, #group do
		local inCargo = false
		for id2=1, #transported do
			if group[id1] == transported[id2] then
				inCargo = true
				break
			end
		end
		if inCargo == false then
			finished = false
			break
		end
	end

	if finished then
		return SUCCESS
	end
			
	Spring.GiveOrderToUnit(
		cargoUnit, CMD.LOAD_UNITS, 
		{position[1], position[2], position[3], radius}, 
		{"shift"}
	)

	return RUNNING
end