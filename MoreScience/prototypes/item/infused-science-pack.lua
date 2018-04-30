require "util"

local function addSciencePack(newScienceName, oldScienceName, order, potionNumber)
  local function numberToString(number)
    if number >= 10 then return "" .. number else return "0" .. number end
  end

  data:extend({
    {
      type = "tool",
      name = newScienceName,
      localised_name = {"item-name.infused-modifier", {[1] = "item-name." .. oldScienceName}},
      localised_description = {"item-description.science-pack"},
      icon = "__MoreScience__/graphics/potions/set-02/potion-" .. numberToString(potionNumber) .. ".png",
      icon_size = 32,
      flags = {"goes-to-main-inventory"},
      subgroup = "infused-science-pack",
      order = "z-MoreScience-" .. order .. "[" .. newScienceName .. "]",
      stack_size = 100,
      durability = 1,
      durability_description_key = "description.science-pack-remaining-amount-key",
      durability_description_value = "description.science-pack-remaining-amount-value"
    },
  })
end

-- infused basic science pack-1
addSciencePack("infused-basic-science-pack-1", "science-pack-1", "a1", 14)
-- infused basic science pack-2
addSciencePack("infused-basic-science-pack-2", "science-pack-2", "a2", 3)
-- infused basic science pack 3
addSciencePack("infused-basic-science-pack-3", "science-pack-3", "a3", 8)

-- infused advanced science pack 1
addSciencePack("infused-advanced-science-pack-1", "production-science-pack", "b1", 10)
-- infused advanced science pack 2
addSciencePack("infused-advanced-science-pack-2", "high-tech-science-pack", "b2", 2)

-- infused extreme science pack
addSciencePack("infused-extreme-science-pack", "space-science-pack", "d", 1)

-- infused military science pack 1
addSciencePack("infused-basic-military-science-pack", "military-science-pack", "c1", 9)
-- infused automation science pack
addSciencePack("infused-basic-automation-science-pack", "basic-automation-science-pack", "c2", 15)
-- infused power science pack
addSciencePack("infused-basic-power-science-pack", "basic-power-science-pack", "c3", 5)
-- infused logistics science pack
addSciencePack("infused-basic-logistics-science-pack", "basic-logistics-science-pack", "c4", 13)
