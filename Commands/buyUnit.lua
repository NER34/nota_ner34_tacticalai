-- get madatory module operators
VFS.Include("modules.lua") -- modules table
VFS.Include(modules.attach.data.path .. modules.attach.data.head) -- attach lib module

-- get other madatory dependencies
attach.Module(modules, "message") -- communication backend load

function getInfo()
	return {
		onNoUnits = SUCCESS, -- instant success
		tooltip = "Buy unit in param. If unit can not be bought, the command continue its execution until it become possible",
		parameterDefs = {
			{ 
				name = "unitName",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "'armbox'",
			},
			{
				name = "unitCost",
				variableType = "expression",
				componentType = "editBox",
				defaultValue = "0",
			}
		}
	}
end

function Run(self, units, parameter)

	local metalInfo = { Spring.GetTeamResources(0, "metal") }
	if metalInfo[1] < parameter.unitCost then
		return RUNNING
	end

    message.SendRules({
        subject = "swampdota_buyUnit",
        data = {
			unitName = parameter.unitName
		},
    })
	
	return SUCCESS
end


function Reset(self)
	return self
end