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
  if data.raw["technology"][technologyName] and not data.raw["technology"][technologyName].prerequisites then
    data.raw["technology"][technologyName].prerequisites = {}
  end
  table.insert(data.raw["technology"][technologyName].prerequisites, prerequisiteToAdd)
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
  if data.raw["technology"][technologyName] and not data.raw["technology"][technologyName].effects then
    data.raw["technology"][technologyName].effects = {}
  end
  table.insert(data.raw["technology"][technologyName].effects, {type = "unlock-recipe", recipe = recipeToAdd})
end



function addScienceIngredient(technologyName, sciencePackAmount, sciencePackName)
  if data.raw["technology"][technologyName] and data.raw["technology"][technologyName].unit.ingredients then
    table.insert(data.raw["technology"][technologyName].unit.ingredients, {sciencePackName, sciencePackAmount})
  end
end
