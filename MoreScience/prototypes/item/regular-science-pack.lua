require "util"

local function alterSciencePack(oldName, newName, order, potionNumber)
  local function numberToString(number)
    if number >= 10 then return "" .. number else return "0" .. number end
  end

  sciencePack = data.raw["tool"][oldName]

  sciencePack.icon = "__MoreScience__/graphics/potions/potion-" .. numberToString(potionNumber) .. ".png"
  sciencePack.icon_size = 32

  sciencePack.order = "z-MoreScience-" .. order .. "[" .. newName .. "]"

  data.raw["tool"][oldName] = util.table.deepcopy(sciencePack)
end



-- basic science pack-1
alterSciencePack("science-pack-1", "basic-science-pack-1", "b1", 14)
-- basic science pack-2
alterSciencePack("science-pack-2", "basic-science-pack-2", "b2", 3)
-- basic science pack 3
alterSciencePack("science-pack-3", "basic-science-pack-3", "b3", 8)

-- advanced science pack 1
alterSciencePack("production-science-pack", "advanced-science-pack-1", "c1", 10)
-- advanced science pack 2
alterSciencePack("high-tech-science-pack", "advanced-science-pack-2", "c2", 2)

-- extreme science pack
alterSciencePack("space-science-pack", "extreme-science-pack", "e", 1)

-- military science pack 1
alterSciencePack("military-science-pack", "military-science-pack-1", "d1", 9)
