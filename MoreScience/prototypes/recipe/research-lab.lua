require "util"

--------------------------------------------------------------------------------
----- Burner lab                                                              -----
--------------------------------------------------------------------------------
local labBurner = util.table.deepcopy(data.raw["recipe"]["lab"])
labBurner.name = "lab-burner"
for index,ingredient in pairs(labBurner.ingredients) do
  if ingredient[1] == "transport-belt" then
    table.remove(labBurner.ingredients, index)
    break
  end
end
table.insert(labBurner.ingredients, {"boiler", 1})
labBurner.result = "lab-burner"
labBurner.enabled = true

--------------------------------------------------------------------------------
----- Lab MK1                                                              -----
--------------------------------------------------------------------------------
data.raw["recipe"]["lab"].ingredients = {
  {"lab-burner", 1},
  {"transport-belt", 4}
}

--------------------------------------------------------------------------------
----- Lab MK2                                                              -----
--------------------------------------------------------------------------------
local labMK2 = util.table.deepcopy(data.raw["recipe"]["lab"])
labMK2.name = "lab-mk2"
labMK2.category = "crafting-with-fluid"
labMK2.energy_required = 120
labMK2.ingredients = {
  {"lab", 1},
  {"fusion-reactor-equipment", 1},
  {type="fluid", name="extreme-science-fluid", amount=250},
}
labMK2.result = "lab-mk2"
labMK2.enabled = false

data:extend({
  labBurner,
  labMK2,
})
