require 'lib/corpse-flare'

-- on load game for first time
script.on_init(function(_)
  CorpseFlare:Init()
end)

-- called every time a player died
script.on_event(defines.events.on_pre_player_died, function(event)
  -- check for corpse flare
  CorpseFlare:OnPrePlayerDied(event.player_index)
end)
