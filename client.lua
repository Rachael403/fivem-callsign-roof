-- Callsign Roof Numbers - Client Side
-- Each digit of the 3-digit callsign uses its own modkit

local function notify(msg, color)
    color = color or {255, 255, 0}
    TriggerEvent('chat:addMessage', {
        color = color,
        multiline = false,
        args = {'Callsign', msg}
    })
end

local function getVehicleConfig()
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then
        return nil
    end

    local veh = GetVehiclePedIsIn(ped, false)
    local modelHash = GetEntityModel(veh)
    local modelName = string.lower(GetDisplayNameFromVehicleModel(modelHash))

    return CallsignConfig.vehicleWhitelist[modelName]
end

local function extractDigits(callsign)
    local str = tostring(callsign)
    local hundreds = tonumber(string.sub(str, 1, 1)) or 0
    local tens = tonumber(string.sub(str, 2, 2)) or 0
    local ones = tonumber(string.sub(str, 3, 3)) or 0
    return hundreds, tens, ones
end

local function applyRoofNumber(callsign)
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then
        notify('You must be in a whitelisted vehicle.', {255, 0, 0})
        return false
    end

    local veh = GetVehiclePedIsIn(ped, false)
    if not veh or veh == 0 then
        return false
    end

    local config = getVehicleConfig()
    if not config then
        notify('This vehicle is not whitelisted for roof numbers.', {255, 0, 0})
        return false
    end

    local hundreds, tens, ones = extractDigits(callsign)

    if config.roofModkits and #config.roofModkits == 3 then
        SetVehicleMod(veh, config.roofModkits[1], hundreds, false)
        SetVehicleMod(veh, config.roofModkits[2], tens, false)
        SetVehicleMod(veh, config.roofModkits[3], ones, false)
    end

    SetVehicleNumberPlateText(veh, tostring(callsign))
    return true
end

RegisterNetEvent('callsign:applyCallsign')
AddEventHandler('callsign:applyCallsign', function(callsign)
    if applyRoofNumber(callsign) then
        notify('Roof number set to: ' .. tostring(callsign), {0, 255, 0})
    end
end)

RegisterCommand('callsign', function(source, args)
    if #args ~= 1 then
        notify('Usage: /callsign [3-digit number] (100-999)', {255, 0, 0})
        return
    end

    local value = tostring(args[1])

    if not value:match('^%d%d%d$') then
        notify('Usage: /callsign [3-digit number] (100-999)', {255, 0, 0})
        return
    end

    local num = tonumber(value)
    if num < CallsignConfig.min or num > CallsignConfig.max then
        notify('Callsign must be between 100 and 999.', {255, 0, 0})
        return
    end

    TriggerServerEvent('callsign:setCallsign', value)
end, false)
