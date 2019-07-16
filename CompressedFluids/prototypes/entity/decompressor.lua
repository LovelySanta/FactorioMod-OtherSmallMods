local compressor = data.raw[(settings.startup["fluid-compressor-manual-recipes"].value == false) and "furnace" or "assembling-machine"]["fluid-compressor"]

if settings.startup["fluid-compressor-singeEntity"].value == true then
  -- allow the compressor to have decompressor recipes
  table.insert(compressor.crafting_categories, "fluid-decompressing")

  -- make sure the compressor works in the other direction (decompressing)
  -- this means aside from a big input side, it needs to have a big
  -- output side (must be the same size now)
  for boxIndex,compressorOutputFluidBox in pairs(compressor.fluid_boxes) do
    if compressorOutputFluidBox.production_type == "output" then
      for _,compressorInputFluidBox in pairs(compressor.fluid_boxes) do
        if compressorInputFluidBox.production_type == "input" then
          compressor.fluid_boxes[boxIndex].base_area = compressorInputFluidBox.base_area
        end
      end
    end
  end

else
  local decompressor = util.table.deepcopy(compressor)

  -- make sure the decompressor works, this means allow to have a small
  -- input side, but have a big output side to output lots of fluids
  for _,decompressorFluidBox in pairs(decompressor.fluid_boxes) do

    if decompressorFluidBox.production_type == "input" then
      for _,compressorFluidBox in pairs(compressor.fluid_boxes) do
        if compressorFluidBox.production_type == "output" then
          decompressorFluidBox.base_area = compressorFluidBox.base_area
        end
      end
    elseif decompressorFluidBox.production_type == "output" then
      for _,compressorFluidBox in pairs(compressor.fluid_boxes) do
        if compressorFluidBox.production_type == "input" then
          decompressorFluidBox.base_area = compressorFluidBox.base_area
        end
      end
    end
  end

  decompressor.name = "fluid-decompressor"
  decompressor.minable.result = "fluid-decompressor"
  decompressor.crafting_categories = {"fluid-decompressing"}

  data:extend{decompressor}
end
