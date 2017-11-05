

--############################################################################--
--##########   BugZilla Biter                                       ##########--
--############################################################################--
bugzilla_biter =
  {
    appearance = {
      type = "biter",
      name = "bugzilla-biter",
      scale = 5,
      tint1 = {r=0.3, g=0.9, b=0.3, a=0.75},
      tint2 = {r=0.88, g=0.24, b=0.24, a=0.9},
      speed = 0.17,
      health = 10000,
    },
    attack = {
      category = "melee",
      range = 0.5,
      cooldown = 35,
      min_attack_distance = nil,
      creation_distance = nil,
      damage_modifier = nil,
      warmup = nil,
      damage = 60,
    },
    resistance = {
      {type = "physical", decrease = 5, percent = 20},
      {type = "fire", decrease = 10, percent = 20},
      {type = "explosion", decrease = 20, percent = 10},
      {type = "laser", decrease = 10, percent = 25}
    }
  }
