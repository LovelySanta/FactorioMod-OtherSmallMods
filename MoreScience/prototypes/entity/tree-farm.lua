require "util"
local animationLayer = {}

--------------------------------------------------------------------------------
----- seed-extractor                                                       -----
--------------------------------------------------------------------------------
local seedExtractor = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])
seedExtractor.name = "seed-extractor"
seedExtractor.icon = "__MoreScience__/graphics/icons/" .. seedExtractor.name .. ".png"
seedExtractor.icon_size = 32
seedExtractor.minable.result = seedExtractor.name
seedExtractor.fast_replaceable_group = "seed-extractor"
seedExtractor.crafting_categories = {"seed-extractor"}
seedExtractor.crafting_speed = 1
seedExtractor.ingredient_count = 2
seedExtractor.energy_usage = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"].energy_usage)

seedExtractor.animation.layers =  {}
animationLayer = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"].animation.layers[1])
animationLayer.filename = "__MoreScience__/graphics/entity/" .. seedExtractor.name .. ".png"
animationLayer.line_length = 5
animationLayer.frame_count = 5 * animationLayer.line_length
animationLayer.width = 800 / animationLayer.line_length
animationLayer.height = 800 / (animationLayer.frame_count / animationLayer.line_length)
animationLayer.shift = util.by_pixel(0, 2)
animationLayer.scale = .95
animationLayer.hr_version = nil
table.insert(seedExtractor.animation.layers, util.table.deepcopy(animationLayer))



--------------------------------------------------------------------------------
----- wood-plantation                                                      -----
--------------------------------------------------------------------------------
local woodPlantation = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])
woodPlantation.name = "wood-plantation"
woodPlantation.icon = "__MoreScience__/graphics/icons/" .. woodPlantation.name .. ".png"
woodPlantation.icon_size = 32
woodPlantation.minable.result = woodPlantation.name
woodPlantation.fast_replaceable_group = "wood-plantation"
woodPlantation.crafting_categories = {"wood-plantation"}
woodPlantation.crafting_speed = 1
woodPlantation.ingredient_count = 1
woodPlantation.energy_usage = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"].energy_usage)
woodPlantation.selection_box = util.table.deepcopy(data.raw["assembling-machine"]["oil-refinery"].selection_box)
woodPlantation.collision_box = util.table.deepcopy(data.raw["assembling-machine"]["oil-refinery"].collision_box)
woodPlantation.scale_entity_info_icon = true

woodPlantation.animation.layers = {}
animationLayer = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"].animation.layers[1])
animationLayer.filename = "__MoreScience__/graphics/entity/" .. woodPlantation.name .. ".png"
animationLayer.line_length = 6
animationLayer.frame_count = 6 * animationLayer.line_length
animationLayer.width = 1344 / animationLayer.line_length
animationLayer.height = 1344 / (animationLayer.frame_count / animationLayer.line_length)
animationLayer.shift = util.by_pixel(0, 2)
animationLayer.scale = 1
animationLayer.hr_version = nil
table.insert(woodPlantation.animation.layers, util.table.deepcopy(animationLayer))



data:extend({
  seedExtractor,
  woodPlantation,
})
