data.raw.technology["landfill"] = nil -- Disable research for landfill
data.raw.recipe["landfill"].enabled = false -- Disable landfill

data:extend({
{
    type = "item",
    name = "landmover",
    icon = "__LandMover__/water.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]",
    stack_size = 200,
    place_as_tile =
    {
      result = "water",
      condition_size = 1,
      condition = { "water-tile" }
    }
  },
    {
    type = "recipe",
    name = "landmover",
    energy_required = 1,
    enabled = false,
    category = "crafting-with-fluid",
    ingredients =
    {
      {type="fluid", name="water", amount=200}
    },
    result= "landmover",
    result_count = 1
  },
   {
    type = "technology",
    name = "landmover",
    icon = "__LandMover__/water.png",
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
        recipe = "landmover"
      }
    },
    order = "b-d"
  }
  })
  