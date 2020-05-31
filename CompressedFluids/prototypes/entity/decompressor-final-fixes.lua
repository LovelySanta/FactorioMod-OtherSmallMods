compressedFluids.remoteData = compressedFluids.remoteData or {}
compressedFluids.remoteData.fluidTemperatures = compressedFluids.remoteData.fluidTemperatures or {}

if next(compressedFluids.remoteData.fluidTemperatures) and
   settings.startup["fluid-compressor-manual-recipes"].value == true and
   settings.startup["fluid-compressor-hide-recipes"].value == false
then
  -- we have fluid temps, create dummy decompressor for dummy recipes (unobtainable)
  local decompressor = util.table.deepcopy(data.raw[(settings.startup["fluid-compressor-manual-recipes"].value == false) and "furnace" or "assembling-machine"]["fluid-decompressor"])
  if decompressor then
    decompressor.localised_name = decompressor.localised_name or {"entity-name."..decompressor.name}
    decompressor.name = decompressor.name .. "-dummy"

    for craft_index, craft_category in pairs(decompressor.crafting_categories) do
      decompressor.crafting_categories[craft_index] = craft_category .. "-dummy"
      if not data.raw["recipe-category"][decompressor.crafting_categories[craft_index]] then
        data:extend{
          {
            type = "recipe-category",
            name = decompressor.crafting_categories[craft_index]
          }
        }
      end
    end

    --decompressor.flags = decompressor.flags or {}
    --table.insert(decompressor.flags, "hidden")

    decompressor.order = data.raw["item"][decompressor.minable.result].order
    decompressor.subgroup = data.raw["item"][decompressor.minable.result].subgroup

    data:extend{decompressor}
  end
end
