Framework = nil
local AvatarCache = {}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        if Config.Tebex then 
            local tebexConvar = GetConvar('sv_tebexSecret', '')
            if tebexConvar == '' or tebexConvar == nil then
                print('^1////////////////////////////////////////////////////////////////////////////////////////////////////////////')
                print('^1//////////////////////////////////////////^Tebex Secret Missing.^1//////////////////////////////////////////')
                print('^1////////////////////////////////////////////////////////////////////////////////////////////////////////////')
                print('es-case: Tebex Secret Missing please set in server.cfg and try again. Script will not work correctly.')
            end
        end
    end
end)

RegisterCommand("purchase", function(source, args)
    if source == 0 then 
    local encode = json.decode(args[1])  
    print(GetCurrentResourceName(), 'A product has been sold on Tebex! '..encode.transid..'')
    ExecuteSql("INSERT INTO eyes_purchase (tebex, amount) VALUES ('"..encode.transid.."', '"..args[2].."')")
    end
end)


if Config.Framework == "ESX" or Config.Framework == 'NewESX' then
    Citizen.CreateThread(function()
        Framework = GetFramework()   
            Framework.RegisterServerCallback('GetSell', function(source, cb, data)
                local Player = Framework.GetPlayerFromId(source)
                local profile = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..GetPlayerIdentifier(source, 1).."'")
                UpSell = profile[1].gold + data.rewards.sell 
                if data.rewards.item ~= '' or data.rewards.item ~= nil then 
                    cb(true , profile[1].gold)
                    ExecuteSql("UPDATE eyes_case SET identifier = '"..GetPlayerIdentifier(source, 1).."', gold = '"..UpSell.."' ")
                    else
                    cb(false, profile[1].gold)
                end
            end)

            Framework.RegisterServerCallback('GoldBuy', function(source, cb, data)
                local Player = Framework.GetPlayerFromId(source)
                local user = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..GetPlayerIdentifier(source, 1).."'")
                for k,v in pairs(data) do 
                    if tonumber(Player.getAccount("bank").money) >= tonumber(v.price) then 
                        UpGold = user[1].gold + v.price
                        Player.removeAccountMoney('bank', tonumber(v.price))
                        cb(true, Player.getAccount("bank").money)
                        ExecuteSql("UPDATE eyes_case SET identifier = '"..GetPlayerIdentifier(source, 1).."', gold = '"..UpGold.."' ")
                    else
                        cb(false, Player.getAccount("bank").money)
                    end
                end
            end)
            
            Framework.RegisterServerCallback('Case', function(source, cb, data)
                local Player = Framework.GetPlayerFromId(source)
                local user = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..GetPlayerIdentifier(source, 1).."'")
                Down = user[1].gold - data.case.price
                if tonumber(user[1].gold) >= tonumber(data.case.price) then 
                    cb(true)
                    ExecuteSql("UPDATE eyes_case SET identifier = '"..GetPlayerIdentifier(source, 1).."', gold = '"..Down.."' ")
                    else
                    cb(false)
                end
            end)

            RegisterNetEvent('give')
            AddEventHandler('give', function(source, data)
                local player = Framework.GetPlayerFromId(source)
                giveitem(data)
            end)


            function giveitem(Give)
                Give.item = string.lower(Give.item)
                local player = Framework.GetPlayerFromId(source)
                if Give.type == 'car' then 
                    local vehicleData = nil
                    vehicleData = {}
                    local vehicle = nil
                    local plate = nil
                    plate = string.upper(GetRandomLetter(3) .. GetRandomNumber(3))
                    vehicleData.model = GetHashKey(Give.item)
                    vehicleData.plate = plate
                    ExecuteSql("INSERT INTO owned_vehicles (owner, plate, vehicle, type, stored) VALUES ('"..player.identifier.."', '"..plate.."', '"..json.encode(vehicleData).."', 'car', 0)")
                end
                if Give.type == 'item' then 
                    player.addInventoryItem(Give.item, 1)
                end
            end

            RegisterNetEvent('esx:playerLoaded')
            AddEventHandler('esx:playerLoaded', function(src)
                Wait(1000)
                local result = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..GetPlayerIdentifier(src, 1).."' ")
                if result[1] == nil then 
                    ExecuteSql("INSERT INTO eyes_case (identifier, gold) VALUES ('"..GetPlayerIdentifier(src, 1).."', 0)")
                    Wait(2000)
                    sendToDiscord(src,"\n > Player Name:" .. GetPlayerName(src),"> ID:" .. src .. "\n> Table:" .. json.encode(result).. "\n > New player data created!")
                end
            end)

            Accept = function(Player, Data)
                local tebex = ExecuteSql("SELECT * FROM eyes_purchase WHERE tebex = '"..Data.key.."'")
                local player = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..Player.."'")
                Up = player[1].gold + tebex[1].amount
                ExecuteSql("UPDATE eyes_case SET identifier = '"..Player.."', gold = '"..Up.."' ")
            end

            Framework.RegisterServerCallback('Profile', function(source, cb, data)
                local Player = Framework.GetPlayerFromId(source)
                Avatar = GetAvatar(source)
                local Detail = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..GetPlayerIdentifier(source, 1).."'")
                cb(Detail[1].gold, Player.getAccount("bank").money, GetPlayerName(source), Avatar)
            end)


            Framework.RegisterServerCallback('GetPurchase', function(source, cb, data)
                local Player = Framework.GetPlayerFromId(source)
                local result = ExecuteSql("SELECT * FROM eyes_purchase WHERE tebex = '"..data.key.."' ")
                if result[1].tebex == data.key then 
                    Accept(GetPlayerIdentifier(source, 1), data)
                    ExecuteSql("DELETE FROM eyes_purchase WHERE tebex = '"..data.key.."'")
                    cb(true, result[1].amount)
                    sendToDiscord(source,"\n > Player Name:" .. GetPlayerName(source),"> ID:" .. source .. "\n> Key:" .. data.key .. "\n > Tebex key used!")
                    else
                    cb(false, result[1].amount)
                end
            end)    

         
             end
            )         
elseif Config.Framework == "QBCore" or Config.Framework == "OLDQBCore" then
    if Config.Framework == "OLDQBCore" then
        while Framework == nil do
            TriggerEvent(
                "QBCore:GetObject",
                function(obj)
                    Framework = obj
                end
            )
            Citizen.Wait(4)
        end
    else
        Framework = exports["qb-core"]:GetCoreObject()

        Framework.Functions.CreateCallback('GetSell', function(source, cb, data)
            local Player = Framework.Functions.GetPlayer(source)
            local profile = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..GetPlayerIdentifier(source).."'")
            UpSell = profile[1].gold + data.rewards.sell 
            if data.rewards.item ~= '' or data.rewards.item ~= nil then 
                cb(true, profile[1].gold)
                ExecuteSql("UPDATE eyes_case SET identifier = '"..Player.PlayerData.citizenid.."', gold = '"..UpSell.."' ")
                else
                cb(false, profile[1].gold)
            end
        end)


        
        
        Framework.Functions.CreateCallback('Case', function(source, cb, data)
            local Player = Framework.Functions.GetPlayer(source)
            local user = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..Player.PlayerData.citizenid.."'")
            Down = user[1].gold - data.case.price
            if tonumber(user[1].gold) >= tonumber(data.case.price) then 
                cb(true)
                ExecuteSql("UPDATE eyes_case SET identifier = '"..Player.PlayerData.citizenid.."', gold = '"..Down.."' ")
                else
                cb(false)
            end
        end)

        Framework.Functions.CreateCallback('GoldBuy', function(source, cb, data)
            local Player = Framework.Functions.GetPlayer(source)
            local user = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..Player.PlayerData.citizenid.."'")
            for k,v in pairs(data) do 
                if tonumber(Player.PlayerData.money["bank"]) >= tonumber(v.price) then 
                    UpGold = user[1].gold + v.price
                    Player.Functions.RemoveMoney("bank", tonumber(v.price))
                    cb(true, Player.PlayerData.money["bank"])
                    ExecuteSql("UPDATE eyes_case SET identifier = '"..Player.PlayerData.citizenid.."', gold = '"..UpGold.."' ")
                else
                    cb(false, Player.PlayerData.money["bank"])
                end
            end
        end)

        RegisterNetEvent('give')
        AddEventHandler('give', function(source, data)
            local player = Framework.Functions.GetPlayer(source)
            giveitem(data)
        end)


        function giveitem(Give)
            Give.item = string.lower(Give.item)
            local Player = Framework.Functions.GetPlayer(source)
            if Give.type == 'car' then 
                local vehicleData = nil
                vehicleData = {}
                local vehicle = nil
                local plate = nil
                plate = string.upper(GetRandomLetter(3) .. GetRandomNumber(3))
                vehicleData.model = GetHashKey(Give.item)
                vehicleData.plate = plate
                if Config.Garage == 'qb-garages' then 
                local vehicleProps = {
                    doorStatus = {},  
                    tireBurstState = {},  
                    windowStatus = {} 
                }  
                local modsJson = json.encode(vehicleProps)  
                local vehicleHash = GetHashKey(Give.item) 
                local query = "INSERT INTO player_vehicles (license, citizenid, plate, vehicle, hash, garage, state, mods) VALUES ('" 
                .. Player.PlayerData.license .. "', '" 
                .. Player.PlayerData.citizenid .. "', '" 
                .. plate .. "', '" 
                .. Give.item .. "', " 
                .. vehicleHash .. ", 'pillboxgarage', 1, '"..modsJson.."')"
                ExecuteSql(query)
                else
                local modsJson = json.encode(vehicleProps)  
                local vehicleHash = GetHashKey(Give.item) 
                ExecuteSql("INSERT INTO player_vehicles (license, citizenid, plate, vehicle, status, state) VALUES ('"..Player.PlayerData.license.."', '"..Player.PlayerData.citizenid.."', '"..plate.."', '"..json.encode(vehicleData).."', 'car', 0)")
                end

            end
            if Give.type == 'item' then 
                Player.Functions.AddItem(Give.item, 1)
            end
        end



        Accept = function(Player, Data)
            local tebex = ExecuteSql("SELECT * FROM eyes_purchase WHERE tebex = '"..Data.key.."'")
            local player = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..Player.."'")
            Up = player[1].gold + tebex[1].amount
            ExecuteSql("UPDATE eyes_case SET identifier = '"..Player.."', gold = '"..Up.."' ")
        end

        Framework.Functions.CreateCallback('Profile', function(source, cb, data)
            Avatar = GetAvatar(source)
            local Player = Framework.Functions.GetPlayer(source)
            local result = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..Player.PlayerData.citizenid.."' ")
            if result[1] == nil then 
                ExecuteSql("INSERT INTO eyes_case (identifier, gold) VALUES ('"..Player.PlayerData.citizenid.."', 0)")
                sendToDiscord(source,"\n > Player Name:" .. GetPlayerName(source),"> ID:" .. source .. "\n> Table:" .. json.encode(result).. "\n > New player data created!")
            end
            local Detail = ExecuteSql("SELECT * FROM eyes_case WHERE identifier = '"..Player.PlayerData.citizenid.."'")
            cb(Detail[1].gold, Player.PlayerData.money["bank"], GetPlayerName(source), Avatar)
            end)


        Framework.Functions.CreateCallback('GetPurchase', function(source, cb, data)
            local Player = Framework.Functions.GetPlayer(source)
            local result = ExecuteSql("SELECT * FROM eyes_purchase WHERE tebex = '"..data.key.."' ")
            if result[1].tebex == data.key then 
                Accept(Player.PlayerData.citizenid, data)
                ExecuteSql("DELETE FROM eyes_purchase WHERE tebex = '"..data.key.."'")
                cb(true, result[1].amount)
                sendToDiscord(source,"\n > Player Name:" .. GetPlayerName(source),"> ID:" .. source .. "\n> Key:" .. data.key .. "\n > Tebex key used!")
                else
                cb(false)
            end
        end)

    end
end

function sendToDiscord(source, description, title, tumbnail)
    if Config.Framework == 'ESX' or Config.Framework == 'NewESX' then 
        local xPlayer = Framework.GetPlayerFromId(source)
    else
        local xPlayer = Framework.Functions.GetPlayer(source)
    end
    local src = source
    local DISCORD_NAME = GetPlayerName(src)
    local steamid, license, xbl, playerip, discord, liveid = getidentifiers(src)
    local EYES_IMG ="https://media.discordapp.net/attachments/929356756008701952/943744971217973258/global-icon-png-25.jpg"
    local embed = {
         {
              ["author"] = {
                   ["name"] = "EYES CASE SYSTEM INFORMATION",
                   ["url"] = "https://discord.gg/EkwWvFS",
                   ["icon_url"] = "https://media.discordapp.net/attachments/929356756008701952/937273446591787038/pngegg_2.png"
              },
              ["thumbnail"] = {
                   ["url"] = Avatar
              },
              ["fields"] = {
                   {
                        ["name"] = title,
                        ["value"] = description,
                        ["inline"] = false
                   },
                   {
                        ["name"] = "🍂",
                        ["value"] = "┌──── Extra Details: ────┐\n> " ..
                        steamid ..
                        "\n> " .. license .. "\n> " .. playerip .. "\n> " .. liveid .. "\n> " .. discord .. "",
                        ["inline"] = true
                   }
              },
              ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
         }
    }
    Citizen.Wait(tonumber(1000))
    PerformHttpRequest(Config.Log,
    function(err, text, headers)
         end,
         "POST",
         json.encode({username = DISCORD_NAME, embeds = embed, avatar_url = EYES_IMG}),
         {["Content-Type"] = "application/json"}
         )
    end

    getidentifiers = function(player)
        local steamid = "Not Linked"
        local license = "Not Linked"
        local discord = "Not Linked"
        local xbl = "Not Linked"
        local liveid = "Not Linked"
        local ip = "Not Linked"
    
        for k, v in pairs(GetPlayerIdentifiers(player)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamid = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xbl = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                ip = string.sub(v, 4)
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discordid = string.sub(v, 9)
                discord = "<@" .. discordid .. ">"
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            end
        end
    
        return steamid or GetPlayerIdentifier(player, 'steam'), license, xbl, ip, discord, liveid
    end

function ExecuteSql(query)
    local IsBusy = true
    local result = nil
    if Config.MySQL == "oxmysql" then
        if MySQL == nil then
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.oxmysql:execute(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.MySQL == "ghmattimysql" then
        exports.ghmattimysql:execute(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    elseif Config.MySQL == "mysql-async" then   
        MySQL.Async.fetchAll(query, {}, function(data)
            result = data
            IsBusy = false
        end)
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

function GetAvatar(source)
    local avatar = AvatarCache[source]

    if avatar then
        return avatar
    end

    if Config.FormattedToken == "" or not Config.FormattedToken then 
        avatar = GetRandomAvatar()
        AvatarCache[source] = avatar
        return avatar
    end

    local steamhex = GetPlayerIdentifier(source, 'steam')
    local discordId = nil

    for _, id in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end

    if steamhex then
        local steamid = tonumber(steamhex:sub(7), 16)
        local data, error = HttpGet(('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=%s&steamids=%s'):format(GetConvar('steam_webApiKey'), steamid))
        
        if not error then
            avatar = data.response.players[1].avatarfull
            AvatarCache[source] = avatar
            return avatar
        end
    elseif discordId then
        avatar = GetDiscordAvatar(discordId)
        AvatarCache[source] = avatar
        return avatar
    end
    avatar = GetRandomAvatar()
    AvatarCache[source] = avatar
    return avatar
end

function GetRandomAvatar()
    local baseUrl = "https://avatars.dicebear.com/api/human"
    local randomString = tostring(math.random(1000, 9999))
    local options = {
        mood = {"happy", "sad"}, 
        background = {"%23" .. tostring(math.random(100, 999))}, 
        hairColor = {"black", "brown", "blond", "red", "blue"}, 
    }
    local function getRandomOption(optionList)
        return optionList[math.random(1, #optionList)]
    end
    local avatarUrl = string.format("%s/%s.svg?mood=%s&background=%s&hairColor=%s", 
    baseUrl, 
    randomString, 
    getRandomOption(options.mood),
    getRandomOption(options.background),
    getRandomOption(options.hairColor))
    return avatarUrl
end


local NumberCharset = {}
local Charset = {}
for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end
function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end