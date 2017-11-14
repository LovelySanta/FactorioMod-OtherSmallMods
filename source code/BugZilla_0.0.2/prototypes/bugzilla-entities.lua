

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
      speed = 0.2,
      health = 100000,
	  healing = 0.01
    },
    attack = {
      category = "melee",
      range = 0,
      cooldown = 18,
      min_attack_distance = nil,
      creation_distance = nil,
      damage_modifier = nil,
      warmup = nil,
      damage = 550,
    },
    resistance = {
      {type = "physical", decrease = 5, percent = 75},
      {type = "fire", decrease = 25, percent = 75},
      {type = "explosion", decrease = 20, percent = 75},
      {type = "laser", decrease = 15, percent = 75}
    }
  }
