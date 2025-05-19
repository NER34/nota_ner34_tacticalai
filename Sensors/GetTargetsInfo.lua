local sensorInfo = {
	name = "GetTargetsInfo",
	desc = "Collects info about all rescue targets on the map",
	author = "NER34",
	date = "now",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = 0 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

local filter = {
	["armatlas"] 	= 0,
	["armpeep"] 	= 0,
	["armrad"]		= 0,
	["armwin"]		= 0
}

return function ()
	local targets = {}
	local allies = Spring.GetTeamUnits(0)
	for id=1, #allies do
		local unitID = allies[id]
		local defID = Spring.GetUnitDefID(unitID)
		if filter[UnitDefs[defID].name] == nil then
			table.insert(targets, unitID)
		end
	end

	local targetPositions = {}
	for id=1, #targets do
		local unitID = targets[id]
		targetPositions[unitID] = { Spring.GetUnitPosition(unitID) }
	end

	table.sort(targets, function(idA, idB) 
		local posA = targetPositions[idA]
		local posB = targetPositions[idB]
		return posA[3] < posB[3]
	end)

	return { targets, targetPositions }
end