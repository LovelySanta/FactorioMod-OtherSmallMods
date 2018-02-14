require 'src/settings'

data:extend(
  {
    {
      type = "item-subgroup",
      name = "forcefields",
      group = "combat",
      order = "z"
    },

    {
      type = "item",
      name = Settings.emitterName,
      icon = Settings.modName .. "/graphics/forcefield-emitter-icon.png",
      icon_size = 32,
      flags = {"goes-to-quickbar"},
      subgroup = "forcefields",
      order = "f[forcefield-emitter]",
      place_result = Settings.emitterName,
      stack_size = 50
    }
  }
)
