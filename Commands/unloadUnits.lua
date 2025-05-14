function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Asks cargo unit to unload units at position in range",
		parameterDefs = {
			{ 
				name = "cargoUnit",
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
    local position = parameter.position
    local radius = parameter.radius

	local transported = Spring.GetUnitIsTransporting (cargoUnit)
	--Spring.Echo(tostring(transported))
	if transported == nil or #transported == 0 then
		return SUCCESS
	end
			
	Spring.GiveOrderToUnit(
		cargoUnit, CMD.UNLOAD_UNITS, 
		{position[1], position[2], position[3], radius}, 
		{"shift"}
	)

	return RUNNING
end