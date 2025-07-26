function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Asks given units to attack given targets and only them. If all units are dead, command continue execution until newly created units finish it",
		parameterDefs = {
			{ 
				name = "group",
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
		}
	}
end

function CheckUnitValid(unitID)
    if unitID == nil then 
		return false 
	end
    if Spring.ValidUnitID(unitID) == false then
        return false
    end
	local health = Spring.GetUnitHealth(unitID)
	if health == nil then
		return true
	end
    if health <= 0 then
        return false
    end
    return true
end

function Run(self, unitIds, parameter)

    local targets = parameter.targets
	local target = nil
	for id=1, #targets do
		if CheckUnitValid(targets[id]) then
			target = targets[id]
			break
		end
	end
	if target == nil then
		return SUCCESS
	end
	
	local group = parameter.group
	for id=1, #group do
		local unit = group[id]
		if CheckUnitValid(unit) then
			Spring.GiveOrderToUnit(unit, CMD.FIRE_STATE, {0}, {})
			Spring.GiveOrderToUnit(unit, CMD.ATTACK, {target}, {})
		end
	end

	return RUNNING

end