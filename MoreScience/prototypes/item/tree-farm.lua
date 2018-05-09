require 'util'
local treefarmSubgroup = "treefarm"

--------------------------------------------------------------------------------
----- hand-saw                                                             -----
--------------------------------------------------------------------------------
local handSaw =
{
  type = "item",
  name = "hand-saw",
  icon = "__MoreScience__/graphics/icons/hand-saw.png",
  icon_size = 512,
  flags = {"goes-to-main-inventory"},
  subgroup = "tool",
  order = "a[mining]-c[hand-saw]",
  stack_size = 20
}



--------------------------------------------------------------------------------
----- seed-extractor                                                       -----
--------------------------------------------------------------------------------
local seedExtractor = util.table.deepcopy(data.raw["item"]["pumpjack"])
seedExtractor.name = "seed-extractor"
seedExtractor.icon = "__MoreScience__/graphics/icons/" .. seedExtractor.name .. ".png"
seedExtractor.icon_size = 32
seedExtractor.place_result = seedExtractor.name
seedExtractor.order = "c[wood]-c[" .. seedExtractor.name .. "]"
seedExtractor.stack_size = data.raw["item"]["assembling-machine-1"].stack_size
--seedExtractor.subgroup = treefarmSubgroup



--------------------------------------------------------------------------------
----- wood-plantation                                                      -----
--------------------------------------------------------------------------------
local woodPlantation = util.table.deepcopy(data.raw["item"]["pumpjack"])
woodPlantation.name = "wood-plantation"
woodPlantation.icon = "__MoreScience__/graphics/icons/" .. woodPlantation.name .. ".png"
woodPlantation.icon_size = 32
woodPlantation.place_result = woodPlantation.name
woodPlantation.order = "c[wood]-d[" .. woodPlantation.name .. "]"
woodPlantation.stack_size = data.raw["item"]["assembling-machine-1"].stack_size
--woodPlantation.subgroup = treefarmSubgroup



--------------------------------------------------------------------------------
----- tree                                                                 -----
--------------------------------------------------------------------------------
local tree = util.table.deepcopy(data.raw["item"]["pumpjack"])
tree.name = "organic-tree"
tree.icon = data.raw["tree"]["tree-09"].icon
tree.icon_size = data.raw["tree"]["tree-09"].icon_size
tree.place_result = nil
tree.order = "c[wood]-f[" .. tree.name .. "]"
tree.stack_size = 1
tree.subgroup = treefarmSubgroup



--------------------------------------------------------------------------------
----- tree-seed                                                            -----
--------------------------------------------------------------------------------
local treeSeed = util.table.deepcopy(data.raw["item"]["pumpjack"])
treeSeed.name = "tree-seed"
treeSeed.localised_name = {"item-name." .. treeSeed.name, {[1] = "item-name." .. tree.name}}
treeSeed.icon = "__MoreScience__/graphics/icons/" .. treeSeed.name .. ".png"
treeSeed.icon_size = 248
treeSeed.place_result = nil
treeSeed.order = "c[wood]-e[" .. treeSeed.name .. "]"
treeSeed.stack_size = 10
treeSeed.subgroup = treefarmSubgroup



--------------------------------------------------------------------------------
----- raw-wood                                                             -----
--------------------------------------------------------------------------------
data.raw["item"]["raw-wood"].subgroup = treefarmSubgroup
data.raw["item"]["raw-wood"].order = "c[wood]-g[raw-wood]"


data:extend({
  handSaw,

  seedExtractor,
  woodPlantation,

  treeSeed,
  tree,
})
