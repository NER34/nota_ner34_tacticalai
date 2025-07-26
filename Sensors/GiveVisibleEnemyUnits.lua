local sensorInfo = {
	name = "GiveVisibleEnemyUnits",
	desc = "Returns non ally units visible by given ally unit in given radius",
	author = "NER34",
	date = "now",
	license = "notAlicense",
}

local EVAL_PERIOD_DEFAULT = -1 -- acutal, no caching

function getInfo()
	return {
		period = EVAL_PERIOD_DEFAULT 
	}
end

return function (unitID, radius)
	local x, y, z = Spring.GetUnitViewPosition(unitID)
	local visibleUnits = Spring.GetUnitsInSphere(x, y, z, radius)
	local outUnits = {}
	for id=1, #visibleUnits do
		local unit = visibleUnits[id]
		if Spring.GetUnitAllyTeam(unit) ~= 0 then
			table.insert(outUnits, unit)
		end
	end
	return outUnits
end