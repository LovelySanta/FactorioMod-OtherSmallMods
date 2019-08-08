
for _,fluidNameHP in pairs(CF_compressedFluidNames) do
  local fluidName = string.sub(fluidNameHP, 15)
  local compressingRecipe = data.raw.recipe["compressing-"..fluidName]
  local decompressingRecipe = data.raw.recipe["decompressing-"..fluidName]

  if compressingRecipe then
    compressingRecipe.ingredients[1].name = string.sub(compressingRecipe.results[1].name, 15)
  end

  if decompressingRecipe then
    decompressingRecipe.results[1].name = string.sub(decompressingRecipe.ingredients[1].name, 15)
  end

  if fluidName == "heavy-oil" then
    log(serpent.block(compressingRecipe))
  end
end