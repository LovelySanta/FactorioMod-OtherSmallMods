local compressionRate = settings.startup["fluid-compression-rate"].value
local compressionSpeed = settings.startup["fluid-compression-speed"].value

local manualCompressionRecipes = settings.startup["fluid-compressor-manual-recipes"].value
local hideCompressionRecipes = manualCompressionRecipes and settings.startup["fluid-compressor-hide-recipes"].value

for fluidName,fluidNameHP in pairs(compressedFluids.internalData.compressedFluidNames) do

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
        {type="fluid", name=fluidNameHP, amount=compressionSpeed}
      },
      main_product = fluidNameHP,
      show_amount_in_title = false,
      always_show_products = true,
      allow_as_intermediate = false,
      allow_decomposition = false,
      subgroup = data.raw["fluid"][fluidNameHP].subgroup,
      order = data.raw["fluid"][fluidNameHP].order
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
        {type="fluid", name=fluidNameHP, amount=compressionSpeed}
      },
      results =
      {
        {type="fluid", name=fluidName, amount=compressionRate*compressionSpeed}
      },
      main_product = fluidName,
      show_amount_in_title = false,
      always_show_products = true,
      allow_as_intermediate = false,
      allow_decomposition = false,
      subgroup = "de"..data.raw["fluid"][fluidNameHP].subgroup,
      order = data.raw["fluid"][fluidNameHP].order
    }
  }

end
