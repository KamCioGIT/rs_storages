local Core = exports.vorp_core:GetCore()
local Inv = exports.vorp_inventory

local function registerStorage(prefix, name, limit)
    local isInvRegstered <const> = Inv:isCustomInventoryRegistered(prefix)
    if not isInvRegstered then
        local data <const> = {
            id = prefix,
            name = name,
            limit = limit,
            acceptWeapons = true,
            shared = true,
            ignoreItemStackLimit = true,
            whitelistItems = false,
            UsePermissions = false,
            UseBlackList = false,
            whitelistWeapons = false,

        }
        Inv:registerInventory(data)
    end
end

local function getSourceInfo(user, _source)
    local sourceCharacter <const> = user.getUsedCharacter
    local charname <const> = sourceCharacter.firstname .. ' ' .. sourceCharacter.lastname
    local sourceIdentifier <const> = sourceCharacter.identifier
    local steamname <const> = GetPlayerName(_source)
    return charname, sourceIdentifier, steamname
end

RegisterNetEvent("rs_storages:Server:OpenStorage", function(key)
    local _source <const> = source
    local user <const> = Core.getUser(_source)
    if not user then return end

    local prefix = "rs_storage_" .. key
    local storageData = Config.Storage[key]
    if not storageData then return end

    local storageName <const> = storageData.Name
    local storageLimit <const> = storageData.Limit

    registerStorage(prefix, storageName, storageLimit)
    Inv:openInventory(_source, prefix)
end)

AddEventHandler("onResourceStart", function(resource)
    if resource ~= GetCurrentResourceName() then return end

    for key, value in pairs(Config.Storage) do
        local prefix = "rs_storage_" .. key
        registerStorage(prefix, value.Name, value.Limit)
    end
end)