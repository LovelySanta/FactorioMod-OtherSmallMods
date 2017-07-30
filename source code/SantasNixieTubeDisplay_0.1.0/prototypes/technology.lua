data:extend({
  {
    type = "technology",
    name = "SNTD-nixie-tubes",
    icon = "__SantasNixieTubeDisplay__/graphics/nixie-technology-icon.png",
    icon_size = 32,
    unit = {
      count=20,
      time=10,
      ingredients = {
        {"science-pack-1", 1},
        {"science-pack-2", 1}
      }
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
