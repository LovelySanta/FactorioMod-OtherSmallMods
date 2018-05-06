
--------------------------------------------------------------------------------
----- Basic power science pack                                             -----
--------------------------------------------------------------------------------

-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "basic-power-science-research",
    icon = "__MoreScience__/graphics/science-symbol.png",
    icon_size = 2000,
    prerequisites = {
      "basic-automation-science-research",
      "battery",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "basic-power-science-fluid"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-power-science-pack"
      },
    },
    unit =
    {
      count = 50,
      ingredients = {
        {"science-pack-1", 1},
        {"science-pack-2", 3},
        {"basic-automation-science-pack", 5},
      },
      time = 10
    },
    upgrade = false,
    order = "c-a"
  },
})

-- add prerequisites on the technology

-- power
addPrerequisiteTechnology("electric-energy-distribution-2", "basic-power-science-research")
addScienceIngredient("electric-energy-distribution-2", 1, "basic-power-science-pack")
addPrerequisiteTechnology("electric-energy-accumulators-1", "basic-power-science-research")
addScienceIngredient("electric-energy-accumulators-1", 1, "basic-power-science-pack")
addPrerequisiteTechnology("solar-energy", "basic-power-science-research")
addScienceIngredient("solar-energy", 1, "basic-power-science-pack")
addPrerequisiteTechnology("nuclear-power", "basic-power-science-research")
addScienceIngredient("nuclear-power", 1, "basic-power-science-pack")
addScienceIngredient("nuclear-fuel-reprocessing", 1, "basic-power-science-pack")
addScienceIngredient("kovarex-enrichment-process", 1, "basic-power-science-pack")

-- power modules
addPrerequisiteTechnology("effectivity-module", "basic-power-science-research")
addScienceIngredient("effectivity-module", 1, "basic-power-science-pack")
addScienceIngredient("effectivity-module-2", 1, "basic-power-science-pack")
addScienceIngredient("effectivity-module-3", 1, "basic-power-science-pack")

-- automation
addPrerequisiteTechnology("electric-engine", "basic-power-science-research")
addScienceIngredient("electric-engine", 1, "basic-power-science-pack")
addScienceIngredient("flying", 1, "basic-power-science-pack")
addScienceIngredient("construction-robotics", 1, "basic-power-science-pack")
addScienceIngredient("logistic-robotics", 1, "basic-power-science-pack")

-- Laser turrets
addPrerequisiteTechnology("laser-turrets", "basic-power-science-research")
addScienceIngredient("laser-turrets", 1, "basic-power-science-pack")

-- armor equipment
addPrerequisiteTechnology("solar-panel-equipment", "solar-energy")
addScienceIngredient("solar-panel-equipment", 1, "basic-power-science-pack")
addScienceIngredient("fusion-reactor-equipment", 1, "basic-power-science-pack")
addPrerequisiteTechnology("battery-equipment", "basic-power-science-research")
addScienceIngredient("battery-equipment", 1, "basic-power-science-pack")
addScienceIngredient("battery-mk2-equipment", 1, "basic-power-science-pack")
addScienceIngredient("personal-laser-defense-equipment", 1, "basic-power-science-pack")
addScienceIngredient("discharge-defense-equipment", 1, "basic-power-science-pack")
addPrerequisiteTechnology("energy-shield-equipment", "basic-power-science-research")
addScienceIngredient("energy-shield-equipment", 1, "basic-power-science-pack")
addScienceIngredient("energy-shield-mk2-equipment", 1, "basic-power-science-pack")
addScienceIngredient("personal-roboport-equipment", 1, "basic-power-science-pack")
addScienceIngredient("personal-roboport-equipment-2", 1, "basic-power-science-pack")

-- bonusses
addScienceIngredient("laser-turret-damage-1", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-damage-2", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-damage-3", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-damage-4", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-damage-5", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-damage-6", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-damage-7", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-damage-8", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-speed-1", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-speed-2", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-speed-3", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-speed-4", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-speed-5", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-speed-6", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-speed-7", 1, "basic-power-science-pack")
addScienceIngredient("laser-turret-speed-8", 1, "basic-power-science-pack")
--addScienceIngredient("worker-robot-speed-1", 1, "basic-power-science-pack")
--addScienceIngredient("worker-robot-speed-2", 1, "basic-power-science-pack")
--addScienceIngredient("worker-robot-speed-3", 1, "basic-power-science-pack")
--addScienceIngredient("worker-robot-speed-4", 1, "basic-power-science-pack")
--addScienceIngredient("worker-robot-speed-5", 1, "basic-power-science-pack")
--addScienceIngredient("worker-robot-speed-6", 1, "basic-power-science-pack")
addScienceIngredient("mining-productivity-16", 1, "basic-power-science-pack")
