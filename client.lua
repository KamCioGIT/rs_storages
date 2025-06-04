local Core = exports.vorp_core:GetCore()
local group <const> = GetRandomIntInRange(0, 0xFFFFFF)
local prompt = 0

local function registerPrompts()
    if prompt ~= 0 then UiPromptDelete(prompt) end
    prompt = UiPromptRegisterBegin()
    UiPromptSetControlAction(prompt, Config.Keys)
    local label = VarString(10, "LITERAL_STRING", Config.text.Press)
    UiPromptSetText(prompt, label)
    UiPromptSetGroup(prompt, group, 0)
    UiPromptSetStandardMode(prompt, true)
    UiPromptRegisterEnd(prompt)
end

local function getClosestPlayer()
    local players = GetActivePlayers()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for _, playerId in ipairs(players) do
        if playerId ~= PlayerId() then
            local targetPed = GetPlayerPed(playerId)
            local targetCoords = GetEntityCoords(targetPed)
            if #(coords - targetCoords) < 2.0 then
                return true
            end
        end
    end
    return false
end

local isHandleRunning = false

local function tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

local function Handle()
    registerPrompts()
    isHandleRunning = true

    while true do
        local sleep = 1000
        local coords = GetEntityCoords(PlayerPedId())

        for key, data in pairs(Config.Storage) do
            local distance = #(coords - data.Coords)
            if distance < 2.0 then
                sleep = 0
                local label = VarString(10, "LITERAL_STRING", data.Name)
                UiPromptSetActiveGroupThisFrame(group, label, 0, 0, 0, 0)

                if UiPromptHasStandardModeCompleted(prompt, 0) then
                    local job = LocalPlayer.state.Character.Job
                    if data.Jobs == false or tableContains(data.Jobs, job) then
                        if not getClosestPlayer() then
                            TriggerServerEvent("rs_storages:Server:OpenStorage", key)
                        else
                            Core.NotifyObjective(Config.text.PlayerNearbyCantOpenInventory, 5000)
                        end
                    else
                        Core.NotifyObjective(Config.text.Not, 5000)
                    end
                end
            end
        end

        if not isHandleRunning then return end
        Wait(sleep)
    end
end

CreateThread(function()
    Handle()
end)