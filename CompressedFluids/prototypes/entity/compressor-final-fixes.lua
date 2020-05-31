compressedFluids.remoteData = compressedFluids.remoteData or {}
compressedFluids.remoteData.fluidTemperatures = compressedFluids.remoteData.fluidTemperatures or {}

if next(compressedFluids.remoteData.fluidTemperatures) and
   settings.startup["fluid-compressor-manual-recipes"].value == true and
   settings.startup["fluid-compressor-hide-recipes"].value == false
then
  -- we have fluid temps, create dummy compressor for dummy recipes (unobtainable)
  local compressor = util.table.deepcopy(data.raw[(settings.startup["fluid-compressor-manual-recipes"].value == false) and "furnace" or "assembling-machine"]["fluid-compressor"])
  compressor.localised_name = compressor.localised_name or {"entity-name."..compressor.name}
  compressor.name = compressor.name .. "-dummy"

  for craft_index, craft_category in pairs(compressor.crafting_categories) do
    compressor.crafting_categories[craft_index] = craft_category .. "-dummy"
    if not data.raw["recipe-category"][compressor.crafting_categories[craft_index]] then
      data:extend{
        {
          type = "recipe-category",
          name = compressor.crafting_categories[craft_index]
        }
      }
    end
  end

  --compressor.flags = compressor.flags or {}
  --table.insert(compressor.flags, "hidden")

  compressor.order = data.raw["item"][compressor.minable.result].order
  compressor.subgroup = data.raw["item"][compressor.minable.result].subgroup

  data:extend{compressor}
end
