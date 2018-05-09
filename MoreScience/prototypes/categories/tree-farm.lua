
data:extend(
{
  {
    type = "recipe-category",
    name = "seed-extractor",
  },
  {
    type = "recipe-category",
    name = "wood-plantation",
  },
  {
    type = "item-subgroup",
    name = "treefarm",
    group = "intermediate-products",
    order = data.raw["item-subgroup"]["raw-resource"].order .. "-z"
  },
})
