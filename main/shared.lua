Config = {}
Config.Tebex = false
Config.Log ="webhook add"
Config.MySQL = "mysql-async" -- mysql-async or oxmysql or ghmattimysql
Config.Framework = "QBCore" -- QBCore or ESX or OLDQBCore --NewESX

Config.FormattedToken = "" -- https://discord.com/developers/applications

Config.Garage = "qb-garages" -- for qb-garages select individual and for other garages select all


function GetFramework()
    local Get = nil
    if Config.Framework  == "ESX" then
        while Get == nil do
            TriggerEvent('esx:getSharedObject', function(Set) Get = Set end)
            Citizen.Wait(0)
        end
    end
    if Config.Framework  == "NewESX" then
        Get = exports['es_extended']:getSharedObject()
    end
    if Config.Framework  == "QBCore" then
        Get = exports["qb-core"]:GetCoreObject()
    end
    if Config.Framework  == "OldQBCore" then
        while Get == nil do
            TriggerEvent('QBCore:GetObject', function(Set) Get = Set end)
            Citizen.Wait(200)
        end
    end
    return Get
 end

 
----------------------------------------------------------------------------
function DiscordRequest(method, endpoint, jsondata)
    local data = nil

    PerformHttpRequest("https://discord.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
        data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = "Bot " .. Config.FormattedToken})
      
    while data == nil do
        Citizen.Wait(0)
    end
    
    return data
end
----------------------------------------------------------------------------
function GetDiscordAvatar(userID)
    local response = DiscordRequest("GET", "users/"..userID, {})
    if response.code == 200 then
        local userData = json.decode(response.data)
        local avatarID = userData.avatar
        local avatarURL = string.format("https://cdn.discordapp.com/avatars/%s/%s.png", userID, avatarID)
        return avatarURL
    else
        return nil
    end
end
----------------------------------------------------------------------------
function HttpGet(url)
    local data = nil
    local error = nil

    PerformHttpRequest(url, function(err, result, headers)
        if err == 200 then
            data = json.decode(result)
        else
            error = err
        end
    end, 'GET')

    while data == nil and error == nil do
        Citizen.Wait(0)
    end

    return data, error
end
----------------------------------------------------------------------------

function GetFramework()
   local Get = nil
   if Config.Framework == "ESX" then
       while Get == nil do
           TriggerEvent('esx:getSharedObject', function(Set) Get = Set end)
           Citizen.Wait(0)
       end
   end
   if Config.Framework == "NewESX" then
       Get = exports['es_extended']:getSharedObject()
   end
   if Config.Framework == "QBCore" then
       Get = exports["qb-core"]:GetCoreObject()
   end
   if Config.Framework == "OldQBCore" then
       while Get == nil do
           TriggerEvent('QBCore:GetObject', function(Set) Get = Set end)
           Citizen.Wait(200)
       end
   end
   return Get
end

Config.System = {
    ["Case Categories"] = {
        {border = "premium", label = "Premium Case", category = "premium"},
        {border = "standart", label = "Basic Case", category = "standart"}
    },
    ["Store Gold Section"] = {
        {price = 175},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150},
        {price = 150}
    },
    ["Items that can be found in the safe"] = {
        {id = "bag", border = "aqua"},
        {id = "hoodie", border = "green"},
        {id = "cash", border = "orange"},
        {id = "tnt", border = "green"},
        {id = "medkit", border = "purple"},
        {id = "watch", border = "green"},
        {id = "shoes", border = "red"},
        {id = "bag", border = "blue"},
        {id = "bag", border = "blue"},
        {id = "bag", border = "red"},
        {id = "bag", border = "green"},
        {id = "bag", border = "purple"},
        {id = "bag", border = "orange"},
        {id = "bag", border = "aqua"},
        {id = "bag", border = "purple"},
        {id = "bag", border = "red"},
        {id = "cash", border = "green"},
        {id = "tnt", border = "orange"},
        {id = "medkit", border = "blue"},
        {id = "cash", border = "green"},
        {id = "tnt", border = "orange"},
        {id = "medkit", border = "blue"}
    }
}

Config.Live = {
    -- Add Live Crates here:
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse - 380",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport (ninef)",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            },
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport (ninef)",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            },
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            },
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            },
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            }
        },
        category = "premium",
        price = 150,
        label = "Deluxe Cars",
        size = "105",
        icon = "car"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Ammo Pistol",
                item = "AMMO_PISTOL",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo MG",
                item = "AMMO_MG",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Riffle",
                item = "AMMO_RIFLE",
                size = 75,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Shotgun",
                item = "AMMO_SHOTGUN",
                size = 85,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo SMG",
                item = "AMMO_SMG",
                size = 70,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Ammo Case",
        size = "85",
        icon = "blue"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Money",
                item = "money",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Weed",
                item = "weed20g",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Whisky",
                item = "whisky",
                size = 65,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Green Case",
        size = "83",
        icon = "green"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            }
        },
        category = "premium",
        price = 150,
        label = "Deluxe Cars",
        size = "105",
        icon = "car"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Ammo Pistol",
                item = "AMMO_PISTOL",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo MG",
                item = "AMMO_MG",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Riffle",
                item = "AMMO_RIFLE",
                size = 75,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Shotgun",
                item = "AMMO_SHOTGUN",
                size = 85,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo SMG",
                item = "AMMO_SMG",
                size = 70,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Ammo Case",
        size = "85",
        icon = "blue"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Money",
                item = "money",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Weed",
                item = "weed20g",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Whisky",
                item = "whisky",
                size = 65,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Green Case",
        size = "83",
        icon = "green"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            }
        },
        category = "premium",
        price = 150,
        label = "Deluxe Cars",
        size = "105",
        icon = "car"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Auto Shotgun",
                item = "WEAPON_AUTOSHOTGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "APP Pistol",
                item = "WEAPON_APPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Taser",
                item = "WEAPON_STUNGUN",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Carbine",
                item = "WEAPON_ADVANCEDRIFLE",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_COMBATPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_PISTOL_MK2",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Single Armor",
                item = "armor",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Middle Armor",
                item = "armor2",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Pistol 50",
                item = "WEAPON_PISTOL50",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Flare Gun",
                item = "WEAPON_FLAREGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Heavy Pistol",
                item = "WEAPON_HEAVYPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Mini Smg",
                item = "WEAPON_MINISMG",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machine Pistol",
                item = "WEAPON_MACHINEPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machete",
                item = "WEAPON_MACHETE",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Marksman Pistol",
                item = "WEAPON_MARKSMANPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Launcher",
                item = "WEAPON_COMPACTLAUNCHER",
                size = 55,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Gun Case",
        size = "83",
        icon = "eagle"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Ammo Pistol",
                item = "AMMO_PISTOL",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo MG",
                item = "AMMO_MG",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Riffle",
                item = "AMMO_RIFLE",
                size = 75,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Shotgun",
                item = "AMMO_SHOTGUN",
                size = 85,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo SMG",
                item = "AMMO_SMG",
                size = 70,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Ammo Case",
        size = "85",
        icon = "blue"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Money",
                item = "money",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Weed",
                item = "weed20g",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Whisky",
                item = "whisky",
                size = 65,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Green Case",
        size = "83",
        icon = "green"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            }
        },
        category = "premium",
        price = 150,
        label = "Deluxe Cars",
        size = "105",
        icon = "car"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Auto Shotgun",
                item = "WEAPON_AUTOSHOTGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "APP Pistol",
                item = "WEAPON_APPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Taser",
                item = "WEAPON_STUNGUN",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Carbine",
                item = "WEAPON_ADVANCEDRIFLE",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_COMBATPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_PISTOL_MK2",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Single Armor",
                item = "armor",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Middle Armor",
                item = "armor2",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Pistol 50",
                item = "WEAPON_PISTOL50",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Flare Gun",
                item = "WEAPON_FLAREGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Heavy Pistol",
                item = "WEAPON_HEAVYPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Mini Smg",
                item = "WEAPON_MINISMG",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machine Pistol",
                item = "WEAPON_MACHINEPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machete",
                item = "WEAPON_MACHETE",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Marksman Pistol",
                item = "WEAPON_MARKSMANPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Launcher",
                item = "WEAPON_COMPACTLAUNCHER",
                size = 55,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Gun Case",
        size = "83",
        icon = "eagle"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Ammo Pistol",
                item = "AMMO_PISTOL",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo MG",
                item = "AMMO_MG",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Riffle",
                item = "AMMO_RIFLE",
                size = 75,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Shotgun",
                item = "AMMO_SHOTGUN",
                size = 85,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo SMG",
                item = "AMMO_SMG",
                size = 70,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Ammo Case",
        size = "85",
        icon = "blue"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Money",
                item = "money",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Weed",
                item = "weed20g",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Whisky",
                item = "whisky",
                size = 65,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Green Case",
        size = "83",
        icon = "green"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            }
        },
        category = "premium",
        price = 150,
        label = "Deluxe Cars",
        size = "105",
        icon = "car"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Auto Shotgun",
                item = "WEAPON_AUTOSHOTGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "APP Pistol",
                item = "WEAPON_APPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Taser",
                item = "WEAPON_STUNGUN",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Carbine",
                item = "WEAPON_ADVANCEDRIFLE",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_COMBATPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_PISTOL_MK2",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Single Armor",
                item = "armor",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Middle Armor",
                item = "armor2",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Pistol 50",
                item = "WEAPON_PISTOL50",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Flare Gun",
                item = "WEAPON_FLAREGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Heavy Pistol",
                item = "WEAPON_HEAVYPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Mini Smg",
                item = "WEAPON_MINISMG",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machine Pistol",
                item = "WEAPON_MACHINEPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machete",
                item = "WEAPON_MACHETE",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Marksman Pistol",
                item = "WEAPON_MARKSMANPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Launcher",
                item = "WEAPON_COMPACTLAUNCHER",
                size = 55,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Gun Case",
        size = "83",
        icon = "eagle"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Ammo Pistol",
                item = "AMMO_PISTOL",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo MG",
                item = "AMMO_MG",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Riffle",
                item = "AMMO_RIFLE",
                size = 75,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Shotgun",
                item = "AMMO_SHOTGUN",
                size = 85,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo SMG",
                item = "AMMO_SMG",
                size = 70,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Ammo Case",
        size = "85",
        icon = "blue"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Money",
                item = "money",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Weed",
                item = "weed20g",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Whisky",
                item = "whisky",
                size = 65,
                sell = 50,
                type = "item"
            }
        },
        category = "premium",
        price = 150,
        label = "Green Case",
        size = "83",
        icon = "green"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Auto Shotgun",
                item = "WEAPON_AUTOSHOTGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "APP Pistol",
                item = "WEAPON_APPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Taser",
                item = "WEAPON_STUNGUN",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Carbine",
                item = "WEAPON_ADVANCEDRIFLE",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_COMBATPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_PISTOL_MK2",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Single Armor",
                item = "armor",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Middle Armor",
                item = "armor2",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Pistol 50",
                item = "WEAPON_PISTOL50",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Flare Gun",
                item = "WEAPON_FLAREGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Heavy Pistol",
                item = "WEAPON_HEAVYPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Mini Smg",
                item = "WEAPON_MINISMG",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machine Pistol",
                item = "WEAPON_MACHINEPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machete",
                item = "WEAPON_MACHETE",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Marksman Pistol",
                item = "WEAPON_MARKSMANPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Launcher",
                item = "WEAPON_COMPACTLAUNCHER",
                size = 55,
                sell = 50,
                type = "item"
            }
        },
        category = "standart",
        price = 150,
        label = "Gun Case",
        size = "83",
        icon = "eagle"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Ammo Pistol",
                item = "AMMO_PISTOL",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo MG",
                item = "AMMO_MG",
                size = 80,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Riffle",
                item = "AMMO_RIFLE",
                size = 75,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo Shotgun",
                item = "AMMO_SHOTGUN",
                size = 85,
                sell = 50,
                type = "item"
            },
            {
                label = "Ammo SMG",
                item = "AMMO_SMG",
                size = 70,
                sell = 50,
                type = "item"
            }
        },
        category = "standart",
        price = 150,
        label = "Ammo Case",
        size = "85",
        icon = "blue"
    },
    {
        -- item <== If it is a vehicle here, it counts as a model, please write accordingly. (type ==)
        items = {
            {
                label = "Money",
                item = "money",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Weed",
                item = "weed20g",
                size = 65,
                sell = 50,
                type = "item"
            },
            {
                label = "Whisky",
                item = "whisky",
                size = 65,
                sell = 50,
                type = "item"
            }
        },
        category = "standart",
        price = 150,
        label = "Green Case",
        size = "83",
        icon = "green"
    }
}

Config.Standart = {
    -- Standard cases these are always in the subcategory

    {
        items = {
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse - 380",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport (ninef)",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            },
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport (ninef)",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            },
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            },
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            },
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            }
        },
        price = 150,
        label = "Car Case",
        size = 100,
        icon = "car"
    },

    {
        items = {
            {
                label = "Zentorno",
                item = "zentorno",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Apocalypse",
                item = "zr380",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Hermes",
                item = "hermes",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Transport",
                item = "moonbeam2",
                size = 105,
                sell = 50,
                type = "car"
            },
            {
                label = "Sport",
                item = "ninef",
                size = 95,
                sell = 50,
                type = "car"
            },
            {
                label = "Asterope",
                item = "asterope",
                size = 90,
                sell = 50,
                type = "car"
            }
        },
        price = 150,
        label = "Money Case",
        size = 105,
        icon = "money"
    },

    {
        items = {
            {
                label = "Auto Shotgun",
                item = "WEAPON_AUTOSHOTGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "APP Pistol",
                item = "WEAPON_APPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Taser",
                item = "WEAPON_STUNGUN",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Carbine",
                item = "WEAPON_ADVANCEDRIFLE",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_COMBATPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_PISTOL_MK2",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Single Armor",
                item = "armor",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Middle Armor",
                item = "armor2",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Pistol 50",
                item = "WEAPON_PISTOL50",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Flare Gun",
                item = "WEAPON_FLAREGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Heavy Pistol",
                item = "WEAPON_HEAVYPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Mini Smg",
                item = "WEAPON_MINISMG",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machine Pistol",
                item = "WEAPON_MACHINEPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machete",
                item = "WEAPON_MACHETE",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Marksman Pistol",
                item = "WEAPON_MARKSMANPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Launcher",
                item = "WEAPON_COMPACTLAUNCHER",
                size = 55,
                sell = 50,
                type = "item"
            }
        },
        price = 150,
        label = "Gun Case",
        size = 100,
        icon = "gun"
    },

    {
        items = {
            {
                label = "Auto Shotgun",
                item = "WEAPON_AUTOSHOTGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "APP Pistol",
                item = "WEAPON_APPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Taser",
                item = "WEAPON_STUNGUN",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Carbine",
                item = "WEAPON_ADVANCEDRIFLE",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_COMBATPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_PISTOL_MK2",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Single Armor",
                item = "armor",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Middle Armor",
                item = "armor2",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Pistol 50",
                item = "WEAPON_PISTOL50",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Flare Gun",
                item = "WEAPON_FLAREGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Heavy Pistol",
                item = "WEAPON_HEAVYPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Mini Smg",
                item = "WEAPON_MINISMG",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machine Pistol",
                item = "WEAPON_MACHINEPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machete",
                item = "WEAPON_MACHETE",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Marksman Pistol",
                item = "WEAPON_MARKSMANPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Launcher",
                item = "WEAPON_COMPACTLAUNCHER",
                size = 55,
                sell = 50,
                type = "item"
            }
        },
        price = 150,
        label = "Armor Case",
        size = 100,
        icon = "armor"
    },

    {
        items = {
            {
                label = "Auto Shotgun",
                item = "WEAPON_AUTOSHOTGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "APP Pistol",
                item = "WEAPON_APPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Taser",
                item = "WEAPON_STUNGUN",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Carbine",
                item = "WEAPON_ADVANCEDRIFLE",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_COMBATPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_PISTOL_MK2",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Single Armor",
                item = "armor",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Middle Armor",
                item = "armor2",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Pistol 50",
                item = "WEAPON_PISTOL50",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Flare Gun",
                item = "WEAPON_FLAREGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Heavy Pistol",
                item = "WEAPON_HEAVYPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Mini Smg",
                item = "WEAPON_MINISMG",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machine Pistol",
                item = "WEAPON_MACHINEPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machete",
                item = "WEAPON_MACHETE",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Marksman Pistol",
                item = "WEAPON_MARKSMANPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Launcher",
                item = "WEAPON_COMPACTLAUNCHER",
                size = 55,
                sell = 50,
                type = "item"
            }
        },
        price = 150,
        label = "Bronze Case",
        size = 100,
        icon = "bronze"
    },

    {
        items = {
            {
                label = "Auto Shotgun",
                item = "WEAPON_AUTOSHOTGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "APP Pistol",
                item = "WEAPON_APPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Taser",
                item = "WEAPON_STUNGUN",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Carbine",
                item = "WEAPON_ADVANCEDRIFLE",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_COMBATPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_PISTOL_MK2",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Single Armor",
                item = "armor",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Middle Armor",
                item = "armor2",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Pistol 50",
                item = "WEAPON_PISTOL50",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Flare Gun",
                item = "WEAPON_FLAREGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Heavy Pistol",
                item = "WEAPON_HEAVYPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Mini Smg",
                item = "WEAPON_MINISMG",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machine Pistol",
                item = "WEAPON_MACHINEPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machete",
                item = "WEAPON_MACHETE",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Marksman Pistol",
                item = "WEAPON_MARKSMANPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Launcher",
                item = "WEAPON_COMPACTLAUNCHER",
                size = 55,
                sell = 50,
                type = "item"
            }
        },
        price = 150,
        label = "Silver Case",
        size = 100,
        icon = "silver"
    },

    {
        items = {
            {
                label = "Auto Shotgun",
                item = "WEAPON_AUTOSHOTGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "APP Pistol",
                item = "WEAPON_APPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Taser",
                item = "WEAPON_STUNGUN",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Carbine",
                item = "WEAPON_ADVANCEDRIFLE",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_COMBATPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_PISTOL_MK2",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Single Armor",
                item = "armor",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Middle Armor",
                item = "armor2",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Pistol 50",
                item = "WEAPON_PISTOL50",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Flare Gun",
                item = "WEAPON_FLAREGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Heavy Pistol",
                item = "WEAPON_HEAVYPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Mini Smg",
                item = "WEAPON_MINISMG",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machine Pistol",
                item = "WEAPON_MACHINEPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machete",
                item = "WEAPON_MACHETE",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Marksman Pistol",
                item = "WEAPON_MARKSMANPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Launcher",
                item = "WEAPON_COMPACTLAUNCHER",
                size = 55,
                sell = 50,
                type = "item"
            }
        },
        price = 150,
        label = "Gold Case",
        size = 100,
        icon = "gold"
    },

    {
        items = {
            {
                label = "Auto Shotgun",
                item = "WEAPON_AUTOSHOTGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "APP Pistol",
                item = "WEAPON_APPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Taser",
                item = "WEAPON_STUNGUN",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Carbine",
                item = "WEAPON_ADVANCEDRIFLE",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_COMBATPISTOL",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Pistol",
                item = "WEAPON_PISTOL_MK2",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Single Armor",
                item = "armor",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Middle Armor",
                item = "armor2",
                size = 60,
                sell = 50,
                type = "item"
            },
            {
                label = "Pistol 50",
                item = "WEAPON_PISTOL50",
                size = 50,
                sell = 50,
                type = "item"
            },
            {
                label = "Flare Gun",
                item = "WEAPON_FLAREGUN",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Heavy Pistol",
                item = "WEAPON_HEAVYPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Mini Smg",
                item = "WEAPON_MINISMG",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machine Pistol",
                item = "WEAPON_MACHINEPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Machete",
                item = "WEAPON_MACHETE",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Marksman Pistol",
                item = "WEAPON_MARKSMANPISTOL",
                size = 55,
                sell = 50,
                type = "item"
            },
            {
                label = "Combat Launcher",
                item = "WEAPON_COMPACTLAUNCHER",
                size = 55,
                sell = 50,
                type = "item"
            }
        },
        price = 150,
        label = "Platinium Case",
        size = 100,
        icon = "platinium"
    },

}
