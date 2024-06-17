local function teleportPlayer(location)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local entity = vehicle ~= 0 and vehicle or playerPed

    SetEntityCoords(entity, location.x, location.y, location.z, false, false, false, true)
    SetEntityHeading(entity, GetEntityHeading(entity))
end

local function setupTarget()
    for _, loc in ipairs(Config.TeleportLocations) do
        exports.ox_target:addSphereZone({
            coords = loc.from,
            radius = 1.5,
            options = {
                {
                    name = loc.name,
                    label = 'Teleport',
                    icon = 'fas fa-portal-enter',
                    onSelect = function()
                        teleportPlayer(loc.to)
                    end,
                },
            },
        })
    end
end

CreateThread(function()
    setupTarget()
end)
