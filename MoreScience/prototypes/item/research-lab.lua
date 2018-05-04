
data.raw["item"]["lab"].subgroup = "science-bottling"

--------------------------------------------------------------------------------
----- Burner lab                                                           -----
--------------------------------------------------------------------------------
local labBurner = util.table.deepcopy(data.raw["item"]["lab"])
labBurner.name = "lab-burner"
labBurner.localised_name = {"item-name.lab-burner", {[1] = "item-name.lab"}}
labBurner.order = labBurner.order .. "-mk0"
labBurner.place_result = "lab-burner"

--------------------------------------------------------------------------------
----- Lab MK2                                                              -----
--------------------------------------------------------------------------------
local labMK2 = util.table.deepcopy(data.raw["item"]["lab"])
labMK2.name = "lab-mk2"
labMK2.localised_name = {"item-name.lab-mk2", {[1] = "item-name.lab"}}
labMK2.order = labMK2.order .. "-mk2"
labMK2.place_result = "lab-mk2"

--------------------------------------------------------------------------------
----- Lab MK1 - base game lab                                              -----
--------------------------------------------------------------------------------
data.raw["item"]["lab"].localised_name = {"item-name.lab-mk1", {[1] = "item-name.lab"}}
data.raw["item"]["lab"].order = data.raw["item"]["lab"].order  .. "-mk1"



data:extend({
  labBurner,
  labMK2,
})
