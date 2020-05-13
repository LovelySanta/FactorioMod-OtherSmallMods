local compressionRate = settings.startup["fluid-compression-rate"].value
local compressionSpeed = settings.startup["fluid-compression-speed"].value
local compressionBuffer = settings.startup["fluid-compressor-buffer"].value
local compressionThroughput = 10 * compressionRate * compressionSpeed
local baseAreaUnit = 1/100 -- amount of fluid fits in 1 unit of base area

data:extend{
  {
    type = (settings.startup["fluid-compressor-manual-recipes"].value == false) and "furnace" or "assembling-machine",
    name = "fluid-compressor",
    localised_description = {"",
      {"entity-description.fluid-compressor"},
      {"tooltip-description.custom-parameter", {"description.pumping-speed" }, {"", string.format("%.0f", compressionThroughput), {"per-second-suffix"}}}
    },
    icon = "__CompressedFluids__/graphics/icons/compressor.png",
    icon_size = 51,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "fluid-compressor"},
    max_health = 100,
    --fast_replaceable_group = "pipe",
    corpse = "small-remnants",
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    crafting_categories = {"fluid-compressing"},
    result_inventory_size = 1,
    crafting_speed = 1,
    source_inventory_size = 1,
    resistances =
    {
      {
        type = "fire",
        percent = 80
      },
      {
        type = "impact",
        percent = 30
      },
      {
        type = "explosion",
        percent = 50
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        base_area = math.ceil(compressionSpeed/10)*baseAreaUnit * compressionBuffer*compressionSpeed*compressionRate,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -1} }}
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        base_area = math.ceil(compressionSpeed/10)*baseAreaUnit * compressionBuffer*compressionSpeed,
        base_level = 1,
        pipe_connections = {{ position = {0, 1} }}
      },
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions = 0.03 / 2.5
    },
    energy_usage = "100kW",
    animation =
    {
      north =
      {
        filename = "__CompressedFluids__/graphics/entity/compressor-down.png",
        priority = "extra-high",
        frame_count = 8,
        width = 488/8,
        height = 58,
        shift = {0.421875, -0.125},
      },
      east =
      {
        filename = "__CompressedFluids__/graphics/entity/compressor-left.png",
        priority = "extra-high",
        frame_count = 8,
        width = 448/8,
        height = 44,
        shift = {0.3125, 0.0625},
      },
      south =
      {
        filename = "__CompressedFluids__/graphics/entity/compressor-up.png",
        priority = "extra-high",
        frame_count = 8,
        width = 368/8,
        height = 52,
        shift = {0.09375, 0.03125},
      },
      west =
      {
        filename = "__CompressedFluids__/graphics/entity/compressor-right.png",
        priority = "extra-high",
        frame_count = 8,
        width = 408/8,
        height = 56,
        shift = {0.265625, -0.21875},
      },
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
  },
}