local compressionRate = settings.startup["fluid-compression-rate"].value
local compressionSpeed = settings.startup["fluid-compression-speed"].value

local manualCompressionRecipes = settings.startup["fluid-compressor-manual-recipes"].value
local hideCompressionRecipes = manualCompressionRecipes and settings.startup["fluid-compressor-hide-recipes"].value

for fluidName,fluidPrototype in pairs(data.raw.fluid) do
  if (fluidPrototype.auto_barrel == nil) or (fluidPrototype.auto_barrel == "true") or (fluidPrototype.auto_barrel == true) then
    data:extend{
      {
        type = "recipe",
        name = "compressing-"..fluidName,
        hide_from_stats = true,
        enabled = true,
        category = "fluid-compressing",
        hidden = not manualCompressionRecipes,
        hide_from_player_crafting = hideCompressionRecipes,
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
        hide_from_stats = true,
        enabled = true,
        category = "fluid-decompressing",
        hidden = not manualCompressionRecipes,
        hide_from_player_crafting = hideCompressionRecipes,
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
