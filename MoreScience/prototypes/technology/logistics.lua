require "lib/utilities/prototyping"

--------------------------------------------------------------------------------
----- Landfill:                                                            -----
--------------------------------------------------------------------------------
addPrerequisiteTechnology("landfill", "basic-science-research-1")



--------------------------------------------------------------------------------
----- Fluid handling                                                       -----
--------------------------------------------------------------------------------

-- disable the recipes
data.raw["recipe"]["pipe-to-ground"].enabled = false

-- remove recipe unlock
removeRecipeUnlock("fluid-handling", "storage-tank")

-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "fluid-handling-2",
    icon_size = 128,
    icon = "__base__/graphics/technology/fluid-handling.png",
    prerequisites = {"fluid-handling"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "storage-tank"
      },
      {
        type = "unlock-recipe",
        recipe = "pipe-to-ground"
      },
    },
    unit =
    {
      count = 40,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
      },
      time = 30
    },
    order = "d-a-a"
  },
})
removePrerequisiteTechnology("fluid-wagon", "fluid-handling")
addPrerequisiteTechnology("fluid-wagon", "fluid-handling-2")



--------------------------------------------------------------------------------
----- Basic logistics science research                                     -----
--------------------------------------------------------------------------------

-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "basic-logistics-science-research",
    icon = "__MoreScience__/graphics/science-symbol.png",
    icon_size = 2000,
    prerequisites =
    {
      "basic-science-research-2",
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
        {"science-pack-2", 3},
        {"science-pack-3", 5},
      },
      time = 30
    },
    order = "d-a-b"
  },
})

-- add prerequisites on the technology
addPrerequisiteTechnology("logistics-2", "basic-logistics-science-research")
addScienceIngredient("logistics-2", 1, "basic-logistics-science-pack")
addScienceIngredient("automobilism", 1, "basic-logistics-science-pack")

removePrerequisiteTechnology("railway", "logistics-2")
addPrerequisiteTechnology("railway", "basic-logistics-science-research")
addScienceIngredient("railway", 1, "basic-logistics-science-pack")
addScienceIngredient("automated-rail-transportation", 1, "basic-logistics-science-pack")
addScienceIngredient("rail-signals", 1, "basic-logistics-science-pack")
addScienceIngredient("fluid-wagon", 1, "basic-logistics-science-pack")

addScienceIngredient("flying", 1, "basic-logistics-science-pack")
addScienceIngredient("construction-robotics", 1, "basic-logistics-science-pack")
addScienceIngredient("logistic-robotics", 1, "basic-logistics-science-pack")
addScienceIngredient("logistic-system", 1, "basic-logistics-science-pack")

addPrerequisiteTechnology("braking-force-1", "logistics-2")
addScienceIngredient("braking-force-1", 1, "basic-logistics-science-pack")
