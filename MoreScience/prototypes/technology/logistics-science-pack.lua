require "lib/utilities/prototyping"

--------------------------------------------------------------------------------
----- Landfill:                                                            -----
--------------------------------------------------------------------------------
addPrerequisiteTechnology("landfill", "basic-science-research-1")



--------------------------------------------------------------------------------
----- Fluid handling                                                       -----
--------------------------------------------------------------------------------

-- disable the recipes
disableRecipe("pipe-to-ground")

-- remove recipe unlock
--removeRecipeUnlock("fluid-handling", "storage-tank")
addRecipeUnlock("fluid-handling", "pipe-to-ground")

-- add prerequisites
addPrerequisiteTechnology("oil-processing", "fluid-handling")



-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "fluid-handling-2",
    icon_size = 128,
    icon = "__base__/graphics/technology/fluid-handling.png",
    prerequisites =
    {
      "fluid-handling",
      --"basic-science-research-1",
      "oil-processing"
    },
    effects = nil, -- data-final-fixes.lua --> adding oil barreling
    --{
      --{
      --  type = "unlock-recipe",
      --  recipe = "storage-tank"
      --},
      --{
      --  type = "unlock-recipe",
      --  recipe = "pipe-to-ground"
      --},
    --},
    unit =
    {
      count = 150,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"basic-automation-science-pack", 1},
      },
      time = 60
    },
    order = "d-a-a"
  },
})
removePrerequisiteTechnology("fluid-wagon", "fluid-handling")
addPrerequisiteTechnology("fluid-wagon", "fluid-handling-2")



-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "fluid-handling-3",
    icon_size = 128,
    icon = "__base__/graphics/technology/fluid-handling.png",
    prerequisites =
    {
      "fluid-handling-2",
    },
    effects = nil, -- data-final-fixes.lua --> adding science barreling
    unit =
    {
      count = 300,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"basic-automation-science-pack", 1},
      },
      time = 60
    },
    order = "d-a-a"
  },
})

--------------------------------------------------------------------------------
----- Basic logistics science research                                     -----
--------------------------------------------------------------------------------

-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "basic-logistics-science-research",
    icon = "__MoreScience__/graphics/technology/science-symbol.png",
    icon_size = 2000,
    prerequisites =
    {
      --"basic-science-research-2",
      "electric-engine",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "basic-logistics-science-fluid"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-logistics-science-pack"
      },
    },
    unit =
    {
      count = 75,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 2},
        {"science-pack-3", 3},
        {"basic-automation-science-pack", 4},
        {"basic-power-science-pack", 5},
      },
      time = 30
    },
    order = "d-a-b"
  },
})

-- add prerequisites on the technology
addPrerequisiteTechnology("logistics-2", "basic-logistics-science-research")
addScienceIngredient("logistics-2", 1, "basic-logistics-science-pack")
addScienceIngredient("logistics-3", 1, "basic-logistics-science-pack")
addPrerequisiteTechnology("logistics-3", "basic-logistics-science-research")
addScienceIngredient("automobilism", 1, "basic-logistics-science-pack")
addScienceIngredient("tanks", 1, "basic-logistics-science-pack")
addScienceIngredient("stack-inserter", 1, "basic-logistics-science-pack")
addPrerequisiteTechnology("rocket-silo", "basic-logistics-science-research")

-- train network
removePrerequisiteTechnology("railway", "logistics-2")
--addPrerequisiteTechnology("railway", "basic-logistics-science-research")
--addScienceIngredient("railway", 1, "basic-logistics-science-pack")
--addScienceIngredient("automated-rail-transportation", 1, "basic-logistics-science-pack")
addPrerequisiteTechnology("rail-signals", "basic-logistics-science-research")
addScienceIngredient("rail-signals", 1, "basic-logistics-science-pack")
addScienceIngredient("fluid-wagon", 1, "basic-logistics-science-pack")
addPrerequisiteTechnology("fluid-wagon", "basic-logistics-science-research")

-- robot network
addPrerequisiteTechnology("robotics", "basic-logistics-science-research")
addScienceIngredient("robotics", 1, "basic-logistics-science-pack")
--addScienceIngredient("flying", 1, "basic-logistics-science-pack")
addScienceIngredient("construction-robotics", 1, "basic-logistics-science-pack")
addScienceIngredient("logistic-robotics", 1, "basic-logistics-science-pack")
addScienceIngredient("logistic-system", 1, "basic-logistics-science-pack")

addScienceIngredient("character-logistic-slots-1", 1, "basic-logistics-science-pack")
addScienceIngredient("character-logistic-slots-2", 1, "basic-logistics-science-pack")
addScienceIngredient("character-logistic-slots-3", 1, "basic-logistics-science-pack")
addScienceIngredient("character-logistic-slots-4", 1, "basic-logistics-science-pack")
addScienceIngredient("character-logistic-slots-5", 1, "basic-logistics-science-pack")
addScienceIngredient("character-logistic-slots-6", 1, "basic-logistics-science-pack")
addScienceIngredient("character-logistic-trash-slots-1", 1, "basic-logistics-science-pack")
addScienceIngredient("character-logistic-trash-slots-2", 1, "basic-logistics-science-pack")
addScienceIngredient("auto-character-logistic-trash-slots", 1, "basic-logistics-science-pack")
addScienceIngredient("personal-roboport-equipment", 1, "basic-logistics-science-pack")
addScienceIngredient("personal-roboport-equipment-2", 1, "basic-logistics-science-pack")

-- inserters bonus
addScienceIngredient("inserter-capacity-bonus-1", 1, "basic-logistics-science-pack")
addScienceIngredient("inserter-capacity-bonus-2", 1, "basic-logistics-science-pack")
addScienceIngredient("inserter-capacity-bonus-3", 1, "basic-logistics-science-pack")
addScienceIngredient("inserter-capacity-bonus-4", 1, "basic-logistics-science-pack")
addScienceIngredient("inserter-capacity-bonus-5", 1, "basic-logistics-science-pack")
addScienceIngredient("inserter-capacity-bonus-6", 1, "basic-logistics-science-pack")
addScienceIngredient("inserter-capacity-bonus-7", 1, "basic-logistics-science-pack")

-- train bonus
addPrerequisiteTechnology("braking-force-1", "logistics-2")
addScienceIngredient("braking-force-1", 1, "basic-logistics-science-pack")
addScienceIngredient("braking-force-2", 1, "basic-logistics-science-pack")
addScienceIngredient("braking-force-3", 1, "basic-logistics-science-pack")
addScienceIngredient("braking-force-4", 1, "basic-logistics-science-pack")
addScienceIngredient("braking-force-5", 1, "basic-logistics-science-pack")
addScienceIngredient("braking-force-6", 1, "basic-logistics-science-pack")
addScienceIngredient("braking-force-7", 1, "basic-logistics-science-pack")

-- robot bonus
addScienceIngredient("worker-robots-storage-1", 1, "basic-logistics-science-pack")
addScienceIngredient("worker-robots-storage-2", 1, "basic-logistics-science-pack")
addScienceIngredient("worker-robots-storage-3", 1, "basic-logistics-science-pack")
addScienceIngredient("worker-robots-speed-1", 1, "basic-logistics-science-pack")
addScienceIngredient("worker-robots-speed-2", 1, "basic-logistics-science-pack")
addScienceIngredient("worker-robots-speed-3", 1, "basic-logistics-science-pack")
addScienceIngredient("worker-robots-speed-4", 1, "basic-logistics-science-pack")
addScienceIngredient("worker-robots-speed-5", 1, "basic-logistics-science-pack")
addScienceIngredient("worker-robots-speed-6", 1, "basic-logistics-science-pack")
