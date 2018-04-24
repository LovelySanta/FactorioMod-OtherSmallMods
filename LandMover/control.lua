script.on_configuration_changed(function(data)
  -- Check if this mod has changed
  for modName, modData in pairs(data.mod_changes) do
    if modName == "LandMover" then

      -- Mod has beed added/changed make sure recipes are unlocked if it was researched
      for _, force in pairs(game.forces) do
        if force.technologies['landfill'] and force.technologies['landfill'].researched then
          force.reset_technology_effects()
        end
      end

      -- No need to look further, we found our mod already
      break
    end
  end
end)

script.on_event(defines.events.on_player_built_tile, function(event)
  -- Check if the player used land mover
  if event.item.name == "landmover" then
    -- Give the player same amount of landfill als he used landmover
    game.players[event.player_index].insert{name="landfill", count=#event.tiles}
  end
end)
