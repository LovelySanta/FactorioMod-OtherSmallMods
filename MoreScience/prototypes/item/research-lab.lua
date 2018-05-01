
data.raw["item"]["lab"].subgroup = "science-bottling"

local labMK2 = util.table.deepcopy(data.raw["item"]["lab"])
labMK2.name = "lab-mk2"
labMK2.localised_name = {"item-name.lab-mk2", {[1] = "item-name.lab"}}
labMK2.order = labMK2.order .. "2"
labMK2.place_result = "lab-mk2",
data:extend({labMK2})
