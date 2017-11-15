local fart_duration = 60 * 5 -- in ticks
local fart_damage = 30 -- each interval
local fart_damage_interval = 30 -- in ticks
local fart_range = 6 -- radius

data:extend({
  {
    type = "damage-type",
    name = "toxic-gas"
  },
})

data:extend({
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
    color = { r = 0.6, g = 0.298, b = 0.0 },
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
            perimeter = fart_range,
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
    action_cooldown = fart_damage_interval
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
