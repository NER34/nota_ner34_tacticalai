local sensorInfo = {
	name = "GetUnitsTypes",
	desc = "Get types of selected units",
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


return function ()
	local outUnits = {}
	for idx = 1, #units do
		local unitDefID = Spring.GetUnitDefID(units[idx])
		table.insert(outUnits, UnitDefs[unitDefID].name)
	end
	return outUnits
end