if settings.startup["fluid-compressor-singeEntity"].value == false then
  table.insert(data.raw["technology"]["fluid-compressor"].effects, {
    type = "unlock-recipe",
    recipe = "fluid-decompressor-to-compressor"
  })
  table.insert(data.raw["technology"]["fluid-compressor"].effects, {
    type = "unlock-recipe",
    recipe = "fluid-compressor-to-decompressor"
  })
end
