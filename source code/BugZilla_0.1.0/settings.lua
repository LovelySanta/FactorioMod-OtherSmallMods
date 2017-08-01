-- Settings for phaseCycler
data:extend{
  {
    -- Initial time to prepair before the first attack
    type = "int-setting",
    name = "BZ-initial-day-length", -- in minutes
    setting_type = "runtime-global",
    minimum_value = 1,
    default_value = 120,
    order = "BZ-a[phase-length]-c",
  },
  {
    -- Time between two attacks
    type = "int-setting",
    name = "BZ-day-length", -- in minutes
    setting_type = "runtime-global",
    minimum_value = 1,
    default_value = 15,
    order = "BZ-a[phase-length]-d",
  },
  {
    -- Time you have to kill BugZilla or that he has to destroy your base
    type = "int-setting",
    name = "BZ-night-length", -- in minutes
    setting_type = "runtime-global",
    minimum_value = 1,
    default_value = 5,
    order = "BZ-a[phase-length]-d",
  },
}
