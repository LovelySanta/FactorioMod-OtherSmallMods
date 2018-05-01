
data:extend({
  {
    type = "recipe",
    name = "purified-water",
    subgroup = "science-raw-material",
    category = "chemistry",
    icon = "__MoreScience__/graphics/fluids/fluid-00.png",
    icon_size = 32,
    energy_required = 5,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="water", amount=20},
    },
    results =
    {
      {type="fluid", name="purified-water", amount = 10},
      {type="item", name="sand", amount = 1, probability = .5},
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
    name = "basic-science-fluid-1",
    subgroup = "science-fluid",
    category = "crafting-with-fluid",
    energy_required = 10,
    ingredients =
    {
      {"science-pack-1", 10},
      {"iron-axe", 1},
    },
    results =
    {
      {type="fluid", name= "basic-science-fluid-1", amount = 100},
    },
    enabled = false,
  },



  {
    type = "recipe",
    name = "basic-science-fluid-2",
    subgroup = "science-fluid",
    category = "chemistry",
    energy_required = 5,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="basic-science-fluid-1", amount=100},
      {type="fluid", name="purified-water", amount=50},
      {type="item", name="fast-inserter", amount=5},
    },
    results =
    {
      {type="fluid", name= "basic-science-fluid-2", amount = 50},
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
    name = "basic-science-fluid-3",
    subgroup = "science-fluid",
    category = "chemistry",
    energy_required = 5,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="basic-science-fluid-2", amount=100},
      {type="fluid", name="purified-water", amount=50},
      {type="item", name="advanced-circuit", amount=10},
    },
    results =
    {
      {type="fluid", name= "basic-science-fluid-3", amount = 50},
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
    name = "advanced-science-fluid-1",
    subgroup = "science-fluid",
    category = "chemistry",
    energy_required = 40,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="basic-science-fluid-3", amount=100},
      {type="fluid", name="purified-water", amount=50},
      {type="item", name="electric-furnace", amount=5},
    },
    results =
    {
      {type="fluid", name= "advanced-science-fluid-1", amount = 50},
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
    name = "advanced-science-fluid-2",
    subgroup = "science-fluid",
    category = "chemistry",
    energy_required = 40,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="basic-science-fluid-3", amount=100},
      {type="fluid", name="purified-water", amount=50},
      {type="item", name="processing-unit", amount=15},
    },
    results =
    {
      {type="fluid", name= "advanced-science-fluid-2", amount = 50},
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
    name = "basic-military-science-fluid",
    subgroup = "science-fluid",
    category = "chemistry",
    energy_required = 10,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="basic-science-fluid-2", amount=100},
      {type="fluid", name="purified-water", amount=50},
      {type="item", name="gun-turret", amount=5},
      {type="item", name="piercing-rounds-magazine", amount=10},
    },
    results =
    {
      {type="fluid", name= "basic-military-science-fluid", amount = 50},
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
    name = "basic-automation-science-fluid",
    subgroup = "science-fluid",
    category = "chemistry",
    energy_required = 10,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="basic-science-fluid-2", amount=100},
      {type="fluid", name="purified-water", amount=50},
      {type="item", name="assembling-machine-2", amount=10},
    },
    results =
    {
      {type="fluid", name= "basic-automation-science-fluid", amount = 50},
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
    name = "basic-power-science-fluid",
    subgroup = "science-fluid",
    category = "chemistry",
    energy_required = 10,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="basic-automation-science-fluid", amount=100},
      {type="fluid", name="purified-water", amount=50},
      {type="item", name="battery", amount=25},
    },
    results =
    {
      {type="fluid", name= "basic-power-science-fluid", amount = 50},
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
    name = "basic-logistics-science-fluid",
    subgroup = "science-fluid",
    category = "chemistry",
    energy_required = 20,
    enabled = false,
    ingredients =
    {
      {type="fluid", name="basic-power-science-fluid", amount=100},
      {type="fluid", name="purified-water", amount=50},
      {type="item", name="electric-engine-unit", amount=5},
    },
    results =
    {
      {type="fluid", name= "basic-logistics-science-fluid", amount = 50},
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
    name = "extreme-science-fluid",
    subgroup = "science-fluid",
    category = "crafting-with-fluid",
    energy_required = 10,
    ingredients =
    {
      {"space-science-pack", 10},
      {"steel-axe", 1},
    },
    results =
    {
      {type="fluid", name= "extreme-science-fluid", amount = 100},
    },
    enabled = false,
  },
})
