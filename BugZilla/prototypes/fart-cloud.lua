local fart_duration = 60 * 5 -- in ticks
local fart_damage = 30 -- each interval
local fart_damage_interval = 30 -- in ticks
local fart_range = 6 -- radius


--############################################################################--
--##### Fart Cloud                                                       #####--
--############################################################################--
data:extend({
  {
    type = "damage-type",
    name = "toxic-gas"
  },


  {
    type = "smoke-with-trigger",
    name = "fart-cloud",
    flags = {"not-on-map", "placeable-off-grid"},
    show_when_smoke_off = true,
    animation =
    {
      filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
      flags = { "compressed" },
      priority = "low",
      width = 256,
      height = 256,
      frame_count = 45,
      animation_speed = 0.5,
      line_length = 7,
      scale = 3,
    },
    slow_down_factor = 0,
    affected_by_wind = false,
    cyclic = true,
    duration = fart_duration,
    fade_away_duration = 2 * 60,
    spread_duration = 10,
    color = { r = 0.6, g = 0.298, b = 0.0, a = 0.5},
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "nested-result",
          action =
          {
            type = "area",
            radius = fart_range,
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = { amount = fart_damage, type = "toxic-gas"}
              }
            }
          }
        }
      }
    },
    action_cooldown = fart_damage_interval,
  },



  {
    type = "explosion",
    name = "fart-sound",
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__core__/graphics/empty.png",
        priority = "extra-high",
        width = 1,
        height = 1,
        frame_count = 1,
        line_length = 1,
        animation_speed = 1
      },
    },
    light = {intensity = 0, size = 0},
    sound =
    {
      {
        filename = "__BugZilla__/sounds/fart1.ogg",
        volume = 1.5
      }
    }
  },


  {
    type = "projectile",
    name = "fart",
    flags = {"not-on-map"},
    acceleration = 0,
    direction_only = false,
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
                type = "create-entity",
                entity_name = "fart-sound"
              },
              {
                type = "create-entity",
                entity_name = "fart-cloud"
              },
          }
        }
      }
    },
    animation =
    {
      filename = "__core__/graphics/empty.png",
      priority = "high",
      width = 1,
      height = 1,
      frame_count = 1,
      line_length = 1,
      animation_speed = 1
    },
  }
})


--############################################################################--
--##### Pile of Poop                                                     #####--
--############################################################################--
require ("prototypes/bugzilla-entities")

local scale = 1./6
local graphic =
  {
    filename = "__BugZilla__/graphics/entity/pile-of-poop.png",
    run_mode = "forward-then-backward",
    line_length = 1,
    width = 500,
    height = 500,
    frame_count = 1,
    shift = {-.375, .25},
    direction_count = 1,
    scale = scale
  }
local dieSound =
  {
    {
      filename = "__BugZilla__/sounds/fart1.ogg",
      volume = 1.5
    }
  }
local silenceSound =
{
  {
    filename = "__BugZilla__/sounds/fart1.ogg",
    volume = 0
  }
}


data:extend({
  {
    type = "turret",
    name = "pile-of-poop",
    icon = graphic.filename,
    icon_size = (graphic.width + graphic.height) /2,
    flags = {"placeable-enemy", "not-repairable"},
    order="b-b-e",
    -- subgroup="enemies",
    max_health = bugzilla_biter.appearance.health * 10,
    resistances = bugzilla_biter.resistance,
    healing_per_tick = 0,
    collision_box = {{-1.6, -1.0}, {0.6, 1.0}},
    selection_box = {{-1.6, -1.0}, {0.6, 1.0}},
    shooting_cursor_size = .5,
    rotation_speed = 1,

    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    dying_sound = dieSound,

    folded_speed = 60,
    folded_animation = graphic,

    prepare_range = 0,
    preparing_speed = 60,
    preparing_animation = graphic,

    prepared_speed = 60,
    prepared_animation = graphic,

    starting_attack_speed = 60,
    starting_attack_animation = graphic,
    starting_attack_sound = silenceSound,

    ending_attack_speed = 60,
    ending_attack_animation = graphic,

    folding_speed = 60,
    folding_animation = graphic,

    attack_parameters =
    {
      type = "projectile",
      ammo_category = "rocket",
      cooldown = 60,
      range = 0,
      projectile_creation_distance = 1.9,
      damage_modifier = 4,
      ammo_type =
      {
        category = "biological",
        action =
        {
          type = "direct",
          action_delivery =
          {
            type = "projectile",
            projectile = "acid-projectile-purple",
            starting_speed = 0.5,
            max_range = 40
          }
        }
      }
    },

    build_base_evolution_requirement = 0,
    autoplace = enemy_worm_autoplace(0),
    call_for_help_radius = 0,
  },
})
