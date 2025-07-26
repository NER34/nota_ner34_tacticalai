function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Asks given units to stop",
		parameterDefs = {
			{ 
				name = "group",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
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

	for id=1, #group do
		local unit = group[id]
		if CheckUnitValid(unit) then
			Spring.GiveOrderToUnit(unit, CMD.STOP, {})
		end
	end

	return RUNNING

end