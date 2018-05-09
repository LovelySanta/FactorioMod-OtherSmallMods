require "lib/utilities/prototyping"
require 'util'

local function addRocketScienceTechnology(name, prerequisites)
  data:extend({
    {
      type = "technology",
      name = name,
      icon = "__MoreScience__/graphics/technology/" .. name .. "-tech.png",
      icon_size = 128,
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = name,
        }
      },
      prerequisites = util.table.deepcopy(prerequisites),
      unit =
      {
        count = data.raw["technology"]["rocket-silo"].unit.count / 2,
        ingredients = data.raw["technology"]["rocket-silo"].unit.ingredients,
        time = data.raw["technology"]["rocket-silo"].unit.time,
      },
      order = data.raw["technology"]["rocket-silo"].order
    }
  })

  addPrerequisiteTechnology("rocket-silo", name)
end


--------------------------------------------------------------------------------
----- Rocket research                                                      -----
--------------------------------------------------------------------------------
-- Create rocket research
addRocketScienceTechnology("rocket", nil)
data.raw["technology"]["rocket"].icon_size = 250
data.raw["technology"]["rocket"].unit.count = data.raw["technology"]["rocket"].unit.count / 2
removeRecipeUnlock("rocket", "rocket")
removePrerequisiteTechnology("rocket-silo", "rocket")

-- Move prerequisites
for _,prerequisite in pairs(util.table.deepcopy(data.raw["technology"]["rocket-silo"].prerequisites)) do
  removePrerequisiteTechnology("rocket-silo", prerequisite)
  addPrerequisiteTechnology("rocket", prerequisite)
end

-- Move recipe unlocks
for _,recipe in pairs ({
  "low-density-structure",
  "rocket-fuel",
  "rocket-control-unit",
}) do
  removeRecipeUnlock("rocket-silo", recipe)
  addRecipeUnlock("rocket", recipe)
end

--------------------------------------------------------------------------------
----- Rocket parts research                                                -----
--------------------------------------------------------------------------------

-- Update research order
data.raw["technology"]["rocket-silo"].order = data.raw["technology"]["rocket"].order .. "-a"

-- Create rocket parts research
addRocketScienceTechnology("hull-component", {"rocket"})

addRocketScienceTechnology("ion-thruster", {"rocket"})
addRecipeUnlock("ion-thruster", "ion-booster")

addRocketScienceTechnology("fusion-reactor", {"rocket", "fusion-reactor-equipment", "kovarex-enrichment-process"})

addRocketScienceTechnology("shield-array", {"rocket", "energy-shield-mk2-equipment", "discharge-defense-equipment"})
addRecipeUnlock("shield-array", "laser-array")



--------------------------------------------------------------------------------
----- Rocket silo research                                                 -----
--------------------------------------------------------------------------------

-- update research oder
data.raw["technology"]["rocket-silo"].order = data.raw["technology"]["rocket"].order .. "-b"

--addPrerequisiteTechnology("rocket-silo", "solar-energy")
addPrerequisiteTechnology("rocket-silo", "electric-energy-accumulators-1")
