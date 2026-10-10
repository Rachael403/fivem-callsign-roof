CallsignConfig = {
    min = 100,
    max = 999,

    -- Whitelist vehicles that support roof numbers.
    -- Each vehicle has 3 modkits for the 3-digit callsign
    -- roofModkits = { hundreds, tens, ones }
    vehicleWhitelist = {
        ["police"] = { roofModkits = { 48, 49, 50 } },
        ["police2"] = { roofModkits = { 48, 49, 50 } },
        ["police3"] = { roofModkits = { 48, 49, 50 } },
        ["police4"] = { roofModkits = { 48, 49, 50 } },
        ["policeb"] = { roofModkits = { 48, 49, 50 } },
        ["sheriff"] = { roofModkits = { 48, 49, 50 } },
        ["sheriff2"] = { roofModkits = { 48, 49, 50 } },
        ["fbi"] = { roofModkits = { 48, 49, 50 } },
        ["fbi2"] = { roofModkits = { 48, 49, 50 } },

        -- Add more here:
        -- ["your_vehicle_model"] = { roofModkits = { 48, 49, 50 } },
    }
}
