-- Callsign Roof Numbers - Server Side

local PlayerCallsigns = {}

local function validCallsign(value)
    local num = tonumber(value)
    if not num then
        return false
    end

    if num < CallsignConfig.min or num > CallsignConfig.max then
        return false
    end

    return true
end

RegisterNetEvent('callsign:setCallsign')
AddEventHandler('callsign:setCallsign', function(callsignValue)
    local src = source

    if not callsignValue or not validCallsign(callsignValue) then
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            multiline = false,
            args = {'Callsign', 'Usage: /callsign [3-digit number] (100-999)'}
        })
        return
    end

    local fixed = string.format('%03d', tonumber(callsignValue))
    PlayerCallsigns[src] = fixed

    TriggerClientEvent('callsign:applyCallsign', src, fixed)
end)

AddEventHandler('playerDropped', function()
    local src = source
    PlayerCallsigns[src] = nil
end)
