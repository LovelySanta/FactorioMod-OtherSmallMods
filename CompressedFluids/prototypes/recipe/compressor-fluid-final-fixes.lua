-- make sure ingredient list is set correctly
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
        decompressingRecipe.main_product = decompressingRecipe.main_product and resultName or nil
      end
      if decompressingRecipe.normal and decompressingRecipe.normal.results then
        decompressingRecipe.normal.results[1].name = resultName
        decompressingRecipe.normal.main_product = decompressingRecipe.normal.main_product and resultName or nil
      end
      if decompressingRecipe.expensive and decompressingRecipe.expensive.results then
        decompressingRecipe.expensive.results[1].name = resultName
        decompressingRecipe.expensive.main_product = decompressingRecipe.expensive.main_product and resultName or nil
      end
    end

  else -- fluid got removed somehow, so we remove our compression recipes as well

    compressedFluids.internalData.compressedFluidNames[fluidName] = false
    data.raw.recipe["compressing-"..fluidName] = nil
    data.raw.recipe["decompressing-"..fluidName] = nil

  end

end



-- now add temperature related recipes
compressedFluids.remoteData = compressedFluids.remoteData or {}
compressedFluids.remoteData.fluidTemperatures = compressedFluids.remoteData.fluidTemperatures or {}
for fluidName,fluidNameHP in pairs(compressedFluids.internalData.compressedFluidNames) do

  if fluidNameHP and compressedFluids.remoteData.fluidTemperatures[fluidName] then

    local fluidMinTemp = data.raw.fluid[fluidName].default_temperature
    local fluidMaxTemp = data.raw.fluid[fluidName].max_temperature

    if fluidMinTemp < fluidMaxTemp then

      -- create an ordered list of all temperatures
      local fluidTemps = {}
      local thisFluidTemp = fluidMinTemp
      while(thisFluidTemp < fluidMaxTemp) do
        table.insert(fluidTemps, thisFluidTemp)
        local nextFluidTemp = fluidMaxTemp
        for _, temp in pairs(compressedFluids.remoteData.fluidTemperatures[fluidName]) do
          if (temp < nextFluidTemp) and (thisFluidTemp < temp and temp < fluidMaxTemp) then
            nextFluidTemp = temp
          end
        end
        thisFluidTemp = nextFluidTemp
      end
      table.insert(fluidTemps, fluidMaxTemp)

      -- create the dummy (visible) compressing temperature recipes
      if data.raw.recipe["compressing-"..fluidName] and
         settings.startup["fluid-compressor-manual-recipes"].value == true and
         settings.startup["fluid-compressor-hide-recipes"].value == false
      then
        for tempIndex=2, #fluidTemps-1 do
          local compressingRecipe = util.table.deepcopy(data.raw.recipe["compressing-"..fluidName])
          compressingRecipe.name = compressingRecipe.name.."-"..fluidTemps[tempIndex].."-dummy"
          compressingRecipe.category = compressingRecipe.category .. "-dummy"

          if compressingRecipe.ingredients then
            compressingRecipe.ingredients[1].temperature = fluidTemps[tempIndex]
          end
          if compressingRecipe.normal and compressingRecipe.normal.ingredients then
            compressingRecipe.normal.ingredients[1].temperature = fluidTemps[tempIndex]
          end
          if compressingRecipe.expensive and compressingRecipe.expensive.ingredients then
            compressingRecipe.expensive.ingredients[1].temperature = fluidTemps[tempIndex]
          end

          if compressingRecipe.results then
            compressingRecipe.results[1].temperature = fluidTemps[tempIndex]
          end
          if compressingRecipe.normal and compressingRecipe.normal.results then
            compressingRecipe.normal.results[1].temperature = fluidTemps[tempIndex]
          end
          if compressingRecipe.expensive and compressingRecipe.expensive.results then
            compressingRecipe.expensive.results[1].temperature = fluidTemps[tempIndex]
          end

          data:extend{compressingRecipe}
        end
      end

      -- create the dummy (visible) decompressing temperature recipes
      if data.raw.recipe["decompressing-"..fluidName] and
         settings.startup["fluid-compressor-manual-recipes"].value == true and
         settings.startup["fluid-compressor-hide-recipes"].value == false
      then
        for tempIndex=2, #fluidTemps-1 do
          local decompressingRecipe = util.table.deepcopy(data.raw.recipe["decompressing-"..fluidName])
          decompressingRecipe.name = decompressingRecipe.name.."-"..fluidTemps[tempIndex].."-dummy"
          decompressingRecipe.category = decompressingRecipe.category .. "-dummy"

          if decompressingRecipe.ingredients then
            decompressingRecipe.ingredients[1].temperature = fluidTemps[tempIndex]
          end
          if decompressingRecipe.normal and decompressingRecipe.normal.ingredients then
            decompressingRecipe.normal.ingredients[1].temperature = fluidTemps[tempIndex]
          end
          if decompressingRecipe.expensive and decompressingRecipe.expensive.ingredients then
            decompressingRecipe.expensive.ingredients[1].temperature = fluidTemps[tempIndex]
          end

          if decompressingRecipe.results then
            decompressingRecipe.results[1].temperature = fluidTemps[tempIndex]
          end
          if decompressingRecipe.normal and decompressingRecipe.normal.results then
            decompressingRecipe.normal.results[1].temperature = fluidTemps[tempIndex]
          end
          if decompressingRecipe.expensive and decompressingRecipe.expensive.results then
            decompressingRecipe.expensive.results[1].temperature = fluidTemps[tempIndex]
          end

          data:extend{decompressingRecipe}
        end
      end

      -- create temperature for the actual recipes
      local recipeTemps = {}
      for tempIndex=1, #fluidTemps-1 do
        table.insert(recipeTemps, {
          min = tempIndex > 1 and fluidTemps[tempIndex] or nil,
          max = tempIndex < #fluidTemps-1 and fluidTemps[tempIndex+1]-0.01 or nil
        })
      end

      -- create the actual compressing temperature recipes
      if data.raw.recipe["compressing-"..fluidName] then
        for _,recipeTemp in pairs(recipeTemps) do
          local compressingRecipe = util.table.deepcopy(data.raw.recipe["compressing-"..fluidName])
          compressingRecipe.name = compressingRecipe.name .. "-" .. (recipeTemp.min or fluidMinTemp)
          compressingRecipe.hide_from_player_crafting = true

          if compressingRecipe.ingredients then
            compressingRecipe.ingredients[1].temperature = nil
            compressingRecipe.ingredients[1].minimum_temperature = recipeTemp.min
            compressingRecipe.ingredients[1].maximum_temperature = recipeTemp.max
          end
          if compressingRecipe.normal and compressingRecipe.normal.ingredients then
            compressingRecipe.normal.ingredients[1].temperature = nil
            compressingRecipe.normal.ingredients[1].minimum_temperature = recipeTemp.min
            compressingRecipe.normal.ingredients[1].maximum_temperature = recipeTemp.max
          end
          if compressingRecipe.expensive and compressingRecipe.expensive.ingredients then
            compressingRecipe.expensive.ingredients[1].temperature = nil
            compressingRecipe.expensive.ingredients[1].minimum_temperature = recipeTemp.min
            compressingRecipe.expensive.ingredients[1].maximum_temperature = recipeTemp.max
          end

          if compressingRecipe.results then
            compressingRecipe.results[1].temperature = recipeTemp.min or fluidMinTemp
            compressingRecipe.results[1].minimum_temperature = nil
            compressingRecipe.results[1].maximum_temperature = nil
          end
          if compressingRecipe.normal and compressingRecipe.normal.results then
            compressingRecipe.normal.results[1].temperature = recipeTemp.min or fluidMinTemp
            compressingRecipe.normal.results[1].minimum_temperature = nil
            compressingRecipe.normal.results[1].maximum_temperature = nil
          end
          if compressingRecipe.expensive and compressingRecipe.expensive.results then
            compressingRecipe.expensive.results[1].temperature = recipeTemp.min or fluidMinTemp
            compressingRecipe.expensive.results[1].minimum_temperature = nil
            compressingRecipe.expensive.results[1].maximum_temperature = nil
          end

          data:extend{compressingRecipe}
        end
        data.raw.recipe["compressing-"..fluidName] = nil
      end

      -- create actual decompressing temperature recipes
      if data.raw.recipe["decompressing-"..fluidName] then
        for _,recipeTemp in pairs(recipeTemps) do
          local decompressingRecipe = util.table.deepcopy(data.raw.recipe["decompressing-"..fluidName])
          decompressingRecipe.name = decompressingRecipe.name .. "-" .. (recipeTemp.min or fluidMinTemp)
          decompressingRecipe.hide_from_player_crafting = true

          if decompressingRecipe.ingredients then
            decompressingRecipe.ingredients[1].temperature = nil
            decompressingRecipe.ingredients[1].minimum_temperature = recipeTemp.min
            decompressingRecipe.ingredients[1].maximum_temperature = recipeTemp.max
          end
          if decompressingRecipe.normal and decompressingRecipe.normal.ingredients then
            decompressingRecipe.normal.ingredients[1].temperature = nil
            decompressingRecipe.normal.ingredients[1].minimum_temperature = recipeTemp.min
            decompressingRecipe.normal.ingredients[1].maximum_temperature = recipeTemp.max
          end
          if decompressingRecipe.expensive and decompressingRecipe.expensive.ingredients then
            decompressingRecipe.expensive.ingredients[1].temperature = nil
            decompressingRecipe.expensive.ingredients[1].minimum_temperature = recipeTemp.min
            decompressingRecipe.expensive.ingredients[1].maximum_temperature = recipeTemp.max
          end

          if decompressingRecipe.results then
            decompressingRecipe.results[1].temperature = recipeTemp.min or fluidMinTemp
            decompressingRecipe.results[1].minimum_temperature = nil
            decompressingRecipe.results[1].maximum_temperature = nil
          end
          if decompressingRecipe.normal and decompressingRecipe.normal.results then
            decompressingRecipe.normal.results[1].temperature = recipeTemp.min or fluidMinTemp
            decompressingRecipe.normal.results[1].minimum_temperature = nil
            decompressingRecipe.normal.results[1].maximum_temperature = nil
          end
          if decompressingRecipe.expensive and decompressingRecipe.expensive.results then
            decompressingRecipe.expensive.results[1].temperature = recipeTemp.min or fluidMinTemp
            decompressingRecipe.expensive.results[1].minimum_temperature = nil
            decompressingRecipe.expensive.results[1].maximum_temperature = nil
          end

          data:extend{decompressingRecipe}
        end
        data.raw.recipe["decompressing-"..fluidName] = nil
      end
    end


  end

end