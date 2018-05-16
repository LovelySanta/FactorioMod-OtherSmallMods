require 'util'

data:extend({
  {
    type = "technology",
    name = "SNTD-nixie-tubes",
    icon = "__SantasNixieTubeDisplay__/graphics/nixie-technology-icon.png",
    icon_size = 32,
    unit = {
      count = 2 * util.table.deepcopy(data.raw["technology"]["circuit-network"].unit.count),
      time = util.table.deepcopy(data.raw["technology"]["circuit-network"].unit.time),
      ingredients = util.table.deepcopy(data.raw["technology"]["circuit-network"].unit.ingredients),
    },
    prerequisites = {
      "circuit-network"
    },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "SNTD-nixie-tube"
      },
      {
        type = "unlock-recipe",
        recipe = "SNTD-nixie-tube-small"
      }
    },
    order = "a-d-e"
  }
})
