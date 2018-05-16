
if mods["MoreScience"] then
  log("Mod compatibility with MoreScience update")
  -- Remake all technology ingredients

  -- blue
  data.raw["technology"]["force-fields"].unit.ingredients = util.table.deepcopy(data.raw["technology"]["advanced-electronics"].unit.ingredients)
  data.raw["technology"]["force-field-gates"].unit.ingredients = util.table.deepcopy(data.raw["technology"]["force-fields"].unit.ingredients)
  -- green
  data.raw["technology"]["green-fields"].unit.ingredients = util.table.deepcopy(data.raw["technology"]["explosives"].unit.ingredients)
  data.raw["technology"]["green-field-gates"].unit.ingredients = util.table.deepcopy(data.raw["technology"]["green-fields"].unit.ingredients)
  -- purple
  data.raw["technology"]["purple-fields"].unit.ingredients = util.table.deepcopy(data.raw["technology"]["military-3"].unit.ingredients)
  data.raw["technology"]["purple-field-gates"].unit.ingredients = util.table.deepcopy(data.raw["technology"]["purple-fields"].unit.ingredients)
  -- red
  data.raw["technology"]["red-fields"].unit.ingredients = util.table.deepcopy(data.raw["technology"]["military-4"].unit.ingredients)
  data.raw["technology"]["red-field-gates"].unit.ingredients = util.table.deepcopy(data.raw["technology"]["red-fields"].unit.ingredients)
end
