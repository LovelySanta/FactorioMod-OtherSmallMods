
require 'lib/utilities/math'
require 'lib/bugzilla/phase-cycler'
require 'lib/bugzilla/boss'



script.on_init(function(_)
  Math:Init()
  PhaseCycler:Init()
  Boss:Init()
end)



script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
  PhaseCycler:OnSettingsChanged(event)
end)



script.on_event(defines.events.on_tick, function(event)
  if game.tick % 60 == 0 then -- each second
    PhaseCycler:OnSecond()
    Boss:OnSecond()
  end
end)



script.on_event(defines.events.on_chunk_generated, function(event)
  PhaseCycler:OnChunkGenerated(event)
end)



script.on_event(defines.events.on_entity_died, function(event)
  Boss:OnEntityDied(event)
end)
