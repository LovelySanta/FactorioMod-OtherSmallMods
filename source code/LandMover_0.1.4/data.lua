data.raw.technology["landfill"] = nil -- Disable research for landfill
data.raw.recipe["landfill"].enabled = false -- Disable landfill recipe

data:extend({
  {
    type = "item",
    name = "landmover-shovel",
    icon = "__LandMover__/graphics/shovel.png",
    icon_size = 32,
    flags = {"goes-to-main-inventory"},
    subgroup = "tool",
    order = "a[mining]-c[shovel]",
    stack_size = 20
  },

  {
    type = "item",
    name = "landmover",
    icon = "__LandMover__/graphics/landmover_ent.png",
    icon_size = 64,
    flags = {"goes-to-main-inventory"},
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]",
    stack_size = 100,
    place_as_tile =
    {
      result = "water",
      condition_size = 1,
      condition = { "water-tile" }
    }
  },

  {
    type = "recipe",
    name = "landmover-shovel",
    enabled = false,
    ingredients =
    {
    {type="item", name="iron-stick", amount=5},
    {type="item", name="steel-plate", amount=3},
    },
    energy_required = 5,
    result= "landmover-shovel",
    result_count = 1
  },

  {
    type = "recipe",
    name = "landmover",
    energy_required = 10,
    enabled = false,
    category = "crafting-with-fluid",
    ingredients =
    {
    {type="item", name="landmover-shovel", amount=1},
    {type="item", name="steel-plate", amount=5},
    {type="item", name="concrete", amount=20},
    },
    energy_required = 10,
    result= "landmover",
    result_count = 100
  },

  {
    type = "technology",
    name = "landmover",
    prerequisites = {"concrete"},
    icon = "__LandMover__/graphics/landmover_tech.png",
    icon_size = 128,
    unit =
    {
      count = 50,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
      },
      time = 25
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "landmover-shovel"
      },
      {
        type = "unlock-recipe",
        recipe = "landmover"
      }
    },
    order = "b-d"
  }
})
