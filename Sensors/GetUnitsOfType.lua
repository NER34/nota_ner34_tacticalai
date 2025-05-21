local sensorInfo = {
	name = "GetUnitsOfType",
	desc = "Get units of definite type",
	author = "NER34",
	date = "now",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT
	}
end

return function (unitTypeName)
	Spring.Echo(unitTypeName)
	local outUnits = {}
	for idx = 1, #units do
		local unitDefID = Spring.GetUnitDefID(units[idx])
		if (unitTypeName == UnitDefs[unitDefID].name) then 
		--	table.insert(outUnits, units[idx])
			outUnits[#outUnits+1] = units[idx]
		end
	end
	return outUnits
end