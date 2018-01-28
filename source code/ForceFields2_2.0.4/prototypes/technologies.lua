require 'src/settings'
require 'prototypes/defines/forcefield-tech-effect'



data:extend(
  {
    {
      type = "technology",
      name = "force-fields",
      icon = Settings.modName .. "/graphics/walls/blue/wall-technology.png",
      icon_size = 128,
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
        },
        createTechWallEffect("blue")
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
      icon = Settings.modName .. "/graphics/walls/green/wall-technology.png",
      icon_size = 128,
      prerequisites =
      {
        "force-fields",
        "laser",
      },
      effects =
      {
        createTechWallEffect("green")
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
      icon = Settings.modName .. "/graphics/walls/purple/wall-technology.png",
      icon_size = 128,
      prerequisites =
      {
        "green-fields",
        "military-3"
      },
      effects =
      {
        createTechWallEffect("purple")
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
      icon = Settings.modName .. "/graphics/walls/red/wall-technology.png",
      icon_size = 128,
      prerequisites =
      {
        "purple-fields",
        "military-4"
      },
      effects =
      {
        createTechWallEffect("red")
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
