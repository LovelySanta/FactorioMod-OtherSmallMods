require 'lib/utilities/generic'

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
      health = 100000, --100000
      healing = 0.01,
      speed = 0.2,
      has_belt_immunity = true,
    },
    attack = {
      category = "melee",
      range = 0,
      cooldown = 18,
      min_attack_distance = nil,
      creation_distance = nil,
      damage_modifier = nil,
      warmup = nil,
      projectile = nil,
      damage = 550,
      damage_radius = nil,
      volume = .8,
    },
    resistance = {
      {type = "physical", decrease = 8, percent = 75},
      {type = "fire", decrease = 25, percent = 75},
      {type = "explosion", decrease = 20, percent = 75},
      {type = "laser", decrease = 15, percent = 75},
      {type = "toxic-gas", decrease = 100, percent = 100}
    },
    graphics = {
      walk_distance_per_frame = .1,
      dying_explosion = 'small',
    },
  }


  --############################################################################--
  --##########   BugZilla Spitter                                       ##########--
  --############################################################################--
  bugzilla_spitter =
    {
      appearance = {
        type = "spitter",
        name = "bugzilla-spitter",
        scale = 5,
        tint1 = {r=0.3, g=0.9, b=0.3, a=0.75},
        --tint2 = {r=0.3, g=0.9, b=0.3, a=0.75},
        health = 200000, --200000
        healing = 0.02,
        speed = 0.175,
        has_belt_immunity = true,
      },
      attack = {
        category = "rocket",
        range=13, -- 16
        cooldown=100,
        min_attack_distance=10,
        creation_distance = 1.9,
        damage_modifier=5,
        warmup = 30,
        projectile = "bugzilla-spitter-projectile",
        damage = 50, -- 100
        damage_radius = 6.5,
        volume = .8,
      },
      resistance = DeepCopy(bugzilla_biter.resistance),
      graphics = {
        walk_distance_per_frame = .084,
        dying_explosion = 'big',
      },
    }
