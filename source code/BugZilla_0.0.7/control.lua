require 'lib/utilities/math'
require 'lib/utilities/generic'

require 'lib/bugzilla/despawn-penalty'
require 'lib/bugzilla/boss'
require 'lib/bugzilla/phase-cycler'

require 'lib/death-ui'
require 'lib/deathscream'
require 'lib/corpse-flare'



-- on load game for first time
script.on_init(function(_)
  Math:Init()

  PhaseCycler:Init()
  DespawnPenalty:Init()
  Boss:Init()

  DeathUI:Init()
  CorpseFlare:Init()
end)



-- on mod version different or if mod did not previously exist
script.on_configuration_changed(function(data)
  if data.mod_changes and data.mod_changes.BugZilla and data.mod_changes.BugZilla.old_version then
    Boss:OnConfigurationChanged()
    DespawnPenalty:OnConfigurationChanged()

    DeathUI:OnConfigurationChanged()
  end
end)



-- called when a new player joins the game
script.on_event(defines.events.on_player_created, function(event)
  DeathUI:OnNewPlayerCreated(event.player_index)
end)



-- called when a mod setting changed
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
  PhaseCycler:OnSettingsChanged(event)
end)



-- called once per in-game tick
script.on_event(defines.events.on_tick, function(event)
  if game.tick % 60 == 0 then -- each second
    PhaseCycler:OnSecond()
    Boss:OnSecond()
    DespawnPenalty:OnSecond()
  end
end)



-- called every time a chunk gets generated
script.on_event(defines.events.on_chunk_generated, function(event)
  PhaseCycler:OnChunkGenerated(event)
end)



-- called every time an entity die
script.on_event(defines.events.on_entity_died, function(event)
  Boss:OnEntityDied(event)
  DespawnPenalty:OnEntityDied(event.entity)
end)



-- called every time a player died
script.on_event(defines.events.on_pre_player_died, function(event)
  -- check for corpse flare
  CorpseFlare:OnPrePlayerDied(event.player_index)
end)



-- called every time a player died
script.on_event(defines.events.on_player_died, function(event)
  -- Create deathscream
  Deathscream:CreateScream(event.player_index)
  -- Update the deathcounter
  DeathUI:AddDeath(event.player_index)
end)



-- called every time someone clicks on a gui
script.on_event(defines.events.on_gui_click, function(event)
  DeathUI:OnClick(event)
end)
