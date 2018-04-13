require "lib/utilities/prototyping"

--------------------------------------------------------------------------------
----- Basic automation                                                     -----
--------------------------------------------------------------------------------

-- disable the recipes
data.raw["recipe"]["inserter"].enabled = false
data.raw["recipe"]["transport-belt"].enabled = false

-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "basic-automation",
    icon = "__base__/graphics/technology/automation.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "inserter"
      },
      {
        type = "unlock-recipe",
        recipe = "transport-belt"
      },
    },
    prerequisites = nil,
    unit =
    {
      count = 5,
      ingredients =
      {
        {"science-pack-1", 1}
      },
      time = 5
    },
    order = "a-b-a",
  },
})

-- add prerequisites on the technology
addPrerequisiteTechnology("automation", "basic-automation")
addPrerequisiteTechnology("logistics", "basic-automation")
--addPrerequisiteTechnology("stack-inserter", "basic-automation")



--------------------------------------------------------------------------------
----- Basic automation science pack                                        -----
--------------------------------------------------------------------------------
-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "basic-automation-science-research",
    icon = "__MoreScience__/graphics/science-symbol.png",
    icon_size = 2000,
    prerequisites = {
      "basic-science-research",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "basic-automation-science-fluid"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-automation-science-pack"
      },
    },
    unit =
    {
      count = 50,
      ingredients = {
        {"science-pack-1", 1},
        {"science-pack-2", 3},
      },
      time = 10
    },
    upgrade = false,
    order = "c-a"
  },
})

-- add prerequisites on the technology
addPrerequisiteTechnology("advanced-material-processing", "basic-automation-science-research")
addScienceIngredient("advanced-material-processing", 1, "basic-automation-science-pack")

addPrerequisiteTechnology("engine", "basic-automation-science-research")
addScienceIngredient("engine", 1, "basic-automation-science-pack")

addPrerequisiteTechnology("circuit-network", "basic-automation-science-research")
addScienceIngredient("circuit-network", 1, "basic-automation-science-pack")

addPrerequisiteTechnology("oil-processing", "basic-automation-science-research")
addScienceIngredient("oil-processing", 1, "basic-automation-science-pack")
addScienceIngredient("plastics", 1, "basic-automation-science-pack")
addScienceIngredient("advanced-electronics", 1, "basic-automation-science-pack")
addScienceIngredient("sulfur-processing", 1, "basic-automation-science-pack")
addScienceIngredient("battery", 1, "basic-automation-science-pack")
