--------------------------------------------------------------------------------
----- Regular science packs                                                -----
--------------------------------------------------------------------------------

-- basic science pack 1
data.raw["recipe"]["science-pack-1"].ingredients =
{
  {"copper-plate", 2},
  {"iron-gear-wheel", 1},
  --{type="fluid", name="lubricant", amount=40},
}
data.raw["recipe"]["science-pack-1"].energy_required = 1



-- basic science pack 2
data.raw["recipe"]["science-pack-2"].category = "crafting-with-fluid"
data.raw["recipe"]["science-pack-2"].ingredients =
{
  {"empty-bottle", 1},
  {type="fluid", name="basic-science-fluid-2", amount=10},
}
data.raw["recipe"]["science-pack-2"].energy_required = 2



-- basic science pack 3
data.raw["recipe"]["science-pack-3"].category = "crafting-with-fluid"
data.raw["recipe"]["science-pack-3"].ingredients =
{
  {"empty-bottle", 1},
  {type="fluid", name="basic-science-fluid-3", amount=10},
}
data.raw["recipe"]["science-pack-3"].energy_required = 5



-- basic science pack 3
data.raw["recipe"]["military-science-pack"].category = "crafting-with-fluid"
data.raw["recipe"]["military-science-pack"].ingredients =
{
  {"empty-bottle", 1},
  {type="fluid", name="basic-military-science-fluid", amount=10},
}
data.raw["recipe"]["military-science-pack"].result_count = 1
data.raw["recipe"]["military-science-pack"].energy_required = 5



-- advanced science pack 1
data.raw["recipe"]["production-science-pack"].category = "crafting-with-fluid"
data.raw["recipe"]["production-science-pack"].ingredients =
{
  {"empty-bottle", 1},
  {type="fluid", name="advanced-science-fluid-1", amount=10},
}
data.raw["recipe"]["production-science-pack"].result_count = 1
data.raw["recipe"]["production-science-pack"].energy_required = 5



-- advanced science pack 2
data.raw["recipe"]["high-tech-science-pack"].category = "crafting-with-fluid"
data.raw["recipe"]["high-tech-science-pack"].ingredients =
{
  {"empty-bottle", 1},
  {type="fluid", name="advanced-science-fluid-2", amount=10},
}
data.raw["recipe"]["high-tech-science-pack"].result_count = 1
data.raw["recipe"]["high-tech-science-pack"].energy_required = 5



-- basic automation science pack
data:extend({
  {
    type = "recipe",
    name = "basic-automation-science-pack",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {"empty-bottle", 1},
      {type="fluid", name="basic-automation-science-fluid", amount=10},
    },
    result = "basic-automation-science-pack",
    enabled = false
  },
})



-- basic power science pack
data:extend({
  {
    type = "recipe",
    name = "basic-power-science-pack",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {"empty-bottle", 1},
      {type="fluid", name="basic-power-science-fluid", amount=10},
    },
    result = "basic-power-science-pack",
    enabled = false
  },
})



-- basic logistics science pack
data:extend({
  {
    type = "recipe",
    name = "basic-logistics-science-pack",
    category = "crafting-with-fluid",
    energy_required = 5,
    ingredients =
    {
      {"empty-bottle", 1},
      {type="fluid", name="basic-logistics-science-fluid", amount=10},
    },
    result = "basic-logistics-science-pack",
    enabled = false
  },
})
