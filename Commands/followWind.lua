function getInfo()
	return {
		onNoUnits = SUCCESS,
		tooltip = "Move units in square formation",
		parameterDefs = {
			{ 
				name = "unit",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			},
			--{ 
			--	name = "enabled",
			--	variableType = "expression",
			--	componentType = "checkBox",
			--	defaultValue = "true",
			--}
		}
	}
end

local stepDistanceMult = 10

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

local targetPos = nil
local targetDist = 40
local timer = 0
local timeout = 6

function Run(self, unitIds, parameter)

    local unit = parameter.unit

    if CheckUnitValid(unit) == false then
        return FAILURE
    end

	local unitPos = { Spring.GetUnitPosition(unit) }
	
	if targetPos == nil then
		local windInfo = { Spring.GetWind() }
		targetPos = Vec3(
			unitPos[1] + windInfo[1] * stepDistanceMult,
			unitPos[2],
			unitPos[3] + windInfo[3] * stepDistanceMult
		)
	end
	
	local currPos = Vec3(unitPos[1], unitPos[2], unitPos[3])
	if currPos:Distance(targetPos) <= targetDist then
		timer = 0
		targetPos = nil
		return SUCCESS
	else
		timer = timer + 1
		if timer == timeout then
			timer = 0
			targetPos = nil
			return FAILURE
		end
	end
	
	Spring.GiveOrderToUnit(unit, CMD.MOVE, targetPos:AsSpringVector(), {})
	return RUNNING
end