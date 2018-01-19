data:extend(
  {
    {
      type = "technology",
      name = "force-fields",
      icon = "__ForceFields2__/graphics/blue-forcefields.png",
      icon_size = 64,
      prerequisites =
      {
        "optics",
        "stone-walls",
        "military-2",
        "advanced-electronics",
        "battery",
      },
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "forcefield-emitter"
        }
      },
      unit =
      {
        count = 300,
        ingredients =
        {
          {"science-pack-1", 1},
          {"science-pack-2", 1},
        },
        time = 35,

      },
      order = "f-f-e"
    },

    {
      type = "technology",
      name = "green-fields",
      icon = "__ForceFields2__/graphics/green-forcefields.png",
      icon_size = 64,
      prerequisites =
      {
        "force-fields",
        "laser",
      },
      unit =
      {
        count = 150,
        ingredients =
        {
          {"science-pack-1", 1},
          {"science-pack-2", 1},
          {"military-science-pack", 1}
        },
        time = 30,
      },
      order = "f-f-e"
    },

    {
      type = "technology",
      name = "purple-fields",
      icon = "__ForceFields2__/graphics/purple-forcefields.png",
      icon_size = 64,
      prerequisites =
      {
        "green-fields",
        "military-3"
      },
      unit =
      {
        count = 200,
        ingredients =
        {
          {"science-pack-1", 1},
          {"science-pack-2", 1},
          {"science-pack-3", 1},
          {"military-science-pack", 1}
        },
        time = 30,
      },
      upgrade = true,
      order = "f-f-e"
    },

    {
      type = "technology",
      name = "red-fields",
      icon = "__ForceFields2__/graphics/red-forcefields.png",
      icon_size = 64,
      prerequisites =
      {
        "purple-fields",
        "military-4"
      },
      unit =
      {
        count = 200,
        ingredients =
        {
          {"science-pack-1", 1},
          {"science-pack-2", 1},
          {"science-pack-3", 1},
          {"military-science-pack", 1},
          {"high-tech-science-pack", 1}
        },
        time = 30,
      },
      upgrade = true,
      order = "f-f-e"
    }
  }
)
