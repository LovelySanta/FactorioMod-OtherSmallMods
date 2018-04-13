
-- basic science pack 1
data.raw["recipe"]["science-pack-1"].ingredients =
{
  {"copper-plate", 2},
  {"iron-gear-wheel", 2},
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
