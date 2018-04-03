
-- on load game for first time
script.on_init(function(_)
  if settings.startup["EC-fixed-cliffs"].value then
    -- Set fixed cliff settings if enabled
    local map_gen_settings = game.surfaces["nauvis"].map_gen_settings
    local cliff_settings = map_gen_settings.cliff_settings

    -- Frequency
    -- Default 10, doubles each time for a lower setting
    cliff_settings.cliff_elevation_interval = 5.0001144409179688 -- high

    -- Size
    -- Default 10, doubles each time for a lower setting
    cliff_settings.cliff_elevation_0 = 2.5000572204589844 -- very big

    map_gen_settings.cliff_settings = cliff_settings
    game.surfaces["nauvis"].map_gen_settings = map_gen_settings
  end

end)
