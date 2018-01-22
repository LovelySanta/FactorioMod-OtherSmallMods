script.on_event(defines.events.on_player_built_tile, function(event)
  -- Check if the player used land mover
  if event.item.name == "landmover" then
    -- Give the player same amount of landfill als he used landmover
    game.players[event.player_index].insert{name="landfill", count=#event.tiles}
  end
end)
