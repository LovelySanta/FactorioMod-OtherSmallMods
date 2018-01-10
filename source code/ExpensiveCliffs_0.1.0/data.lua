data.raw.technology["cliff-explosives"].prerequisites =
  {
    "circuit-network",
    "fluid-handling",
    "automation-3",
    "atomic-bomb",
  }
data.raw.technology["cliff-explosives"].unit =
  {
    count = 250,
    ingredients =
    {
      {"science-pack-1", 2},
      {"science-pack-2", 2},
      {"science-pack-3", 1},
      {"military-science-pack", 2},
      {"production-science-pack", 1},
      {"high-tech-science-pack", 1}
    },
    time = 60,
  }


data.raw.recipe["cliff-explosives"].energy_required = 60
data.raw.recipe["cliff-explosives"].ingredients =
  {
    {"sulfuric-acid-barrel", 1},
    {"explosives", 500},
    {"iron-stick", 1},
    {"red-wire", 100},
    {"atomic-bomb", 1},
  }
