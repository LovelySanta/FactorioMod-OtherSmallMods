data:extend({
  {
    type = "item",
    name = "corpse-flare",
    icon = "__BugZilla__/graphics/entity/corpse-flare.png",
    icon_size = 200,
    flags = {"goes-to-main-inventory"},
    subgroup = "tool",
    order = "z[mining]-z[shovel]",
    stack_size = 1
  },

  {
    type = "recipe",
    name = "corpse-flare",
    enabled = false,
    ingredients =
    {
      {type="item", name="electronic-circuit", amount=5},
      {type="item", name="small-lamp", amount=5},
      {type="item", name="grenade", amount=1}
    },
    energy_required = 5,
    result= "corpse-flare",
    result_count = 1
  },

  {
    type = "technology",
    name = "corpse-flare",
    prerequisites = {"military-2"},
    icon = "__BugZilla__/graphics/entity/corpse-flare.png",
    icon_size = 200,
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"military-science-pack", 1},
      },
      time = 20
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "corpse-flare"
      }
    },
    order = "b-d"
  }
})
