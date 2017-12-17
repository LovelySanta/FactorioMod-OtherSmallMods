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
      icon = "__Force Fields__/graphics/forcefield-emitter-icon.png",
      flags = {"goes-to-quickbar"},
      subgroup = "forcefields",
      order = "f[forcefield-emitter]",
      place_result = "forcefield-emitter",
      stack_size = 50
    },
    {
      type = "item",
      name = "forcefield-tool",
      icon = "__Force Fields__/graphics/config-tool.png",
      flags = {"goes-to-quickbar"},
      subgroup = "forcefields",
      order = "f[forcefield-tool]",
      place_result = "forcefield-tool",
      stack_size = 2
    }
  }
)