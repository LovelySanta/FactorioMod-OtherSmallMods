data:extend(
  {
    {
      type = "technology",
      name = "force-fields",
      icon = "__Force Fields__/graphics/forcefields.png",
      prerequisites = {"alien-technology", "battery", "advanced-electronics", "optics"},
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "forcefield-emitter"
        },
        {
          type = "unlock-recipe",
          recipe = "forcefield-tool"
        }
      },
      unit =
      {
        count = 300,
        ingredients =
        {
          {"science-pack-1", 1},
          {"science-pack-2", 1}
        },
        time = 35,
        
      },
      order = "f-f-e"
    },
    {
      type = "technology",
      name = "green-fields",
      icon = "__Force Fields__/graphics/green-forcefields.png",
      prerequisites = {"force-fields"},
      unit =
      {
        count = 150,
        ingredients =
        {
          {"science-pack-1", 1},
          {"science-pack-2", 1}
        },
        time = 30,
      },
      order = "f-f-e"
    },
    {
      type = "technology",
      name = "purple-fields",
      icon = "__Force Fields__/graphics/purple-forcefields.png",
      prerequisites = {"green-fields"},
      unit =
      {
        count = 200,
        ingredients =
        {
          {"science-pack-1", 1},
          {"science-pack-2", 1}
        },
        time = 30,
      },
      upgrade = true,
      order = "f-f-e"
    },
    {
      type = "technology",
      name = "red-fields",
      icon = "__Force Fields__/graphics/red-forcefields.png",
      prerequisites = {"purple-fields"},
      unit =
      {
        count = 200,
        ingredients =
        {
          {"science-pack-1", 1},
          {"science-pack-2", 1},
          {"science-pack-3", 1}
        },
        time = 30,
      },
      upgrade = true,
      order = "f-f-e"
    }
  }
)