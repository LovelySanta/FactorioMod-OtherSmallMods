require "util"

local function numberToString(number)
  if number >= 10 then return "" .. number else return "0" .. number end
end

local function alterSciencePack(oldName, newName, order, potionNumber)
  sciencePack = data.raw["tool"][oldName]

  sciencePack.icon = "__MoreScience__/graphics/potion/set-01/potion-" .. numberToString(potionNumber) .. ".png"
  sciencePack.icon_size = 32

  sciencePack.subgroup = "science-pack"

  sciencePack.order = "z-MoreScience-" .. order .. "[" .. newName .. "]"

  data.raw["tool"][oldName] = util.table.deepcopy(sciencePack)
end

local function addSciencePack(name, order, potionNumber)
  data:extend({
    {
      type = "tool",
      name = name,
      localised_description = {"item-description.science-pack"},
      icon = "__MoreScience__/graphics/potion/set-01/potion-" .. numberToString(potionNumber) .. ".png",
      icon_size = 32,
      flags = {"goes-to-main-inventory"},
      subgroup = "science-pack",
      order = "z-MoreScience-" .. order .. "[" .. name .. "]",
      stack_size = 200,
      durability = 1,
      durability_description_key = "description.science-pack-remaining-amount-key",
      durability_description_value = "description.science-pack-remaining-amount-value"
    },
  })
end



-- basic science pack-1
alterSciencePack("science-pack-1", "basic-science-pack-1", "a1", 14)
-- basic science pack-2
alterSciencePack("science-pack-2", "basic-science-pack-2", "a2", 3)
-- basic science pack 3
alterSciencePack("science-pack-3", "basic-science-pack-3", "a3", 8)

-- advanced science pack 1
alterSciencePack("production-science-pack", "advanced-science-pack-1", "b1", 10)
-- advanced science pack 2
alterSciencePack("high-tech-science-pack", "advanced-science-pack-2", "b2", 2)

-- extreme science pack
alterSciencePack("space-science-pack", "extreme-science-pack", "d", 1)

-- military science pack 1
alterSciencePack("military-science-pack", "military-science-pack-1", "c1", 9)
-- automation science pack
addSciencePack("basic-automation-science-pack", "c2", 15)
-- power science pack
addSciencePack("basic-power-science-pack", "c3", 5)
-- logistics science pack
addSciencePack("basic-logistics-science-pack", "c4", 13)
