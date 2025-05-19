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

local transporting = {}

function Run(self, unitIds, parameter)

    local cargoUnits = parameter.cargoUnits
    local position = parameter.position

	local finished = true
	for id=1, #cargoUnits do
		local cargoUnit = cargoUnits[id]
		if CheckUnitValid(cargoUnit) then
			local transported = Spring.GetUnitIsTransporting(cargoUnit)
			if #transported > 0 then
				finished = false
				transporting[cargoUnit] = transported[1]
				Spring.GiveOrderToUnit(
					cargoUnit, CMD.UNLOAD_UNITS, 
					{position[1], position[2], position[3], 200}, 
					{"shift"}
				)
			elseif transporting[cargoUnit] ~= nil then
				local targetID = transporting[cargoUnit]
				local targetPos = Vec3(position[1], position[2], position[3])
				Spring.GiveOrderToUnit(targetID, CMD.MOVE, targetPos:AsSpringVector(), {})
				Spring.GiveOrderToUnit(cargoUnit, CMD.STOP, {}, {})
			end
		end
	end
	if finished then 
		return SUCCESS 

		end
	return RUNNING
end