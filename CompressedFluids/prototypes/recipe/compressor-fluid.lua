local compressionRate = settings.startup["fluid-compression-rate"].value
local compressionSpeed = settings.startup["fluid-compression-speed"].value

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
          {type="fluid", name=fluidName, amount=compressionRate*compressionSpeed}
        },
        results =
        {
          {type="fluid", name="high-pressure-"..fluidName, amount=compressionSpeed}
        }
      },

      {
        type = "recipe",
        name = "decompressing-"..fluidName,
        hidden = true,
        hide_from_stats = true,
        enabled = true,
        category = "fluid-decompressing",
        energy_required = .1,
        ingredients =
        {
          {type="fluid", name="high-pressure-"..fluidName, amount=compressionSpeed}
        },
        results =
        {
          {type="fluid", name=fluidName, amount=compressionRate*compressionSpeed}
        }
      },
    }
  end
end
