
if not BugzillaBuilder then
  BugzillaBuilder = {}
end

if not BugzillaBuilder.spitter then
  BugzillaBuilder.spitter = {}
end


--############################################################################--
--##########   Run animations                                       ##########--
--############################################################################--
function BugzillaBuilder.spitter:make_run_animation(data_run)
  return
  {
    layers =
    {
      {
        width = 193,
        height = 164,
        priority="very-low",
        frame_count = 24,
        direction_count = 16,
        shift = {data_run.scale * 1.01562, 0},
        scale = data_run.scale,
        still_frame = 4,
        stripes =
        {
          {
            filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-1.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-2.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-3.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-4.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-5.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-6.png",
            width_in_frames = 8,
            height_in_frames = 8
          }
        }
      },
      {
        width = 81,
        height = 90,
        frame_count = 24,
        direction_count = 16,
        shift = {data_run.scale * 0.015625, data_run.scale * -0.6875},
        scale = data_run.scale,
        filename = "__BugZilla__/graphics/entity/"..data_run.type.."/"..data_run.name.."-run-mask.png",
        flags = { "mask" },
        tint = data_run.tint1
      },
    }
  }
end



--############################################################################--
--##########   Attack animations                                    ##########--
--############################################################################--
function BugzillaBuilder.spitter:make_attack_animation(data_attack)
  return
  {
    layers =
    {
      {
        width = 199,
        height = 164,
        frame_count = 22,
        direction_count = 16,
        scale = data_attack.scale,
        shift = {data_attack.scale * 0.765625, data_attack.scale * 0.0625},
        animation_speed = 0.4,
        stripes =
        {
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-1.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-2.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-3.png",
            width_in_frames = 6,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-4.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-5.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-6.png",
            width_in_frames = 6,
            height_in_frames = 8
          }
        }
      },
      {
        flags = { "mask" },
        width = 108,
        height = 90,
        frame_count = 22,
        direction_count = 16,
        shift = {data_attack.scale * 0, data_attack.scale * -0.625},
        scale = data_attack.scale,
        tint = data_attack.tint1,
        animation_speed = 0.4,
        stripes =
        {
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-mask-1.png",
            width_in_frames = 11,
            height_in_frames = 16
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_attack.type.."/"..data_attack.name.."-attack-mask-2.png",
            width_in_frames = 11,
            height_in_frames = 16
          }
        }
      }
    }
  }
end



--############################################################################--
--##########   Die animations                                       ##########--
--############################################################################--
function BugzillaBuilder.spitter:make_die_animation(data_die)
  return
  {
    layers =
    {
      {
        width = 225,
        height = 174,
        frame_count = 16,
        direction_count = 16,
        shift = {data_die.scale * 0.546875, data_die.scale * 0.21875},
        priority = "very-low",
        scale = data_die.scale,
        stripes =
        {
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-1.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-2.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-3.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-4.png",
            width_in_frames = 8,
            height_in_frames = 8
          }
        }
      },
      {
        flags = { "mask" },
        width = 166,
        height = 144,
        frame_count = 16,
        direction_count = 16,
        shift = {data_die.scale * 0, data_die.scale * -0.0625},
        priority = "very-low",
        tint = data_die.tint1,
        scale = data_die.scale,
        stripes =
        {
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-mask-1.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-mask-2.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-mask-3.png",
            width_in_frames = 8,
            height_in_frames = 8
          },
          {
            filename = "__BugZilla__/graphics/entity/"..data_die.type.."/"..data_die.name.."-die-mask-4.png",
            width_in_frames = 8,
            height_in_frames = 8
          }
        }
      }
    }
  }
end



--############################################################################--
--##########   Roar sounds                                          ##########--
--############################################################################--
function BugzillaBuilder.spitter:make_roar_sound(data_app, volume)
  return
  {
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-1.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-2.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-3.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-4.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-5.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-6.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-7.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/"..data_app.type.."-8.ogg",
      volume = volume
    }
  }
end



--############################################################################--
--##########   Die sounds                                           ##########--
--############################################################################--
function BugzillaBuilder.spitter:make_die_sound(data_app, volume)
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
function BugzillaBuilder.spitter:make_call_sounds(data_app, volume)
  return
  {
    {
      filename = "__base__/sound/creatures/biter-call-1.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/biter-call-2.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/biter-call-3.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/biter-call-4.ogg",
      volume = volume
    },
    {
      filename = "__base__/sound/creatures/biter-call-5.ogg",
      volume = volume
    }
  }
end



--############################################################################--
--##########   Attack parameters                                    ##########--
--############################################################################--
function BugzillaBuilder.spitter:make_attack_parameter(data_app, data_dmg)
  if data.raw["projectile"] and (not data.raw["projectile"][data_dmg.projectile]) then
    self:make_projectile(data_app, data_dmg)
  end

  data_dmg.ammo =
  {
    category = "biological",
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "projectile",
        projectile = data_dmg.projectile,
        starting_speed = 0.5,
        max_range = data_dmg.range*2
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



--############################################################################--
--##########   Projectiles                                          ##########--
--############################################################################--
function BugzillaBuilder.spitter:make_projectile(pro_app, pro_dmg)
  data:extend({
    {
      type = "projectile",
      name = pro_dmg.projectile,
      flags = {"not-on-map"},
      acceleration = 0.005,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              {
                type = "play-sound",
                sound =
                {
                  {
                    filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
                    volume = 0.8
                  },
                  {
                    filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
                    volume = 0.8
                  },
                  {
                    filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
                    volume = 0.8
                  },
                  {
                    filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
                    volume = 0.8
                  }
                }
              },
              {
                type = "create-entity",
                entity_name = "medium-explosion"
              },
              {
                type = "create-entity",
                entity_name = "small-scorchmark",
                check_buildability = true
              }
            }
          }
        },
        {
          type = "area",
          radius = pro_dmg.damage_radius,
          action_delivery =
          {
            type = "instant",
            target_effects =
            {
              {
              type = "damage",
              damage = {amount = pro_dmg.damage, type = "explosion"}
              },
              {
              type = "create-entity",
              entity_name = "explosion"
              }
            }
          }
        }
      },
      light = {intensity = 0.5, size = 4},
      animation =
      {
        filename = "__base__/graphics/entity/grenade/grenade.png",
        frame_count = 1,
        width = 24,
        height = 24,
        priority = "high"
      },
      shadow =
      {
        filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
        frame_count = 1,
        width = 24,
        height = 24,
        priority = "high"
      }
    }
  })
end
