
for fluidName,fluidNameHP in pairs(CF_compressedFluidNames) do
  local compressingRecipe = data.raw.recipe["compressing-"..fluidName]
  local decompressingRecipe = data.raw.recipe["decompressing-"..fluidName]

  if compressingRecipe then
    local ingredientName = string.sub((compressingRecipe.results or
                                       compressingRecipe.normal.results or
                                       compressingRecipe.expensive.results)[1].name, 15)

    if compressingRecipe.ingredients then
      compressingRecipe.ingredients[1].name = ingredientName
    end

    if compressingRecipe.normal and compressingRecipe.normal.ingredients then
      compressingRecipe.normal.ingredients[1].name = ingredientName
    end

    if compressingRecipe.expensive and compressingRecipe.expensive.ingredients then
      compressingRecipe.expensive.ingredients[1].name = ingredientName
    end
  end

  if decompressingRecipe then
    log(serpent.block(decompressingRecipe))
    local resultName = string.sub((decompressingRecipe.ingredients or
                                   decompressingRecipe.normal.ingredients or
                                   decompressingRecipe.expensive.ingredients)[1].name, 15)

    if decompressingRecipe.results then
      decompressingRecipe.results[1].name = resultName
    end

    if decompressingRecipe.normal and decompressingRecipe.normal.results then
      decompressingRecipe.normal.results[1].name = resultName
    end

    if decompressingRecipe.expensive and decompressingRecipe.expensive.results then
      decompressingRecipe.expensive.results[1].name = resultName
    end
  end

end