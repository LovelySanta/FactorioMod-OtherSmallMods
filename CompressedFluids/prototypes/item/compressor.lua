data:extend{
  {
    type = "item",
    name = "fluid-compressor",
    icon = "__CompressedFluids__/graphics/icons/compressor.png",
    icon_size = 51,
    flags = {"goes-to-quickbar"},
    subgroup = data.raw["item"]["pump"].subgroup,
    order = data.raw["item"]["pump"].order.."a[fluid-compressor]",
    place_result = "fluid-compressor",
    stack_size = 10,
  },
}
