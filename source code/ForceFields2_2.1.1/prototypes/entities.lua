require 'prototypes/defines/forcefield-builder'
require 'src/settings'



addForceField("blue", false)
addForceField("green", false)
addForceField("red", true)
addForceField("purple", false)

addForceFieldGate("blue", false)
addForceFieldGate("green", false)
addForceFieldGate("red", true)
addForceFieldGate("purple", false)



data:extend(
{
  {
    type = "electric-energy-interface",
    name = Settings.emitterName,
    icon = Settings.modName .. "/graphics/" .. Settings.emitterName .. "-icon.png",
    icon_size = 32,
    flags = {"placeable-neutral", "player-creation"},
    enable_gui = true,
    allow_copy_paste = true,
    minable = {hardness = 0.2, mining_time = 1, result = Settings.emitterName},
    max_health = 50,
    corpse = "small-remnants",
    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    energy_source =
    {
      type = "electric",
      buffer_capacity = "100MJ",
      usage_priority = "primary-input",
      input_flow_limit = "100MW",
      output_flow_limit = "0kW",
      drain = "100kW"
    },
    energy_production = "0kW",
    energy_consumption = "100MW",
    picture =
    {
      filename = Settings.modName .. "/graphics/" .. Settings.emitterName .. "-active.png",
      priority = "extra-high",
      width = 72,
      height = 62,
      shift = {0.49145, -0.25}
    },
    working_sound =
    {
      idle_sound =
      {
        filename = "__base__/sound/accumulator-idle.ogg",
        volume = 0.4
      },
      sound =
      {
        filename = "__base__/sound/accumulator-idle.ogg",
        volume = 0.4
      },
      max_sounds_per_type = 5
    },
    order="s[electric-energy-interface]-t1",
    subgroup = "forcefields"
  },

  {
    type = "smoke-with-trigger",
    name = Settings.forcefieldBuildDamageName,
    flags = {"not-on-map", "placeable-off-grid"},
    show_when_smoke_off = false,
    animation =
    {
      filename = Settings.modName .. "/graphics/null.png",
      priority = "low",
      width = 32,
      height = 32,
      frame_count = 1,
      width = 32,
      height = 32,
      animation_speed = 1,
      line_length = 1,
      scale = 1,
    },
    slow_down_factor = 0,
    wind_speed_factor = 0,
    cyclic = true,
    duration = 2,
    fade_away_duration =  1,
    spread_duration = 1,
    color = { r = 0, g = 0, b = 0, a = 1 },
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
            radius = 1,
            entity_flags = {"breaths-air"},
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = {amount = 20, type = "poison"}
              }
            }
          }
        }
      }
    },
    action_cooldown = 60
  },

  {
    type = "smoke-with-trigger",
    name = Settings.forcefieldDeathDamageName,
    flags = {"not-on-map", "placeable-off-grid"},
    show_when_smoke_off = false,
    animation =
    {
      filename = Settings.modName .. "/graphics/null.png",
      priority = "low",
      width = 32,
      height = 32,
      frame_count = 1,
      animation_speed = 1,
      line_length = 1,
      scale = 1,
    },
    slow_down_factor = 0,
    wind_speed_factor = 0,
    cyclic = true,
    duration = 2,
    fade_away_duration =  1,
    spread_duration = 1,
    color = { r = 0, g = 0, b = 0, a = 1 },
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
            radius = 4,
            entity_flags = {"breaths-air"},
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = {amount = 280, type = "poison"}
              }
            }
          }
        }
      }
    },
    action_cooldown = 60
  },

  {
    type = "simple-entity",
    name = Settings.configWallIconName,
    icon = Settings.modName .. "/graphics/gui/config-tool.png",
    icon_size = 32,
    picture =
    {
      filename = Settings.modName .. "/graphics/null.png",
      priority = "low",
      width = 32,
      height = 32,
      --frame_count = 1,
      --animation_speed = 1,
      --line_length = 1,
      --scale = 1,
    },
  },
})
