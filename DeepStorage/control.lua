
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



-- on entity removal
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



-- on entity gui
local function onGuiOpened(event)
  if event.entity and event.entity.name == Settings.storageMonitorName then
    ChestManager:onOpenGui(event.entity, event.player_index)
  end
end
local function onGuiClosed(event)
  ChestManager:onCloseGui(event.entity, event.element, event.playerIndex)
end
local function onGuiClicked(event)
end





script.on_event(defines.events.on_built_entity, onConstructionEntity)
script.on_event(defines.events.on_robot_built_entity, onConstructionEntity)

script.on_event(defines.events.on_marked_for_deconstruction, onMarkedForDeconstruction)
script.on_event(defines.events.on_pre_player_mined_item, onDeconstructionEntity)
script.on_event(defines.events.on_robot_pre_mined, onDeconstructionEntity)

script.on_event(defines.events.on_entity_died, onEntityDestroyed)

script.on_event(defines.events.on_tick, onTick)

script.on_event(defines.events.on_gui_opened, onGuiOpened)
script.on_event(defines.events.on_gui_closed, onGuiClosed)
script.on_event(defines.events.on_gui_click, onGuiClicked)



-- on load game for first time
script.on_init(function()
  Debug:onInit()
  ChestManager:onInit()
end)

-- on player created
script.on_event(defines.events.on_player_created, function(event)
  Debug:onPlayerCreated(event.player_index)
end)
