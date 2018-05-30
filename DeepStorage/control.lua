
require 'lib/utilities/debug'
require 'src/chestManager'



-- on tick
local function onTick()
  ChestManager:onTick()
end



-- on entity created
local function onConstructionEntity(event)
  if event.created_entity and event.created_entity.valid and event.created_entity.name == Settings.storageChestName then
    ChestManager:onChestCreated(event.created_entity)
  end
end



local function onEntityDestroyed(event)
  -- TODO
end



local function onMarkedForDeconstruction(event)
  -- TODO
end



local function onDeconstructionEntity(event)
  if event.entity.name == Settings.storageMonitorName then
    ChestManager:onChestDeconstruction(event.entity)
  end
end







script.on_event(defines.events.on_built_entity, onConstructionEntity)
script.on_event(defines.events.on_robot_built_entity, onConstructionEntity)

script.on_event(defines.events.on_marked_for_deconstruction, onMarkedForDeconstruction)
script.on_event(defines.events.on_pre_player_mined_item, onDeconstructionEntity)
script.on_event(defines.events.on_robot_pre_mined, onDeconstructionEntity)

script.on_event(defines.events.on_entity_died, onEntityDestroyed)

script.on_event(defines.events.on_tick, onTick)



-- on load game for first time
script.on_init(function()
  Debug:onInit()
  ChestManager:onInit()
end)

-- on player created
script.on_event(defines.events.on_player_created, function(event)
  Debug:onPlayerCreated(event.player_index)
end)
