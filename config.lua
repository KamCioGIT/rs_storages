Config= {}

Config.Keys = 0x4CC0E2FE

Config.Storage = {

    Valentine = {                                   -- Valentine unique inventory ID
        Name = "Storage",                           -- Name of the inventory
        Limit = 1000,                               -- Inventory space limit
        Coords = vector3(-288.74, 808.77, 119.44),  -- Coordinates where the inventory open prompt is located
        Jobs = { "doctorvl" }                       -- Jobs = { "doctorvl" } only a single job can access the inventory -- Jobs = { "doctorvl", "doctorsb" } you can add multiple jobs
    },                                              -- Jobs = false  anyone can open the inventory

    Strawberry = {
        Name = "Storage",
        Limit = 1000,
        Coords = vector3(-1803.33, -432.59, 158.83),
        Jobs = { "doctorsb" }
    },

    SaintDenis = {
        Name = "Storage",
        Limit = 1000,
        Coords = vector3(2733.1, -1230.26, 50.42),
        Jobs = { "doctorsd" }
    },

    Rhodes = {
        Name = "Storage",
        Limit = 1000,
        Coords = vector3(1374.4, -1305.79, 77.95),
        Jobs = { "doctorrh" }
    },

    Blackwater = {
        Name = "Storage",
        Limit = 1000,
        Coords = vector3(-787.59, -1302.64, 43.79),
        Jobs = { "doctorbw" }
    },
}

Config.text = {
    Press = "Open Storage",
    PlayerNearbyCantOpenInventory = "Another player is too close to open the storage.",
    Not = "You are not authorized to open the storage",
}

