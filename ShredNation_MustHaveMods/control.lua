local fart_name = {
  ["SN-sfx-1"] = "fart1.ogg",
  ["SN-sfx-2"] = "fart2.ogg",
  ["SN-sfx-3"] = "fart3.ogg",
  ["SN-sfx-4"] = "fart4.ogg",
  ["SN-sfx-5"] = nil,
  ["SN-sfx-6"] = nil,
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
  if sfx and player and settings.get_player_settings(player)["SN-sfx-enabled"].value then
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
