require 'util'

local woodPlantation = util.table.deepcopy(data.raw["technology"]["automation-3"])
woodPlantation.name = "wood-plantation"
woodPlantation.icon = "__MoreScience__/graphics/technology/wood-plantation-tech.png"
woodPlantation.icon_size = 128
woodPlantation.prerequisites =
{
  "automation-3",
  "landfill",
}
woodPlantation.effects =
{
  {
    type = "unlock-recipe",
    recipe = "hand-saw",
  },
  {
    type = "unlock-recipe",
    recipe = "seed-extractor",
  },
  {
    type = "unlock-recipe",
    recipe = "tree-seed-creator",
  },
  {
    type = "unlock-recipe",
    recipe = "tree-seed",
  },
  {
    type = "unlock-recipe",
    recipe = "wood-plantation",
  },
  {
    type = "unlock-recipe",
    recipe = "organic-tree",
  },
  {
    type = "unlock-recipe",
    recipe = "raw-wood-creator",
  }
}
woodPlantation.unit.count = woodPlantation.unit.count * 2

data:extend({
  woodPlantation,
})
