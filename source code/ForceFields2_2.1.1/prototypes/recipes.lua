require 'src/settings'



data:extend(
  {
    {
      type = "recipe",
      name = Settings.emitterName,
      enabled = "false",
      energy_required = 5,
      ingredients =
      {
        {"steel-plate", 50},
        {"battery", 200},
        {"advanced-circuit", 20},
        {"small-lamp", 4}
      },
      result = Settings.emitterName
    }
  }
)
