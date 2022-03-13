

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterNetEvent('admin:noClip')
AddEventHandler('admin:noClip', function(player)
    local _source = source
    local playerGroup

    if Config.VORP then
        local User = VorpCore.getUser(source)
        playerGroup = User.getGroup
    end
    local steamID = GetSteamID(_source)
  
    local authorized = false

    if Config.AllowedGroups then
        if playerGroup then
            for k,v in ipairs(Config.AllowedGroups) do
                if v == playerGroup then
                    TriggerClientEvent('admin:toggleNoClip', _source)
                    authorized = true
                end
            end
        end
    end

    if not authorized then
        if Config.AllowedSteamIDs then
            if steamID then 
                for k,v in ipairs(Config.AllowedSteamIDs) do
                    if v == steamID then
                        TriggerClientEvent('admin:toggleNoClip', _source)
                    end
                end
            end
        end
    end
end)

function GetSteamID(src)
    local sid = GetPlayerIdentifiers(src)[1] or false

	if (sid == false or sid:sub(1,5) ~= "steam") then
		return false
	end

	return sid
end

