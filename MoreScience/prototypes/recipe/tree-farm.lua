
--------------------------------------------------------------------------------
----- seed-extractor                                                       -----
--------------------------------------------------------------------------------
local seedExtractor =
{
  type = "recipe",
  name = "seed-extractor",
  energy_required = data.raw["assembling-machine"]["chemical-plant"].energy_required,
  enabled = false,
  ingredients =
  {
    {"chemical-plant", 1},
    {"iron-axe", data.raw["mining-tool"]["iron-axe"].stack_size / 2},
    {"raw-wood", data.raw["item"]["raw-wood"].stack_size / 2},
  },
  result = "seed-extractor",
}



--------------------------------------------------------------------------------
----- wood-plantation                                                      -----
--------------------------------------------------------------------------------
local woodPlantation  =
{
  type = "recipe",
  name = "wood-plantation",
  energy_required = seedExtractor.energy_required,
  enabled = false,
  ingredients = {
    {"assembling-machine-3", 1},
    {"sand", data.raw["item"]["sand"].stack_size},
    {"raw-wood", data.raw["item"]["raw-wood"].stack_size},
    {"steel-axe", data.raw["mining-tool"]["steel-axe"].stack_size},
  },
  result = "wood-plantation",
}



--------------------------------------------------------------------------------
----- tree                                                                 -----
--------------------------------------------------------------------------------
local organicTree =
{
  type = "recipe",
  name = "organic-tree",
  energy_required = 60 * 5,
  enabled = false,
  category = "wood-plantation",
  ingredients =
  {
    {"tree-seed", 1},
  },
  result = "organic-tree",
}



--------------------------------------------------------------------------------
----- tree-seed                                                            -----
--------------------------------------------------------------------------------
local treeSeed =
{
  type = "recipe",
  name = "tree-seed",
  localised_name = util.table.deepcopy(data.raw["item"]["tree-seed"].localised_name),
  energy_required = 60,
  enabled = false,
  category = "seed-extractor",
  ingredients = {
    {organicTree.result, 1},
  },
  result = "tree-seed",
  result_count = 5,
}


local treeSeedCreator =
{
  type = "recipe",
  name = treeSeed.name .. "-creator",
  localised_name = util.table.deepcopy(data.raw["item"][treeSeed.name].localised_name),
  icon = data.raw["item"][treeSeed.name].icon,
  icon_size = data.raw["item"][treeSeed.name].icon_size,
  subgroup = data.raw["item"][treeSeed.name].subgroup,
  energy_required = treeSeed.energy_required / 2,
  enabled = treeSeed.enabled,
  category = treeSeed.category,
  ingredients = {
    {"raw-wood", 100},
    {"sand", 10},
  },
  results =
  {
    {type="item", name="sand", amount = 5},
    {type="item", name=treeSeed.result, amount = 1, probability = .001},
  },
}



data:extend({
  seedExtractor,
  woodPlantation,

  organicTree,
  treeSeed,
  treeSeedCreator,
})
