require "util"

--------------------------------------------------------------------------------
----- Basic lab                                                            -----
--------------------------------------------------------------------------------
if data.raw["lab"]["lab"] then
  -- Add science packs (in correct order)
  --for packIndex, packName in pairs(data.raw["lab"]["lab"].inputs) do
  --  if packName == "space-science-pack" then
  table.remove(data.raw["lab"]["lab"].inputs, #data.raw["lab"]["lab"].inputs)
  --    table.remove(data.raw["lab"]["lab"].inputs, packIndex)
  --  end
  --  break
  --end
  table.insert(data.raw["lab"]["lab"].inputs, "basic-automation-science-pack")
  table.insert(data.raw["lab"]["lab"].inputs, "basic-power-science-pack")
  table.insert(data.raw["lab"]["lab"].inputs, "basic-logistics-science-pack")
  table.insert(data.raw["lab"]["lab"].inputs, "space-science-pack")

  data.raw["lab"]["lab"].localised_name = {"item-name.lab-mk1", {[1] = "item-name.lab"}}
end

--------------------------------------------------------------------------------
----- Burner lab                                                           -----
--------------------------------------------------------------------------------
local labBurner = util.table.deepcopy(data.raw["lab"]["lab"])
labBurner.name = "lab-burner"
labBurner.localised_name = {"item-name.lab-burner", {[1] = "item-name.lab"}}
labBurner.energy_usage = "250kW"
labBurner.energy_source =
  {
    type = "burner",
    fuel_category = "chemical",
    effectivity = 1,
    fuel_inventory_size = 1,
    emissions = 0.1 / 3,
    smoke =
    {
      {
        name = "smoke",
        deviation = {0.1, 0.1},
        frequency = 3
      }
    }
  }
labBurner.module_specification.module_slots = 0

--------------------------------------------------------------------------------
----- Lab MK2                                                              -----
--------------------------------------------------------------------------------
local labMK2 = util.table.deepcopy(data.raw["lab"]["lab"])
labMK2.name = "lab-mk2"
labMK2.localised_name = {"item-name.lab-mk2", {[1] = "item-name.lab"}}
labMK2.inputs = {
  "infused-basic-science-pack-1",
  "infused-basic-science-pack-2",
  "infused-basic-science-pack-3",
  "infused-advanced-science-pack-1",
  "infused-advanced-science-pack-2",
  "infused-basic-military-science-pack",
  "infused-basic-automation-science-pack",
  "infused-basic-power-science-pack",
  "infused-basic-logistics-science-pack",
  "infused-extreme-science-pack",
}
labMK2.energy_usage = "250kW"
labMK2.module_specification.module_slots = 5



data:extend({
  labBurner,
  labMK2,
})
