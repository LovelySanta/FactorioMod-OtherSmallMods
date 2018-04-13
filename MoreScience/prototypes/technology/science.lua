require "lib/utilities/prototyping"

--------------------------------------------------------------------------------
----- Basic science pack 2                                                 -----
--------------------------------------------------------------------------------
-- disable the recipe
data.raw["recipe"]["science-pack-2"].enabled = false

-- remove recipe unlock from other technologies
removeRecipeUnlock("oil-processing", "chemical-plant")

-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "basic-science-research",
    icon = "__MoreScience__/graphics/science-symbol.png",
    icon_size = 2000,
    prerequisites = {
      "automation-2",
      "logistics",
      "steel-processing",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "basic-science-fluid-1"
      },
      {
        type = "unlock-recipe",
        recipe = "basic-science-fluid-2"
      },
      {
        type = "unlock-recipe",
        recipe = "science-pack-2"
      },
      {
        type = "unlock-recipe",
        recipe = "chemical-plant"
      },
    },
    unit =
    {
      count = 30,
      ingredients = {
        {"science-pack-1", 2},
      },
      time = 5
    },
    upgrade = false,
    order = "c-a"
  },
})
-- add prerequisites on the technology
removePrerequisiteTechnology("electric-energy-distribution-1", "electronics")
removePrerequisiteTechnology("electric-energy-distribution-1", "steel-processing")
addPrerequisiteTechnology("electric-energy-distribution-1", "basic-science-research")



--------------------------------------------------------------------------------
----- Basic science pack 2 - bottling                                      -----
--------------------------------------------------------------------------------
data:extend({
  {
    type = "technology",
    name = "bottling-research",
    icon = "__MoreScience__/graphics/science-symbol.png",
    icon_size = 2000,
    prerequisites = {
      "basic-science-research",
      "fluid-handling",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "purified-water"
      },
      {
        type = "unlock-recipe",
        recipe = "glass"
      },
      {
        type = "unlock-recipe",
        recipe = "cork"
      },
      {
        type = "unlock-recipe",
        recipe = "empty-bottle"
      },
    },
    unit =
    {
      count = 30,
      ingredients = {
        {"science-pack-1", 2},
      },
      time = 5
    },
    upgrade = false,
    order = "c-a"
  },
})
-- Fix research tree for bottling-research
removePrerequisiteTechnology("research-speed-1", "electronics")
addPrerequisiteTechnology("research-speed-1", "bottling-research")
