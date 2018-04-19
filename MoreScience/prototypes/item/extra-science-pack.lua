
local function addSciencePack(name, order, potionNumber)
  local function numberToString(number)
    if number >= 10 then return "" .. number else return "0" .. number end
  end

  data:extend({
    {
      type = "tool",
      name = name,
      localised_description = {"item-description.science-pack"},
      icon = "__MoreScience__/graphics/potions/potion-" .. numberToString(potionNumber) .. ".png",
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

-- automation science pack
addSciencePack("basic-automation-science-pack", "d2", 15)
-- power science pack
addSciencePack("basic-power-science-pack", "d3", 5)
-- logistics science pack
addSciencePack("basic-logistics-science-pack", "d4", 13)
