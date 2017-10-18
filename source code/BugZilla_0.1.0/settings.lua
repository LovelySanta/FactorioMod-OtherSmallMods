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
  {
    -- Minimal range away from spawn bugzilla will spawn (in tiles)
    type = "int-setting",
    name = "BZ-min-spawn-range", -- in minutes
    setting_type = "runtime-global",
    minimum_value = 1,
    default_value = 500,
    order = "BZ-a[phase-length]-d",
  },
  {
    -- Maximal range away from spawn bugzilla will spawn (in tiles)
    type = "int-setting",
    name = "BZ-max-spawn-range", -- in minutes
    setting_type = "runtime-global",
    minimum_value = 1,
    default_value = 1000,
    order = "BZ-a[phase-length]-d",
  },
}