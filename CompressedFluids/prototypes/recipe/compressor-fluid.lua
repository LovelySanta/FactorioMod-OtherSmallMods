
for fluidName,fluidPrototype in pairs(data.raw.fluid) do
  if (fluidPrototype.auto_barrel == nil) or (fluidPrototype.auto_barrel == "true") or (fluidPrototype.auto_barrel == true) then
    data:extend{
      {
        type = "recipe",
        name = "compressing-"..fluidName,
        hidden = true,
        hide_from_stats = true,
        enabled = true,
        category = "fluid-compressing",
        energy_required = .1,
        ingredients =
        {
          {type="fluid", name=fluidName, amount=settings.startup["fluid-compression-rate"].value}
        },
        results =
        {
          {type="fluid", name="high-pressure-"..fluidName, amount=1}
        }
      },

      {
        type = "recipe",
        name = "decompressing-"..fluidName,
        hidden = true,
        hide_from_stats = true,
        enabled = true,
        category = "fluid-compressing",
        energy_required = .1,
        ingredients =
        {
          {type="fluid", name="high-pressure-"..fluidName, amount=1}
        },
        results =
        {
          {type="fluid", name=fluidName, amount=settings.startup["fluid-compression-rate"].value}
        }
      },
    }
  end
end
