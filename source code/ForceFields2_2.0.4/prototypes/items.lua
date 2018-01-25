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
      name = "forcefield-emitter",
      icon = "__ForceFields2__/graphics/forcefield-emitter-icon.png",
      icon_size = 32,
      flags = {"goes-to-quickbar"},
      subgroup = "forcefields",
      order = "f[forcefield-emitter]",
      place_result = "forcefield-emitter",
      stack_size = 50
    }
  }
)
