local sensorInfo = {
	name = "GetTransportedUnits",
	desc = "Get all units transported by given cargo units",
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

return function (cargoUnits)
	local outUnits = {}
	for index, cargoUnitID in ipairs(cargoUnits) do
		if CheckUnitValid(cargoUnitID) then
			local loaded = Spring.GetUnitIsTransporting(cargoUnitID)
			if (loaded ~= nil and #loaded > 0) then
				for index2, loadedUnit in ipairs(loaded) do
					table.insert(outUnits, loadedUnit)
				end
			end
		end
	end
	return outUnits
end