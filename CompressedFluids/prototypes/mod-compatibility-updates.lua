if mods["space-exploration"] then
  local compressor = data.raw[(settings.startup["fluid-compressor-manual-recipes"].value == false) and "furnace" or "assembling-machine"]["fluid-compressor"]
  local decompressor = data.raw[(settings.startup["fluid-compressor-manual-recipes"].value == false) and "furnace" or "assembling-machine"]["fluid-decompressor"]
  if compressor then
    compressor.se_allow_in_space = true
  end
  if decompressor then
    decompressor.se_allow_in_space = true
  end
end