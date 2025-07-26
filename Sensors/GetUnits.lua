local sensorInfo = {
	name = "GetUnits",
	desc = "Get units assigned to current behavior tree",
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

return function ()
	return units
end