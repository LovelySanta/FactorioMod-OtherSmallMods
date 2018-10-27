if settings.startup["fluid-compression-singeEntity"].value == true then
  table.insert(data.raw["furnace"]["fluid-compressor"].crafting_categories, "fluid-decompressing")
else
  local decompressor = util.table.deepcopy(data.raw["furnace"]["fluid-compressor"])
  decompressor.name = "fluid-decompressor"
  decompressor.minable.result = "fluid-decompressor"
  decompressor.crafting_categories = {"fluid-decompressing"}
  data:extend{decompressor}
end
