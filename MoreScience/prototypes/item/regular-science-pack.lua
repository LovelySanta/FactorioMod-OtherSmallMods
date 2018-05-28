require "lib/utilities/util"
require "util"

local function numberToString(number)
  if number >= 10 then return "" .. number else return "0" .. number end
end

local function alterSciencePack(oldPotionName, newPotionName, fluidName, potionNumber)
  sciencePack = data.raw["tool"][oldPotionName]

  sciencePack.icon = "__MoreScience__/graphics/icons/potion/set-01/potion-" .. numberToString(potionNumber) .. ".png"
  sciencePack.icon_size = 32

  sciencePack.subgroup = "science-pack"

  sciencePack.order = "z-MoreScience-" .. stringSplit(stringSplit(data.raw["fluid"][fluidName].order,"-")[3], "[")[1] .. "[" .. newPotionName .. "]"

  data.raw["tool"][oldPotionName] = util.table.deepcopy(sciencePack)
end

local function addSciencePack(potionName, fluidName, potionNumber)
  data:extend({
    {
      type = "tool",
      name = potionName,
      localised_description = {"item-description.science-pack"},
      icon = "__MoreScience__/graphics/icons/potion/set-01/potion-" .. numberToString(potionNumber) .. ".png",
      icon_size = 32,
      flags = {"goes-to-main-inventory"},
      subgroup = "science-pack",
      order = "z-MoreScience-" .. stringSplit(stringSplit(data.raw["fluid"][fluidName].order,"-")[3], "[")[1] .. "[" .. potionName .. "]",
      stack_size = 200,
      durability = 1,
      durability_description_key = "description.science-pack-remaining-amount-key",
      durability_description_value = "description.science-pack-remaining-amount-value"
    },
  })
end



-- basic science pack-1
alterSciencePack("science-pack-1", "basic-science-pack-1", "basic-science-fluid-1", 14)
-- basic science pack-2
alterSciencePack("science-pack-2", "basic-science-pack-2", "basic-science-fluid-2", 3)
-- basic science pack 3
alterSciencePack("science-pack-3", "basic-science-pack-3", "basic-science-fluid-3", 8)

-- advanced science pack 1
alterSciencePack("production-science-pack", "advanced-science-pack-1", "advanced-science-fluid-1", 10)
-- advanced science pack 2
alterSciencePack("high-tech-science-pack", "advanced-science-pack-2", "advanced-science-fluid-2", 2)

-- extreme science pack
alterSciencePack("space-science-pack", "extreme-science-pack", "extreme-science-fluid", 1)

-- military science pack 1
alterSciencePack("military-science-pack", "military-science-pack-1", "basic-military-science-fluid", 9)
-- automation science pack
addSciencePack("basic-automation-science-pack", "basic-automation-science-fluid", 15)
-- power science pack
addSciencePack("basic-power-science-pack", "basic-power-science-fluid", 5)
-- logistics science pack
addSciencePack("basic-logistics-science-pack", "basic-logistics-science-fluid", 13)
