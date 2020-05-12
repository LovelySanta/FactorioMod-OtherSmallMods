CF_compressedFluidNames = {}

for fluidName,fluidPrototype in pairs(util.table.deepcopy(data.raw.fluid)) do
  -- If the fluid is barrelable, we create the HP fluid
  if (fluidPrototype.auto_barrel == nil) or (fluidPrototype.auto_barrel == "true") or (fluidPrototype.auto_barrel == true) then
    fluidPrototype.auto_barrel = false

    -- name
    fluidPrototype.name = "high-pressure-"..fluidName
    CF_compressedFluidNames[fluidName] = fluidPrototype.name
    
    fluidPrototype.localised_name = {"fluid-name.compressed-fluid", fluidPrototype.localised_name or {"fluid-name."..fluidName}}

    -- icon
    if fluidPrototype.icon and (not fluidPrototype.icons) then
      fluidPrototype.icons = {{icon = fluidPrototype.icon}}
    end
    fluidPrototype.icon = nil
    if fluidPrototype.icon_size and fluidPrototype.icons and fluidPrototype.icons[1] and (not fluidPrototype.icons.icon_size) then
      for k,_ in pairs(fluidPrototype.icons) do
        fluidPrototype.icons[k].icon_size = fluidPrototype.icon_size
      end
    end
    fluidPrototype.icon_size = nil

    table.insert(fluidPrototype.icons,  {
      icon = "__CompressedFluids__/graphics/icons/overlay-HP.png",
      icon_size = 32,
      tint = {r=0,g=1,b=0}
    })

    -- Fluid properties
    fluidPrototype.fuel_value = nil
    fluidPrototype.max_temperature = fluidPrototype.default_temperature

    -- Move compressed fluids to a new group and create subgroup for it
    fluidPrototype.subgroup = fluidPrototype.subgroup or "fluid-recipes" -- make sure it has a subgroup
    fluidPrototype.order = fluidPrototype.order or "zzz"                 -- make sure it has an order string
    -- If our subgroup is nil, insert a raw table
    local itemSubgroup = data.raw["item-subgroup"][fluidPrototype.subgroup] or {}
    if not data.raw["item-subgroup"]["compressed-fluids["..(itemSubgroup.group or "").."]"] then
      data:extend{
        {
          type = "item-subgroup",
          name = "compressed-fluids["..itemSubgroup.group.."]",
          group = "compressed-fluids",
          order = data.raw["item-group"][itemSubgroup.group].order
        }
      }
    end

    fluidPrototype.order = (itemSubgroup.order or "").."["..fluidPrototype.subgroup.."]-"..fluidPrototype.order
    fluidPrototype.subgroup = "compressed-fluids["..(itemSubgroup.group or "").."]"

    fluidPrototype.flags = fluidPrototype.flags or {}
    table.insert(fluidPrototype.flags, "hidden")

    data:extend{fluidPrototype}
  end
end
