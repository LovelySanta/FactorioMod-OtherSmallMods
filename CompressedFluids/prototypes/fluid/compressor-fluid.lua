
for fluidName,fluidPrototype in pairs(util.table.deepcopy(data.raw.fluid)) do
  if (fluidPrototype.auto_barrel == nil) or (fluidPrototype.auto_barrel == "true") or (fluidPrototype.auto_barrel == true) then
    fluidPrototype.auto_barrel = false

    fluidPrototype.name = "high-pressure-"..fluidName
    fluidPrototype.localised_name = {"fluid-name.compressed-fluid", {"fluid-name."..fluidName}}

    fluidPrototype.flags = fluidPrototype.flags or {}
    table.insert(fluidPrototype.flags, "hidden")

    data:extend{fluidPrototype}
  end
end
