
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
          filename = "__BugZilla__/graphics/entity/biter/biter-run-1.png",
          width_in_frames = 8,
          height_in_frames = 16,
         },
         {
          filename = "__BugZilla__/graphics/entity/biter/biter-run-2.png",
          width_in_frames = 8,
          height_in_frames = 16,
         }
        }
        },

        {
        filename = "__BugZilla__/graphics/entity/biter/biter-run-mask1.png",
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
        filename = "__BugZilla__/graphics/entity/biter/biter-run-mask2.png",
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
        filename = "__BugZilla__/graphics/entity/biter/biter-attack-1.png",
        width_in_frames = 6,
        height_in_frames = 8,
       },
       {
        filename = "__BugZilla__/graphics/entity/biter/biter-attack-2.png",
        width_in_frames = 5,
        height_in_frames = 8,
       },
       {
        filename = "__BugZilla__/graphics/entity/biter/biter-attack-3.png",
        width_in_frames = 6,
        height_in_frames = 8,
       },
       {
        filename = "__BugZilla__/graphics/entity/biter/biter-attack-4.png",
        width_in_frames = 5,
        height_in_frames = 8,
       }
      }
      },

      {
      filename = "__BugZilla__/graphics/entity/biter/biter-attack-mask1.png",
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
      filename = "__BugZilla__/graphics/entity/biter/biter-attack-mask2.png",
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
        filename = "__BugZilla__/graphics/entity/biter/biter-die-1.png",
        width_in_frames = 9,
        height_in_frames = 8,
        },
        {
        filename = "__BugZilla__/graphics/entity/biter/biter-die-2.png",
        width_in_frames = 8,
        height_in_frames = 8,
        },
        {
        filename = "__BugZilla__/graphics/entity/biter/biter-die-3.png",
        width_in_frames = 9,
        height_in_frames = 8,
        },
        {
        filename = "__BugZilla__/graphics/entity/biter/biter-die-4.png",
        width_in_frames = 8,
        height_in_frames = 8,
        }
      }
      },

      {
      filename = "__BugZilla__/graphics/entity/biter/biter-die-mask1.png",
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
      filename = "__BugZilla__/graphics/entity/biter/biter-die-mask2.png",
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
end

--############################################################################--
--##########   Roar sounds                                          ##########--
--############################################################################--
local function make_roar_sound(type, volume)
  if type == "biter" then
    return
    {
      {
        filename = "__base__/sound/creatures/biter-roar-1.ogg",
        volume = volume
      },
      {
        filename = "__base__/sound/creatures/biter-roar-2.ogg",
        volume = volume
      },
      {
        filename = "__base__/sound/creatures/biter-roar-3.ogg",
        volume = volume
      },
      {
        filename = "__base__/sound/creatures/biter-roar-4.ogg",
        volume = volume
      },
      {
        filename = "__base__/sound/creatures/biter-roar-5.ogg",
        volume = volume
      },
      {
        filename = "__base__/sound/creatures/biter-roar-6.ogg",
        volume = volume
      }
    }
  end
end

--############################################################################--
--##########   Die sounds                                           ##########--
--############################################################################--
local function make_die_sound(type, volume)
  if type == "biter" or type == "scarab" then
    return
    {
      {
        filename = "__base__/sound/creatures/biter-death-1.ogg",
        volume = volume
      },
      {
        filename = "__base__/sound/creatures/biter-death-2.ogg",
        volume = volume
      },
      {
        filename = "__base__/sound/creatures/biter-death-3.ogg",
        volume = volume
      },
      {
        filename = "__base__/sound/creatures/biter-death-4.ogg",
        volume = volume
      },
      {
        filename = "__base__/sound/creatures/biter-death-5.ogg",
        volume = volume
      }
    }
  end
end

--############################################################################--
--##########   Call sounds                                          ##########--
--############################################################################--
local function make_call_sounds(volume)
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
--##########   Icons                                                 ##########--
--############################################################################--
local function make_icon(ico_app)
  return
  {
    {
      icon = "__BugZilla__/graphics/icons/"..ico_app.name..".png"
    }
  }
end

--############################################################################--
--##########   Projectiles                                          ##########--
--############################################################################--
local function make_projectile(pro_app, pro_dmg)
data:extend({
  {
    type = "beam",
    name = pro_app.name.."-"..pro_app.type.."-beam",
    flags = {"not-on-map"},
    width = 0.5,
    damage_interval = pro_dmg.cooldown,
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
            damage = { amount = pro_dmg.damage, type = "electric"}
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
    sound = make_roar_sound(data_app.type, volume),
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
      flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
      max_health = def_data.appearance.health,
      resistances = def_data.resistance,
      order = "b-b-Z",
      subgroup="enemies",
      healing_per_tick = def_data.appearance.healing,
      collision_box = {{-0.2*def_data.appearance.scale, -0.2*def_data.appearance.scale}, {0.2*def_data.appearance.scale, 0.2*def_data.appearance.scale}},
      selection_box = {{-0.4*def_data.appearance.scale, -0.7*def_data.appearance.scale}, {0.7*def_data.appearance.scale, 0.4*def_data.appearance.scale}},
      attack_parameters = make_attack_parameter(def_data.appearance, def_data.attack),
      vision_distance = 30,
      movement_speed = def_data.appearance.speed,
      distance_per_frame = 0.1,
      pollution_to_join_attack = 200,
      distraction_cooldown = 300,
      min_pursue_time = 10 * 60,
      max_pursue_distance = 50,
      corpse = def_data.appearance.name.."-corpse",
      dying_explosion = "blood-explosion-small",
      dying_sound =  make_die_sound(def_data.appearance.type, 0.4),
      working_sound =  make_call_sounds(0.3),
      run_animation = make_run_animation(def_data.appearance)
    },

    {
      type = "corpse",
      name = def_data.appearance.name.."-corpse",
      icon = "__BugZilla__/graphics/icons/"..def_data.appearance.name.."-corpse.png",
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
