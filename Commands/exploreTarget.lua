function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Asks cargo unit to unload units at position in range",
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

local inProgress = false
local targetDist = 50
local retreat = false
local retreatPosRaw = {}
local lastMainScoutHP = 0

function Run(self, unitIds, parameter)

    local scouts = parameter.scouts
    local targets = parameter.targets
    local currTargetID = parameter.targetID

	local mainScout = scouts[#scouts]
	local currTarget = targets[currTargetID]
	local targetPos = Vec3(currTarget[1], 0, currTarget[3])

	if retreat then
		local currX, _, currZ = Spring.GetUnitPosition(mainScout)
		local currPos = Vec3(currX, 0, currZ)
		local retreatPos = Vec3(retreatPosRaw[1], 0, retreatPosRaw[3])
		if currPos:Distance(retreatPos) <= targetDist then
			retreat = false
			return FAILURE
		end
		return RUNNING
	end

	if inProgress then
		
		local currMainScoutHP = Spring.GetUnitHealth(mainScout)
		if currMainScoutHP < lastMainScoutHP then
			local retreatPos = Vec3(retreatPosRaw[1], 0, retreatPosRaw[3])
			inProgress = false
			Spring.GiveOrderToUnit(mainScout, CMD.MOVE, retreatPos:AsSpringVector(), {})
			retreat = true
		end

		local currX, _, currZ = Spring.GetUnitPosition(mainScout)
		local currPos = Vec3(currX, 0, currZ)
		if currPos:Distance(targetPos) <= targetDist then
			inProgress = false
			return SUCCESS
		end
	else
		inProgress = true
		lastMainScoutHP = Spring.GetUnitHealth(mainScout)
		retreatPosRaw = { Spring.GetUnitPosition(mainScout) }
		Spring.GiveOrderToUnit(mainScout, CMD.MOVE, targetPos:AsSpringVector(), {})
	end

	return RUNNING
end