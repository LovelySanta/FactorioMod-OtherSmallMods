local fart_name = {
  ["SN-sfx-1"] = "fart1.ogg",
  ["SN-sfx-2"] = "fart2.ogg",
  ["SN-sfx-3"] = "fart3.ogg",
  ["SN-sfx-4"] = "fart4.ogg",
  ["SN-sfx-5"] = "fart5.ogg",
  ["SN-sfx-6"] = "fart6.ogg",
  ["SN-sfx-7"] = nil,
  ["SN-sfx-8"] = nil,
  ["SN-sfx-9"] = nil,
  ["SN-sfx-0"] = nil,

  ["SN-sfx-fart-key"] = "random"
}

local on_fart_key_pressed = function(event)
  local sfx = fart_name[event.input_name]
  if sfx == "random" then
    sfx = fart_name["SN-sfx-"..global.generator(10-.000000001)]
  end
  local player = game.players[event.player_index]
  local can_play_sfx = function(player_index)
    if not global.sfx_cooldown then global.sfx_cooldown = {} end
    if not global.sfx_cooldown[player_index] then global.sfx_cooldown[player_index] = 0 end

    if global.sfx_cooldown[player_index] + 60*30 >= game.tick then
      if fart_name[event.input_name] ~= "random" then
        game.players[player_index].print{"messages.sfx-cooldown"}
      end
      return false
    else
      global.sfx_cooldown[player_index] = game.tick
      return true
    end
  end

  if sfx and player and settings.get_player_settings(player)["SN-sfx-enabled"].value and can_play_sfx(event.player_index) then
    player.surface.play_sound{
      path     = sfx,
      position = player.position
    }
  end
end

for _,nbr in pairs{
  "1","2","3","4","5","6","7","8","9","0","fart-key"
} do
  script.on_event("SN-sfx-"..nbr, on_fart_key_pressed)
end

script.on_init(function()
  global.generator = game.create_random_generator()
end)
