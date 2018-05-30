require 'src/settings'

require 'lib/utilities/prototyping'
require 'lib/utilities/util'

--------------------------------------------------------------------------------
-- Item                                                                     --
--------------------------------------------------------------------------------
local deepStorageItem = deepcopy(data.raw["item"]["steel-chest"])

deepStorageItem.name = Settings.storageItemName
deepStorageItem.icon = "__DeepStorage__/graphics/icons/smart-chest.png"
deepStorageItem.icon_size = 32
deepStorageItem.order = stringSplit(deepStorageItem.order, "-")[1] .. "-d[" .. deepStorageItem.name .. "]"
deepStorageItem.place_result = Settings.storageChestName



--------------------------------------------------------------------------------
-- Storage entity                                                             --
--------------------------------------------------------------------------------
-- https://wiki.factorio.com/Prototype/Car
local deepStorageChest = deepcopy(data.raw["car"]["car"])

deepStorageChest.name = Settings.storageChestName
deepStorageChest.icon = deepStorageItem.icon
deepStorageChest.icon_size = deepStorageItem.icon_size
deepStorageChest.flags = {"placeable-neutral", "player-creation", "not-rotatable", "not-on-map"}
deepStorageChest.order = deepStorageItem.order

deepStorageChest.minable =
{
  mining_time = data.raw["container"]["steel-chest"].minable.mining_time,
  result = deepStorageItem.name,
}
deepStorageChest.placeable_by = {item=deepStorageItem.name, count= 1}

deepStorageChest.selection_box = nil
deepStorageChest.collision_box = deepcopy(data.raw["container"]["steel-chest"].collision_box)
deepStorageChest.collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile"}
--deepStorageChest.has_belt_immunity = true

deepStorageChest.max_health = 2 * data.raw["container"]["steel-chest"].max_health
deepStorageChest.corpse = deepcopy(data.raw["container"]["steel-chest"].corpse)
deepStorageChest.resistances = deepcopy(data.raw["container"]["steel-chest"].resistances)

deepStorageChest.open_sound = deepcopy(data.raw["container"]["steel-chest"].open_sound)
deepStorageChest.close_sound = deepcopy(data.raw["container"]["steel-chest"].close_sound)

deepStorageChest.burner.fuel_inventory_size = 0
deepStorageChest.burner.render_no_power_icon = false
deepStorageChest.sound_no_fuel = nil
deepStorageChest.inventory_size = 2

deepStorageChest.guns = nil
deepStorageChest.turret_animation = nil

deepStorageChest.light = nil
deepStorageChest.animation = pictureToRotatedAnimation{
  filename = "__DeepStorage__/graphics/entity/smart-chest.png",
  priority = "extra-high",
  width = 62,
  height = 41,
  shift = {0.4, -0.13}
}
deepStorageChest.render_layer = nil
deepStorageChest.equipment_grid = nil



--------------------------------------------------------------------------------
-- Circuit network entity                                                             --
--------------------------------------------------------------------------------
local deepStorageMonitor = deepcopy(data.raw["constant-combinator"]["constant-combinator"])

deepStorageMonitor.name = Settings.storageMonitorName
deepStorageMonitor.icon = deepStorageItem.icon
deepStorageMonitor.icon_size = deepStorageItem.icon_size
deepStorageMonitor.flags = {"placeable-neutral", "player-creation", "not-rotatable", "placeable-off-grid"}
deepStorageMonitor.order = deepStorageItem.order

deepStorageMonitor.minable = deepcopy(deepStorageChest.minable)
deepStorageMonitor.placeable_by = deepcopy(deepStorageChest.placeable_by)

deepStorageMonitor.selection_box = deepcopy(data.raw["container"]["steel-chest"].selection_box)
deepStorageMonitor.collision_box = nil
deepStorageMonitor.collision_mask = nil

deepStorageMonitor.max_health = deepStorageChest.max_health
deepStorageMonitor.resistances = deepcopy(deepStorageChest.resistances)
deepStorageMonitor.item_slot_count = 1

deepStorageMonitor.sprites = oneToFourWay{
  filename = "__core__/graphics/empty.png",
  priority = "extra-high",
  width = 1,
  height = 1,
  shift = {0, 0}
}
deepStorageMonitor.activity_led_sprites = deepcopy(deepStorageMonitor.sprites)
deepStorageMonitor.activity_led_light.intensity = 0

deepStorageMonitor.circuit_wire_connection_points = oneToFourWay{
  wire =
    {
      red = {0.3, -0.7},
      green = {0.3, -0.6},
    },
  shadow =
    {
      red = {1.2, 0.2},
      green = {1.2, 0.3},
    },
}
deepStorageMonitor.circuit_wire_max_distance = deepcopy(data.raw["container"]["steel-chest"].circuit_wire_max_distance)



data:extend({
  -- item
  deepStorageItem,

  -- entity
  deepStorageMonitor,
  deepStorageChest,
})
