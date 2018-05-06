require "lib/utilities/prototyping"
require "util"

local infusedSciencePackName = {
  ["science-pack-1"] = "infused-basic-science-pack-1",
  ["science-pack-2"] = "infused-basic-science-pack-2",
  ["science-pack-3"] = "infused-basic-science-pack-3",
  ["production-science-pack"] = "infused-advanced-science-pack-1",
  ["high-tech-science-pack"] = "infused-advanced-science-pack-2",
  ["space-science-pack"] = "infused-extreme-science-pack",
  ["military-science-pack"] = "infused-basic-military-science-pack",
  ["basic-automation-science-pack"] = "infused-basic-automation-science-pack",
  ["basic-logistics-science-pack"] = "infused-basic-logistics-science-pack",
  ["basic-power-science-pack"] = "infused-basic-power-science-pack",
}
local infusedScienceResearch = {
  ["science-pack-1"] = "infused-basic-science-research-1",
  ["science-pack-2"] = "infused-basic-science-research-2",
  ["science-pack-3"] = "infused-basic-science-research-3",
  ["production-science-pack"] = "infused-advanced-science-research-1",
  ["high-tech-science-pack"] = "infused-advanced-science-research-2",
  ["space-science-pack"] = "infinite-science-research",
  ["military-science-pack"] = "infused-basic-military-science-research",
  ["basic-automation-science-pack"] = "infused-basic-automation-science-research",
  ["basic-logistics-science-pack"] = "infused-basic-logistics-science-research",
  ["basic-power-science-pack"] = "infused-basic-power-science-research",
}

local function addInfusedSciencePack(basicScienceName, order)
  data:extend({
    {
      type = "technology",
      name = infusedScienceResearch[basicScienceName],
      localised_name = {"technology-name.infuse-research"},
      localised_description = {"technology-description.infuse-research"},
      icon = "__MoreScience__/graphics/science-symbol.png",
      icon_size = 2000,
      prerequisites =
      {
        "infinite-science-research",
      },
      effects = nil,
      unit =
      {
        count = 1000,
        ingredients =
        {
          {"space-science-pack", 1},
        },
        time = 60
      },
      upgrade = false,
      order = data.raw["technology"]["infinite-science-research"].order .. "-" .. order
    },
  })

  addScienceIngredient(infusedScienceResearch[basicScienceName], 2, basicScienceName)
  addRecipeUnlock(infusedScienceResearch[basicScienceName], infusedSciencePackName[basicScienceName])
end

addInfusedSciencePack("science-pack-1", "a1")
addInfusedSciencePack("science-pack-2", "a2")
addInfusedSciencePack("science-pack-3", "a3")
addInfusedSciencePack("production-science-pack", "b1")
addInfusedSciencePack("high-tech-science-pack", "b2")

addInfusedSciencePack("military-science-pack", "c1")
addInfusedSciencePack("basic-automation-science-pack", "c2")
addInfusedSciencePack("basic-power-science-pack", "c3")
addInfusedSciencePack("basic-logistics-science-pack", "c4")

--------------------------------------------------------------------------------
----- Infinite science research                                            -----
--------------------------------------------------------------------------------

local function changeToInfusedSciencePack(technologyName)
  if data.raw["technology"][technologyName] and data.raw["technology"][technologyName].unit then
    local ingredients = {}
    for index,ingredient in pairs(data.raw["technology"][technologyName].unit.ingredients) do
      if infusedSciencePackName[ingredient[1]] then
        -- Update the science pack
        data.raw["technology"][technologyName].unit.ingredients[index] = {infusedSciencePackName[ingredient[1]], ingredient[2]}

        -- Also add prerequisite
        if not (ingredient[1] == "space-science-pack") then
          addPrerequisiteTechnology(technologyName, infusedScienceResearch[ingredient[1]])
        end
      end
    end
  end
end


-- Worker robot
changeToInfusedSciencePack("worker-robots-speed-6")
-- Mining productivity
changeToInfusedSciencePack("mining-productivity-16")

-- Shells
changeToInfusedSciencePack("shotgun-shell-damage-7")
changeToInfusedSciencePack("cannon-shell-damage-6")
-- Grenade damgage
changeToInfusedSciencePack("grenade-damage-7")
-- Rocket damgage
changeToInfusedSciencePack("rocket-damage-7")
-- Combat robotics
changeToInfusedSciencePack("combat-robot-damage-6")
changeToInfusedSciencePack("follower-robot-count-7")

-- Gun turret
changeToInfusedSciencePack("bullet-damage-7")
changeToInfusedSciencePack("gun-turret-damage-7")
-- Flamethrower
changeToInfusedSciencePack("flamethrower-damage-7")
-- Laser turret
changeToInfusedSciencePack("laser-turret-damage-8")
-- Artillery turret
changeToInfusedSciencePack("artillery-shell-range-1")
changeToInfusedSciencePack("artillery-shell-speed-1")
