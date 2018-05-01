require "util"

if data.raw["lab"]["lab"] then
  -- Add science packs
  table.remove(data.raw["lab"]["lab"].inputs, #data.raw["lab"]["lab"].inputs) -- space-science-pack
  table.insert(data.raw["lab"]["lab"].inputs, "basic-automation-science-pack")
  table.insert(data.raw["lab"]["lab"].inputs, "basic-power-science-pack")
  table.insert(data.raw["lab"]["lab"].inputs, "basic-logistics-science-pack")
  table.insert(data.raw["lab"]["lab"].inputs, "space-science-pack")
end

local labMK2 = util.table.deepcopy(data.raw["lab"]["lab"])
labMK2.name = "lab-mk2"
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
  labMK2,
})
