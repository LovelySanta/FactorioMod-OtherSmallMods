
for fluidName,fluidNameHP in pairs(compressedFluids.internalData.compressedFluidNames) do

  if fluidNameHP and data.raw.fluid[fluidName] then
    
    local compressingRecipe = data.raw.recipe["compressing-"..fluidName]
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

    local decompressingRecipe = data.raw.recipe["decompressing-"..fluidName]
    if decompressingRecipe then
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

  else -- fluid got removed somehow, so we remove our compression recipes as well

    data.raw.recipe["compressing-"..fluidName] = nil
    data.raw.recipe["decompressing-"..fluidName] = nil

  end

end