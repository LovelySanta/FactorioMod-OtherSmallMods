script.on_event(defines.events.on_player_built_tile, function(event)
	local surface = game.surfaces[event.surface_index +1]  -- "- Fixed surface_index was off by 1 for on_player_built_tile and on_player_mined_tile events." 0.16 changelog
	local pos = event.positions
	local player = game.players[event.player_index]
	
	-- Get amount of water tiles placed
	local amount = #pos
	local tile = surface.get_tile(pos[1].x,pos[1].y)
	if (tile.valid and tile.name=="water") then
		-- Give player same amount of landfill
		player.insert{name="landfill", count=amount}
	end
end)