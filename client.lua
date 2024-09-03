local Config = Config or {}

function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
end

function spawnNPC(x, y, z, heading, model)
    local ped = CreatePed(4, model, x, y, z, heading, true, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedDiesWhenInjured(ped, false)
    SetEntityInvincible(ped, true)
    SetPedCanRagdoll(ped, false)
    ClearPedTasksImmediately(ped)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    
    FreezeEntityPosition(ped, true)
    
    SetPedCanBeTargetted(ped, false)
    SetPedFleeAttributes(ped, 0, false)
    SetPedCombatAttributes(ped, 17, true)
    SetPedSeeingRange(ped, 0.0)
    SetPedHearingRange(ped, 0.0)
    SetPedAlertness(ped, 0)
end

Citizen.CreateThread(function()
    for _, loc in ipairs(Config.NPCLocations) do
        loadModel(loc.model)
        spawnNPC(loc.x, loc.y, loc.z, loc.heading, loc.model)
    end
end)
