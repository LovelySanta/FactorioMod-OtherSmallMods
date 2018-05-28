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
local infusedSciencePrerequisite = {
  ["science-pack-1"] =
  {
    "infinite-science-research"
  },
  ["science-pack-2"] =
  {
    infusedScienceResearch["science-pack-1"]
  },
  ["science-pack-3"] =
  {
    infusedScienceResearch["science-pack-2"]
  },
  ["production-science-pack"] =
  {
    infusedScienceResearch["science-pack-3"]
  },
  ["high-tech-science-pack"] =
  {
    infusedScienceResearch["science-pack-3"]
  },
  ["space-science-pack"] =
  {
    infusedScienceResearch["production-science-pack"],
    infusedScienceResearch["high-tech-science-pack"],
  },
  ["military-science-pack"] =
  {
    infusedScienceResearch["science-pack-2"]
  },
  ["basic-automation-science-pack"] =
  {
    infusedScienceResearch["science-pack-2"]
  },
  ["basic-logistics-science-pack"] =
  {
    infusedScienceResearch["basic-power-science-pack"]
  },
  ["basic-power-science-pack"] =
  {
    infusedScienceResearch["basic-automation-science-pack"]
  },
}

local function addInfusedSciencePack(basicScienceName, order)
  data:extend({
    {
      type = "technology",
      name = util.table.deepcopy(infusedScienceResearch[basicScienceName]),
      localised_name = {"technology-name.infuse-research"},
      localised_description = {"technology-description.infuse-research"},
      icon = "__MoreScience__/graphics/technology/science-symbol.png",
      icon_size = 2000,
      prerequisites = util.table.deepcopy(infusedSciencePrerequisite[basicScienceName]),
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

local function changeToInfusedSciencePack(technologyName, prerequisitesToAdd)
  if data.raw["technology"][technologyName] then
    -- Update the science pack ingredients
    if data.raw["technology"][technologyName].unit then
      for index,ingredient in pairs(data.raw["technology"][technologyName].unit.ingredients) do
        if infusedSciencePackName[ingredient[1]] then
          data.raw["technology"][technologyName].unit.ingredients[index] = {infusedSciencePackName[ingredient[1]], ingredient[2]}
        end
      end
    end

    -- Add prerequisites
    if prerequisitesToAdd then
      for _,basicScienceName in pairs(prerequisitesToAdd) do
        addPrerequisiteTechnology(technologyName, infusedScienceResearch[basicScienceName])
      end
    end
  end
end


-- Worker robot
changeToInfusedSciencePack("worker-robots-speed-6", {"production-science-pack","high-tech-science-pack","basic-logistics-science-pack"})
-- Mining productivity
changeToInfusedSciencePack("mining-productivity-16", {"production-science-pack","high-tech-science-pack","basic-power-science-pack"})

-- Shells
changeToInfusedSciencePack("shotgun-shell-damage-7", {"military-science-pack","high-tech-science-pack","basic-automation-science-pack"})
changeToInfusedSciencePack("cannon-shell-damage-6", {"military-science-pack","high-tech-science-pack","basic-automation-science-pack"})
-- Grenade damgage
changeToInfusedSciencePack("grenade-damage-7", {"military-science-pack","production-science-pack","high-tech-science-pack"})
-- Rocket damgage
changeToInfusedSciencePack("rocket-damage-7", {"military-science-pack","high-tech-science-pack","basic-automation-science-pack"})
-- Combat robotics
changeToInfusedSciencePack("combat-robot-damage-6", {"military-science-pack","high-tech-science-pack","basic-automation-science-pack"})
changeToInfusedSciencePack("follower-robot-count-7", {"military-science-pack","production-science-pack","high-tech-science-pack"})

-- Gun turret
changeToInfusedSciencePack("bullet-damage-7", {"military-science-pack","high-tech-science-pack","basic-automation-science-pack"})
changeToInfusedSciencePack("gun-turret-damage-7", {"military-science-pack","high-tech-science-pack","basic-automation-science-pack"})
-- Flamethrower
changeToInfusedSciencePack("flamethrower-damage-7", {"military-science-pack","high-tech-science-pack","basic-automation-science-pack"})
-- Laser turret
changeToInfusedSciencePack("laser-turret-damage-8", {"military-science-pack","high-tech-science-pack","basic-power-science-pack"})
-- Artillery turret
changeToInfusedSciencePack("artillery-shell-range-1", {"military-science-pack","high-tech-science-pack","basic-automation-science-pack"})
changeToInfusedSciencePack("artillery-shell-speed-1", {"military-science-pack","high-tech-science-pack","basic-automation-science-pack"})
