require 'src/settings'



data:extend(
  {
    {
      type = "technology",
      name = "force-fields",
      icon = Settings.modName .. "/graphics/blue-forcefields.png",
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
          recipe = Settings.emitterName
        }
      },
      unit =
      {
        count = 500,
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
      icon = Settings.modName .. "/graphics/green-forcefields.png",
      icon_size = 64,
      prerequisites =
      {
        "force-fields",
        "laser",
      },
      unit =
      {
        count = 1000,
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
      icon = Settings.modName .. "/graphics/purple-forcefields.png",
      icon_size = 64,
      prerequisites =
      {
        "green-fields",
        "military-3"
      },
      unit =
      {
        count = 2000,
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
      icon = Settings.modName .. "/graphics/red-forcefields.png",
      icon_size = 64,
      prerequisites =
      {
        "purple-fields",
        "military-4"
      },
      unit =
      {
        count = 4500,
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
