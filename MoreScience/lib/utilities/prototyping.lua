function removePrerequisiteTechnology(technologyName, prerequisiteToRemove)
  if data.raw["technology"][technologyName] and data.raw["technology"][technologyName].prerequisites then
    for index, prerequisite in pairs(data.raw["technology"][technologyName].prerequisites) do
      if prerequisite == prerequisiteToRemove then
        table.remove(data.raw["technology"][technologyName].prerequisites, index)
        if #data.raw["technology"][technologyName].prerequisites == 0 then
          data.raw["technology"][technologyName].prerequisites = nil
        end
        break
      end
    end
  end
end



function addPrerequisiteTechnology(technologyName, prerequisiteToAdd)
  if data.raw["technology"][technologyName] then
    if not data.raw["technology"][technologyName].prerequisites then
      data.raw["technology"][technologyName].prerequisites = {}
    end
    for index, prerequisite in pairs(data.raw["technology"][technologyName].prerequisites) do
      if prerequisite == prerequisiteToAdd then
        log("WARNING: Tried adding prerequisite \'" .. prerequisiteToAdd .. "\' to \'" .. technologyName .. "\' which was already present.")
        return
      end
    end
    table.insert(data.raw["technology"][technologyName].prerequisites, prerequisiteToAdd)
  end
end



function removeRecipeUnlock(technologyName, recipeToRemove)
  if data.raw["technology"][technologyName] and data.raw["technology"][technologyName].effects then
    for index, effect in pairs(data.raw["technology"][technologyName].effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipeToRemove then
        table.remove(data.raw["technology"][technologyName].effects, index)
        if #data.raw["technology"][technologyName].effects == 0 then
          data.raw["technology"][technologyName].effects = nil
        end
        break
      end
    end
  end
end



function addRecipeUnlock(technologyName, recipeToAdd)
  if data.raw["technology"][technologyName] then
    if not data.raw["technology"][technologyName].effects then
      data.raw["technology"][technologyName].effects = {}
    end
    for index, effect in pairs(data.raw["technology"][technologyName].effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipeToAdd then
        return
      end
    end
    table.insert(data.raw["technology"][technologyName].effects, {type = "unlock-recipe", recipe = recipeToAdd})
  end
end



function removeScienceIngredient(technologyName, sciencePackName)
  if data.raw["technology"][technologyName] and data.raw["technology"][technologyName].unit.ingredients then
    for index, ingredient in pairs(data.raw["technology"][technologyName].unit.ingredients) do
      if ingredient[1] == sciencePackName then
        table.remove(data.raw["technology"][technologyName].unit.ingredients, index)
        if #data.raw["technology"][technologyName].unit.ingredients == 0 then
          data.raw["technology"][technologyName].unit.ingredients = nil
        end
        break
      end
    end
  end
end



function addScienceIngredient(technologyName, sciencePackAmount, sciencePackName)
  if data.raw["technology"][technologyName] and data.raw["technology"][technologyName].unit.ingredients then
    for index, ingredient in pairs(data.raw["technology"][technologyName].unit.ingredients) do
      if ingredient[1] == sciencePackName then
        log("WARNING: Tried adding ingredient \'" .. sciencePackName .. "\' to \'" .. technologyName .. "\' which was already present. Increased amount instead.")
        data.raw["technology"][technologyName].unit.ingredients[index][2] = ingredient[2] + sciencePackAmount
        return
      end
    end
    table.insert(data.raw["technology"][technologyName].unit.ingredients, {sciencePackName, sciencePackAmount})
  end
end



function disableRecipe(recipe)
   if not data.raw.recipe[recipe] then return end
   if data.raw["recipe"][recipe].normal then
      data.raw["recipe"][recipe].normal.enabled = false
      data.raw["recipe"][recipe].expensive.enabled = false
   else
      data.raw["recipe"][recipe].enabled = false
   end
end
