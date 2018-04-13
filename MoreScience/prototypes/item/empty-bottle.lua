
data:extend({
  {
    type = "item",
    name = "sand",
    icon = "__base__/graphics/icons/steel-plate.png", --placeholder
    icon_size = 32,
    flags = {"goes-to-main-inventory"},
    subgroup = "raw-material",
    order = "e[sand]",
    stack_size = 100
  },

  {
    type = "item",
    name = "glass",
    icon = "__base__/graphics/icons/steel-plate.png", --placeholder
    icon_size = 32,
    flags = {"goes-to-main-inventory"},
    subgroup = "raw-material",
    order = "e[glass]",
    stack_size = 50
  },

  {
    type = "item",
    name = "cork",
    icon = "__MoreScience__/graphics/cork.png",
    icon_size = 128,
    flags = {"goes-to-main-inventory"},
    subgroup = "raw-material",
    order = "e[cork]",
    stack_size = 50
  },

  {
    type = "item",
    name = "empty-bottle",
    icon = "__MoreScience__/graphics/potions/potion-00.png",
    icon_size = 32,
    flags = {"goes-to-main-inventory"},
    subgroup = "science-pack",
    order = "z-MoreScience-a[empty-bottle]",
    stack_size = 50,
  },
})
