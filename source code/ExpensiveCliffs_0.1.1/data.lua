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
    {"red-wire", 50},
	{"green-wire", 50},
    {"atomic-bomb", 1},
  }


data.raw.projectile["cliff-explosives"].action =
  {
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "ground-explosion"
          },
          {
            type = "destroy-cliffs",
            radius = 1.5,
            explosion = "explosion"
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          }
        }
      }
    },
    {
      type = "area",
      radius = 5,
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
          type = "damage",
          damage = {amount = 35, type = "explosion"}
          },
          {
          type = "create-entity",
          entity_name = "explosion"
          }
        }
      }
    }
  }
