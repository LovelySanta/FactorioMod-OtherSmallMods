
--############################################################################--
--##########   Run animations                                       ##########--
--############################################################################--
local function make_run_animation(data_run)
  if data_run.type == "biter" then
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
  elseif data_run.type == "spitter" then
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
end

--############################################################################--
--##########   Attack animations                                    ##########--
--############################################################################--
local function make_attack_animation(data_attack)
  if data_attack.type == "biter" then
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
  elseif data_attack.type == "spitter" then
    return
    {
      layers =
      {
        {
          width = 199,
          height = 164,
          frame_count = 22,
          direction_count = 16,
          scale=data_attack.scale,
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
end

--############################################################################--
--##########   Die animations                                       ##########--
--############################################################################--
local function make_die_animation(data_die)
  if data_die.type == "biter" then
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
  elseif data_die.type == "spitter" then
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
end

--############################################################################--
--##########   Roar sounds                                          ##########--
--############################################################################--
local function make_roar_sound(data_app, volume)
  if data_app.type == "biter" then
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
  elseif data_app.type == "spitter" then
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
end

--############################################################################--
--##########   Die sounds                                           ##########--
--############################################################################--
local function make_die_sound(data_app, volume)
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
local function make_call_sounds(data_app, volume)
  if not data_app.type == "spitter" then
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
  else
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
end

--############################################################################--
--##########   Icons                                                 ##########--
--############################################################################--
local function make_icon(ico_app)
  return
  {
    {
      icon = "__BugZilla__/graphics/icons/"..ico_app.type.."/"..ico_app.name..".png"
    }
  }
end

--############################################################################--
--##########   Projectiles                                          ##########--
--############################################################################--
local function make_beam(beam_app, beam_dmg)
  data:extend({
    {
      type = "beam",
      name = beam_app.name.."-"..beam_app.type.."-beam",
      flags = {"not-on-map"},
      width = 0.5,
      damage_interval = beam_dmg.cooldown,
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "damage",
              damage = { amount = beam_dmg.damage, type = "electric"}
            }
          }
        }
      },
      head =
      {
        filename = "__base__/graphics/entity/beam/beam-head.png",
        line_length = 16,
        width = 45,
        height = 39,
        frame_count = 16,
        animation_speed = 0.5,
        blend_mode = "additive-soft",
      },
      tail =
      {
        filename = "__base__/graphics/entity/beam/beam-tail.png",
        line_length = 16,
        width = 45,
        height = 39,
        frame_count = 16,
        blend_mode = "additive-soft",
      },
      body =
      {
        {
          filename = "__base__/graphics/entity/beam/beam-body-1.png",
          line_length = 16,
          width = 45,
          height = 39,
          frame_count = 16,
          blend_mode = "additive-soft",
        },
        {
          filename = "__base__/graphics/entity/beam/beam-body-2.png",
          line_length = 16,
          width = 45,
          height = 39,
          frame_count = 16,
          blend_mode = "additive-soft",
        },
        {
          filename = "__base__/graphics/entity/beam/beam-body-3.png",
          line_length = 16,
          width = 45,
          height = 39,
          frame_count = 16,
          blend_mode = "additive-soft",
        },
        {
          filename = "__base__/graphics/entity/beam/beam-body-4.png",
          line_length = 16,
          width = 45,
          height = 39,
          frame_count = 16,
          blend_mode = "additive-soft",
        },
        {
          filename = "__base__/graphics/entity/beam/beam-body-5.png",
          line_length = 16,
          width = 45,
          height = 39,
          frame_count = 16,
          blend_mode = "additive-soft",
        },
        {
          filename = "__base__/graphics/entity/beam/beam-body-6.png",
          line_length = 16,
          width = 45,
          height = 39,
          frame_count = 16,
          blend_mode = "additive-soft",
        },
      },
      working_sound =
      {
        {
          filename = "__base__/sound/fight/electric-beam.ogg",
          volume = 0.7
        }
      }
    }
  })
end

local function make_projectile(pro_app, pro_dmg)
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

--############################################################################--
--##########   Attack parameters                                    ##########--
--############################################################################--
local function make_attack_parameter(data_app, data_dmg)
  if data_app.type == "biter" then
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
  elseif data_app.type == "spitter" then
    if data.raw["projectile"] and (not data.raw["projectile"][data_dmg.projectile]) then
      make_projectile(data_app, data_dmg)
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
  end

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
    sound = make_roar_sound(data_app, data_dmg.volume),
    animation = make_attack_animation(data_app),
  }
end

--############################################################################--
--##########   Make aliens                                          ##########--
--############################################################################--
if not BZ_bugzilla then BZ_bugzilla = {} end
if not BZ_bugzilla.functions then BZ_bugzilla.functions = {} end

function BZ_bugzilla.functions.make_alien(def_data)
  data:extend({
    {
      type = "unit",
      name = def_data.appearance.name,
      icons = make_icon(def_data.appearance),
      icon_size = 32,
      flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
      max_health = def_data.appearance.health,
      resistances = def_data.resistance,
      has_belt_immunity = def_data.appearance.has_belt_immunity,
      order = "b-b-Z",
      subgroup="enemies",
      healing_per_tick = def_data.appearance.healing,
      collision_box = {{-0.2*def_data.appearance.scale, -0.2*def_data.appearance.scale}, {0.2*def_data.appearance.scale, 0.2*def_data.appearance.scale}},
      selection_box = {{-0.4*def_data.appearance.scale, -0.7*def_data.appearance.scale}, {0.7*def_data.appearance.scale, 0.4*def_data.appearance.scale}},
      attack_parameters = make_attack_parameter(def_data.appearance, def_data.attack),
      vision_distance = 30,
      movement_speed = def_data.appearance.speed,
      distance_per_frame = def_data.graphics.walk_distance_per_frame,
      pollution_to_join_attack = 200,
      distraction_cooldown = 300,
      min_pursue_time = 10 * 60,
      max_pursue_distance = 50,
      corpse = def_data.appearance.name.."-corpse",
      dying_explosion = "blood-explosion-"..def_data.graphics.dying_explosion,
      dying_sound =  make_die_sound(def_data.appearance, 0.4),
      working_sound =  make_call_sounds(def_data.appearance, 0.3),
      run_animation = make_run_animation(def_data.appearance)
    },

    {
      type = "corpse",
      name = def_data.appearance.name.."-corpse",
      icon = "__BugZilla__/graphics/icons/"..def_data.appearance.type.."/"..def_data.appearance.name.."-corpse.png",
      icon_size = 32,
      selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
      selectable_in_game = false,
      subgroup="corpses",
      order = "c[corpse]-a[biter]-a[small]",
      flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
      dying_speed = 0.04,
      time_before_removed = 15 * 60 * 60,
      final_render_layer = "corpse",
      animation = make_die_animation(def_data.appearance)
    }
  })
end
