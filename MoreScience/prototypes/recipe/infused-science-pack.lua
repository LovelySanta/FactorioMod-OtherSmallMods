--------------------------------------------------------------------------------
----- Infused science packs                                                -----
--------------------------------------------------------------------------------

data:extend({
  {
    type = "recipe",
    name = "infused-basic-science-pack-1",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="extreme-science-fluid", amount=10},
      {"science-pack-1", 2},
    },
    result = "infused-basic-science-pack-1",
    enabled = false
  },



  {
    type = "recipe",
    name = "infused-basic-science-pack-2",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="extreme-science-fluid", amount=10},
      {"science-pack-2", 2},
    },
    result = "infused-basic-science-pack-2",
    enabled = false
  },



  {
    type = "recipe",
    name = "infused-basic-science-pack-3",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="extreme-science-fluid", amount=10},
      {"science-pack-3", 2},
    },
    result = "infused-basic-science-pack-3",
    enabled = false
  },



  {
    type = "recipe",
    name = "infused-advanced-science-pack-1",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="extreme-science-fluid", amount=10},
      {"production-science-pack", 2},
    },
    result = "infused-advanced-science-pack-1",
    enabled = false
  },



  {
    type = "recipe",
    name = "infused-advanced-science-pack-2",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="extreme-science-fluid", amount=10},
      {"high-tech-science-pack", 2},
    },
    result = "infused-advanced-science-pack-2",
    enabled = false
  },



  {
    type = "recipe",
    name = "infused-extreme-science-pack",
    subgroup = "infused-science-pack",
    category = "chemistry",
    energy_required = 5,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="advanced-science-fluid-1", amount=10},
      {type="fluid", name="advanced-science-fluid-2", amount=10},
      {type="item", name="space-science-pack", amount=2},
    },
    results =
    {
      {type="item", name= "infused-extreme-science-pack", amount = 1},
    },
    crafting_machine_tint =
    {
      primary = {r = 0.331, g = 0.075, b = 0.510, a = 0.000}, -- #54138200
      secondary = {r = 0.589, g = 0.540, b = 0.615, a = 0.361}, -- #96899c5c
      tertiary = {r = 0.469, g = 0.145, b = 0.695, a = 0.000}, -- #7724b100
    },
  },



  {
    type = "recipe",
    name = "infused-basic-military-science-pack",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="extreme-science-fluid", amount=10},
      {"military-science-pack", 2},
    },
    result = "infused-basic-military-science-pack",
    enabled = false
  },



  {
    type = "recipe",
    name = "infused-basic-automation-science-pack",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="extreme-science-fluid", amount=10},
      {"basic-automation-science-pack", 2},
    },
    result = "infused-basic-automation-science-pack",
    enabled = false
  },



  {
    type = "recipe",
    name = "infused-basic-power-science-pack",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="extreme-science-fluid", amount=10},
      {"basic-power-science-pack", 2},
    },
    result = "infused-basic-power-science-pack",
    enabled = false
  },



  {
    type = "recipe",
    name = "infused-basic-logistics-science-pack",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="extreme-science-fluid", amount=10},
      {"basic-logistics-science-pack", 2},
    },
    result = "infused-basic-logistics-science-pack",
    enabled = false
  },



})
