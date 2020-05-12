
for fluidName,fluidNameHP in pairs(CF_compressedFluidNames) do
  local fluid   = data.raw.fluid[fluidName]
  local fluidHP = data.raw.fluid[fluidNameHP]

  if not fluid then -- fluid was removed, remove HP as well
    fluidHP = nil
    CF_compressedFluidNames[fluidName] = nil

  elseif fluidHP then
    -- update icon
    fluidIcons = fluid.icons or {{icon=fluid.icon}}
    for _,iconLayer in pairs(fluidIcons or {}) do
      iconLayer.icon_size = iconLayer.icon_size or fluid.icon_size
    end
    fluidIconsHP = util.table.deepcopy(fluidIcons)
    table.insert(fluidIconsHP,  {
      icon = "__CompressedFluids__/graphics/icons/overlay-HP.png",
      icon_size = 32,
      tint = {r=0,g=1,b=0}
    })
    fluidHP.icons = util.table.deepcopy(fluidIconsHP)

    -- update localised name
    fluidHP.localised_name = {"fluid-name.compressed-fluid", fluid.localised_name or {"fluid-name."..fluid.name}}

  end
end