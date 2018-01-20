require 'src/utilities'
require 'src/settings'

require 'src/forcefield'
require 'src/emitter'
require 'src/gui'

require 'src/testing'



-- on load game for first time or when settings change
function init()
  if not global.forcefields then
    global.forcefields = {}
  end
  global.forcefields.version = 1.0
end

script.on_init(function(_)
  Settings:verifySettings()
  init()
end)

script.on_configuration_changed(function (data)
  if data.mod_changes and data.mod_changes.ForceFields then
    Settings:verifySettings()
    init()
  end
end)



-- on loading the map
script.on_event(defines.events.on_tick, nil)
script.on_load(function(event)
  if global.forcefields and global.forcefields.ticking then
    script.on_event(defines.events.on_tick, function(_) Emitter:onTick() end)
  end
end)



-- When entities get created
function onEntityBuilt(event)
  if event.created_entity.name == Settings.emitterName then
    Emitter:onEmitterBuilt(event.created_entity)
  end
end

script.on_event(defines.events.on_built_entity, onEntityBuilt)
script.on_event(defines.events.on_robot_built_entity, onEntityBuilt)



-- When entities get damaged (creates a trigger entity)
script.on_event(defines.events.on_trigger_created_entity, function(event)
  -- Check if a forcefield is damaged
  if event.entity.name == Settings.fieldDamagedTriggerName then
    local position = event.entity.position
    local surface = event.entity.surface
    event.entity.destroy() -- Removes the trigger
    Forcefield:onForcefieldDamaged(surface, position)
  end
end)



-- When entities get destroyed
script.on_event(defines.events.on_entity_died, function(event)
  if Settings.forcefieldTypes[event.entity.name] ~= nil then
    Forcefield:onForcefieldDied(event.entity)
  elseif event.entity.name == Settings.emitterName then
    Emitter:onEmitterDied(event.entity)
  end
end)



-- When entities get mined/deconstructed
script.on_event(defines.events.on_pre_player_mined_item, function(event)
  if Settings.forcefieldTypes[event.entity.name] ~= nil then
    Forcefield:onForcefieldMined(event.entity, event.player_index)
  elseif event.entity.name == Settings.emitterName then
    Emitter:onEmitterMined(event.entity, event.player_index)
  end
end)

script.on_event(defines.events.on_robot_pre_mined, function(event)
  if event.entity.name == Settings.emitterName then
    Emitter:onEmitterMined(event.entity)
  end
end)

script.on_event(defines.events.on_marked_for_deconstruction, function(event)
  if event.entity.name == Settings.emitterName then
    local emitterTable = Emitter:findEmitter(event.entity)
    if emitterTable ~= nil then
      emitterTable["disabled"] = true
      Forcefield:degradeLinkedFields(emitterTable)
    end
  end
end)

script.on_event(defines.events.on_canceled_deconstruction, function(event)
  if event.entity.name == Settings.emitterName then
    local emitterTable = Emitter:findEmitter(event.entity)
    if emitterTable ~= nil then
      emitterTable["disabled"] = false
      Forcefield:setActive(emitterTable, true)
    end
  end
end)



-- When the player quick paste settings
script.on_event(defines.events.on_entity_settings_pasted, function(event)
  if event.source.name == Settings.emitterName and event.destination.name == Settings.emitterName then
    Emitter:onEntitySettingsPasted(event)
  end
end)



-- When the player clicks on the emitter to open the gui
script.on_event(defines.events.on_gui_opened, function(event)
  if event.gui_type == defines.gui_type.entity and event.entity.name == Settings.emitterName then
    Gui:onOpenGui(event.entity, event.player_index)
  end
end)

-- When the player wants to close the gui
script.on_event(defines.events.on_gui_closed, function(event)
  Gui:onCloseGui(event.element, event.player_index)
end)

-- When the player clicks on a button
script.on_event(defines.events.on_gui_click, function(event)
  if Gui.guiButtonHandlers[event.element.name] then
    Gui.guiButtonHandlers[event.element.name](Gui, event)
  end
end)
