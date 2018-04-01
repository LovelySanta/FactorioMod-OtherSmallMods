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
