require "util"

local function addSciencePack(newPotionName, oldPotionName, potionNumber)
  local function numberToString(number)
    if number >= 10 then return "" .. number else return "0" .. number end
  end

  data:extend({
    {
      type = "tool",
      name = newPotionName,
      localised_name = {"item-name.infused-modifier", {[1] = "item-name." .. oldPotionName}},
      localised_description = {"item-description.science-pack"},
      icon = "__MoreScience__/graphics/icons/potion/set-02/potion-" .. numberToString(potionNumber) .. ".png",
      icon_size = 32,
      flags = {"goes-to-main-inventory"},
      subgroup = "infused-science-pack",
      order = "z-MoreScience-" .. stringSplit(stringSplit(data.raw["tool"][oldPotionName].order,"-")[3], "[")[1] .. "[" .. newPotionName .. "]",
      stack_size = 100,
      durability = 1,
      durability_description_key = "description.science-pack-remaining-amount-key",
      durability_description_value = "description.science-pack-remaining-amount-value"
    },
  })
end

-- infused basic science pack-1
addSciencePack("infused-basic-science-pack-1", "science-pack-1", 14)
-- infused basic science pack-2
addSciencePack("infused-basic-science-pack-2", "science-pack-2", 3)
-- infused basic science pack 3
addSciencePack("infused-basic-science-pack-3", "science-pack-3", 8)

-- infused advanced science pack 1
addSciencePack("infused-advanced-science-pack-1", "production-science-pack", 10)
-- infused advanced science pack 2
addSciencePack("infused-advanced-science-pack-2", "high-tech-science-pack", 2)

-- infused extreme science pack
addSciencePack("infused-extreme-science-pack", "space-science-pack", 1)

-- infused military science pack 1
addSciencePack("infused-basic-military-science-pack", "military-science-pack", 9)
-- infused automation science pack
addSciencePack("infused-basic-automation-science-pack", "basic-automation-science-pack", 15)
-- infused power science pack
addSciencePack("infused-basic-power-science-pack", "basic-power-science-pack", 5)
-- infused logistics science pack
addSciencePack("infused-basic-logistics-science-pack", "basic-logistics-science-pack", 13)
