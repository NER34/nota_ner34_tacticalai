function getInfo()
	return {
		onNoUnits = FAILURE,
		tooltip = "Move units in line formation following some leader",
		parameterDefs = {
			{ 
				name = "leader",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			},
			{ 
				name = "unitsToFollow",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "nil",
			},
		--	{ 
		--		name = "enabled",
		--		variableType = "expression",
		--		componentType = "checkBox",
		--		defaultValue = "true",
		--	}
		}
	}
end

local posOffset = 40
local targetDist = 40
local firstRun = true

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

    local leader = parameter.leader
    local unitsToFollow = parameter.unitsToFollow

    if #unitsToFollow == 0 then 
        firstRun = true
        return FAILURE
    end
    if CheckUnitValid(leader) == false then
        firstRun = true
        return FAILURE
    end

    local leaderPos = { Spring.GetUnitPosition(leader) }
    local leaderDir = { Spring.GetUnitDirection(leader) }

    local finished = true
    local numInvalidUnits = 0
    for idx=1, #unitsToFollow do

        if CheckUnitValid(unitsToFollow[idx]) == false then
            numInvalidUnits = numInvalidUnits + 1
        else
            
            local currX, currY, currZ = Spring.GetUnitPosition(unitsToFollow[idx])
            local currPos = Vec3(currX, 0, currZ)

            local relIdx = math.floor((idx+1) / 2)
            if (idx % 2 > 0) then
                relIdx = relIdx * -1
            end
                
            local targetX = leaderPos[1] + (-leaderDir[3] * relIdx * posOffset)
            local targetZ = leaderPos[3] + (leaderDir[1] * relIdx * posOffset)
            local targetPos = Vec3(targetX, 0, targetZ)

            if firstRun then
                firstRun = false
                finished = false
                Spring.GiveOrderToUnit(unitsToFollow[idx], CMD.MOVE, targetPos:AsSpringVector(), {})
            end
            if currPos:Distance(targetPos) > targetDist then
                firstRun = false
                finished = false
                --local patObj = Path.RequestPath(0, currX, 0, currZ, targetX, 0, targetZ)
                --Spring.Echo(unitsToFollow[idx] .. " - Still not finished: (" .. tostring(patObj) .. ")")
                Spring.GiveOrderToUnit(unitsToFollow[idx], CMD.MOVE, targetPos:AsSpringVector(), {})
            end
        end
    end

    if numInvalidUnits == #unitsToFollow then
        firstRun = true
        return FAILURE
    end
    if finished then
        firstRun = true
        return SUCCESS 
    end
    return RUNNING
end