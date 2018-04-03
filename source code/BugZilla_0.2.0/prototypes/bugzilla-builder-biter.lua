
if not BugzillaBuilder then
  BugzillaBuilder = {}
end

if not BugzillaBuilder.biter then
  BugzillaBuilder.biter = {}
end


--############################################################################--
--##########   Run animations                                       ##########--
--############################################################################--
function BugzillaBuilder.biter:make_run_animation(data_run)
  return
  {
    layers=
    {
      {
        width = 169,
        height = 114,
        frame_count = 16,
        direction_count = 16,
        shift = {data_run.scale * 0.714844, data_run.scale * -0.246094},
        scale = data_run.scale,
        stripes =
        {
          {
            filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-1.png",
            width_in_frames = 8,
            height_in_frames = 16,
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-2.png",
            width_in_frames = 8,
            height_in_frames = 16,
          }
        }
      },

      {
        filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-mask1.png",
        flags = { "mask" },
        width = 105,
        height = 81,
        frame_count = 16,
        direction_count = 16,
        shift = {data_run.scale * 0.117188, data_run.scale * -0.867188},
        scale = data_run.scale,
        tint = data_run.tint1
      },

      {
        filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-mask2.png",
        flags = { "mask" },
        line_length = 16,
        width = 95,
        height = 81,
        frame_count = 16,
        direction_count = 16,
        shift = {data_run.scale * 0.117188, data_run.scale * -0.855469},
        scale = data_run.scale,
        tint = data_run.tint2
      }
    }
  }
end



--############################################################################--
--##########   Attack animations                                    ##########--
--############################################################################--
function BugzillaBuilder.biter:make_attack_animation(data_attack)
  return
  {
    layers=
    {
      {
        width = 279,
        height = 184,
        frame_count = 11,
        direction_count = 16,
        shift = {data_attack.scale * 1.74609, data_attack.scale * -0.644531},
        animation_speed = 0.3,
        scale = data_attack.scale,
        stripes =
        {
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-1.png",
            width_in_frames = 6,
            height_in_frames = 8,
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-2.png",
            width_in_frames = 5,
            height_in_frames = 8,
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-3.png",
            width_in_frames = 6,
            height_in_frames = 8,
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-4.png",
            width_in_frames = 5,
            height_in_frames = 8,
          }
        }
      },

      {
        filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-mask1.png",
        flags = { "mask" },
        width = 125,
        height = 108,
        frame_count = 11,
        direction_count = 16,
        shift = {data_attack.scale * 0.117188, data_attack.scale * -1.11328},
        scale = data_attack.scale,
        tint = data_attack.tint1,
      },

      {
        filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-mask2.png",
        flags = { "mask" },
        width = 114,
        height = 100,
        frame_count = 11,
        direction_count = 16,
        shift = {data_attack.scale * 0.117188, data_attack.scale * -1.06641},
        scale = data_attack.scale,
        tint = data_attack.tint2
      }
    }
  }
end



--############################################################################--
--##########   Die animations                                       ##########--
--############################################################################--
function BugzillaBuilder.biter:make_die_animation(data_die)
  return
  {
    layers=
    {
      {
        width = 190,
        height = 129,
        frame_count = 17,
        direction_count = 16,
        shift = {data_die.scale * 0.621094, data_die.scale * -0.1875},
        scale = data_die.scale,
        stripes =
        {
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-1.png",
            width_in_frames = 9,
            height_in_frames = 8,
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-2.png",
            width_in_frames = 8,
            height_in_frames = 8,
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-3.png",
            width_in_frames = 9,
            height_in_frames = 8,
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-4.png",
            width_in_frames = 8,
            height_in_frames = 8,
          }
        }
      },

      {
        filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-mask1.png",
        flags = { "mask" },
        width = 120,
        height = 109,
        frame_count = 17,
        direction_count = 16,
        shift = {data_die.scale * 0.117188, data_die.scale * -0.574219},
        scale = data_die.scale,
        tint = data_die.tint1
      },

      {
        filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-mask2.png",
        flags = { "mask" },
        width = 115,
        height = 108,
        frame_count = 17,
        direction_count = 16,
        shift = {data_die.scale * 0.128906, data_die.scale * -0.585938},
        scale = data_die.scale,
        tint = data_die.tint2
      }
    }
  }
end



--############################################################################--
--##########   Roar sounds                                          ##########--
--############################################################################--
function BugzillaBuilder.biter:make_roar_sound(data_app, volume)
  return
  {
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-roar-1.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-roar-2.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-roar-3.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-roar-4.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-roar-5.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-roar-6.ogg",
      volume = volume
    }
  }
end



--############################################################################--
--##########   Die sounds                                           ##########--
--############################################################################--
function BugzillaBuilder.biter:make_die_sound(data_app, volume)
  return
  {
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-death-1.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-death-2.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-death-3.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-death-4.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-death-5.ogg",
      volume = volume
    }
  }
end



--############################################################################--
--##########   Call sounds                                          ##########--
--############################################################################--
function BugzillaBuilder.biter:make_call_sounds(data_app, volume)
  return
  {
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-call-1.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-call-2.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-call-3.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-call-4.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-call-5.ogg",
      volume = volume
    }
  }
end



--############################################################################--
--##########   Attack parameters                                    ##########--
--############################################################################--
function BugzillaBuilder.biter:make_attack_parameter(data_app, data_dmg)
  data_dmg.ammo =
  {
    category = "melee",
    target_type = "entity",
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "damage",
          damage = { amount = data_dmg.damage, type = "physical"}
        },
      }
    }
  }

  return
  {
    type = "projectile",
    ammo_category = data_dmg.category,
    cooldown = data_dmg.cooldown,
    range = .5*data_app.scale + data_dmg.range,
    min_attack_distance = data_dmg.min_attack_distance,
    projectile_creation_distance = data_dmg.creation_distance,
    damage_modifier = data_dmg.damage_modifier,
    warmup = data_dmg.warmup,
    ammo_type = data_dmg.ammo,
    sound = self:make_roar_sound(data_app, data_dmg.volume),
    animation = self:make_attack_animation(data_app),
  }
end
