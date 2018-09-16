
for fluidName,fluidPrototype in pairs(util.table.deepcopy(data.raw.fluid)) do
  if (fluidPrototype.auto_barrel == nil) or (fluidPrototype.auto_barrel == "true") or (fluidPrototype.auto_barrel == true) then
    fluidPrototype.name = "high-pressure-"..fluidName
    fluidPrototype.localised_name = {"fluid-name.compressed-fluid", {"fluid-name."..fluidName}}
    fluidPrototype.auto_barrel = false
    data:extend{fluidPrototype}
  end
end
