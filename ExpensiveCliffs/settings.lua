data:extend{
  {
    -- Fixed cliff settings
    type = "bool-setting",
    name = "EC-fixed-cliffs", -- in minutes
    setting_type = "startup",
    default_value = true,
    order = "EC-a[cliffs]-fixed",
  },
}
