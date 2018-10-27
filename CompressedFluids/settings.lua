data:extend{
  {
    type = "bool-setting",
    name = "fluid-compression-singeEntity",
    setting_type = "startup",
    default_value = false,
    order = "a",
  },
  {
    type = "int-setting",
    name = "fluid-compression-rate",
    setting_type = "startup",
    minimum_value = 2,
    maximum_value = 100,
    default_value = 10,
    order = "b",
  },
  {
    type = "int-setting",
    name = "fluid-compression-speed",
    setting_type = "startup",
    minimum_value = 1,
    maximum_value = 100,
    default_value = 10,
    order = "c",
  },
}
