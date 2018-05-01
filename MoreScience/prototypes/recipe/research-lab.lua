
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
  labMK2,
})
