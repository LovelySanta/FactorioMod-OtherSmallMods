require 'src/settings'



function getForceFieldBaseWall()
  return
  {
    type = "wall",
    name = "",
    icon = "",
    icon_size = nil,
    flags = {"placeable-neutral", "player-creation", "not-repairable"},
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    max_health = nil,
    --mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    minable = {hardness = 0.2, mining_time = 2, result = "forcefield-emitter", count = 0},
    order = "a[items]-f[forcefields]",
    resistances =
    {
      {
        type = "physical",
        decrease = 3,
        percent = 20
      },
      {
        type = "impact",
        decrease = 45,
        percent = 100
      },
      {
        type = "explosion",
        decrease = 10,
        percent = 40
      },
      {
        type = "fire",
        percent = 95
      },
      {
        type = "laser",
        percent = 70
      }
    },
    pictures =
    {
      single =
      {
        layers =
        {
          {
            priority = "extra-high",
            width = 22,
            height = 42,
            shift = {0, -0.15625}
          },
          {
            priority = "extra-high",
            width = 47,
            height = 32,
            shift = {0.359375, 0.5},
            draw_as_shadow = true
          }
        }
      },
      straight_vertical =
      {
        {
          layers =
          {
            {
              priority = "extra-high",
              width = 22,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              priority = "extra-high",
              width = 47,
              height = 60,
              shift = {0.390625, 0.625},
              draw_as_shadow = true
            }
          }
        },
        {
          layers =
          {
            {
              priority = "extra-high",
              width = 22,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              priority = "extra-high",
              width = 47,
              height = 60,
              shift = {0.390625, 0.625},
              draw_as_shadow = true
            }
          }
        },
        {
          layers =
          {
            {
              priority = "extra-high",
              width = 22,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              priority = "extra-high",
              width = 47,
              height = 60,
              shift = {0.390625, 0.625},
              draw_as_shadow = true
            }
          }
        }
      },
      straight_horizontal =
      {
        {
          layers =
          {
            {
              priority = "extra-high",
              width = 32,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              priority = "extra-high",
              width = 59,
              height = 32,
              shift = {0.421875, 0.5},
              draw_as_shadow = true
            }
          }
        },
        {
          layers =
          {
            {
              priority = "extra-high",
              width = 32,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              priority = "extra-high",
              width = 59,
              height = 32,
              shift = {0.421875, 0.5},
              draw_as_shadow = true
            }
          }
        },
        {
          layers =
          {
            {
              priority = "extra-high",
              width = 32,
              height = 42,
              shift = {0, -0.15625}
            },
            {
              priority = "extra-high",
              width = 59,
              height = 32,
              shift = {0.421875, 0.5},
              draw_as_shadow = true
            }
          }
        }
      },
      corner_right_down =
      {
        layers =
        {
          {
            priority = "extra-high",
            width = 27,
            height = 42,
            shift = {0.078125, -0.15625}
          },
          {
            priority = "extra-high",
            width = 53,
            height = 61,
            shift = {0.484375, 0.640625},
            draw_as_shadow = true
          }
        }
      },
      corner_left_down =
      {
        layers =
        {
          {
            priority = "extra-high",
            width = 27,
            height = 42,
            shift = {-0.078125, -0.15625}
          },
          {
            priority = "extra-high",
            width = 53,
            height = 60,
            shift = {0.328125, 0.640625},
            draw_as_shadow = true
          }
        }
      },
      t_up =
      {
        layers =
        {
          {
            priority = "extra-high",
            width = 32,
            height = 42,
            shift = {0, -0.15625}
          },
          {
            priority = "extra-high",
            width = 71,
            height = 61,
            shift = {0.546875, 0.640625},
            draw_as_shadow = true
          }
        }
      },
      ending_right =
      {
        layers =
        {
          {
            priority = "extra-high",
            width = 27,
            height = 42,
            shift = {0.078125, -0.15625}
          },
          {
            priority = "extra-high",
            width = 53,
            height = 32,
            shift = {0.484375, 0.5},
            draw_as_shadow = true
          }
        }
      },
      ending_left =
      {
        layers =
        {
          {
            priority = "extra-high",
            width = 27,
            height = 42,
            shift = {-0.078125, -0.15625}
          },
          {
            priority = "extra-high",
            width = 53,
            height = 32,
            shift = {0.328125, 0.5},
            draw_as_shadow = true
          }
        }
      }
    }
  }
end



function getForceFieldBaseGate()
  return
  {
    type = "gate",
    name = "",
    icon = "",
    icon_size = nil,
    flags = {"placeable-neutral", "placeable-player", "player-creation", "not-repairable"},
    minable = {hardness = 0.2, mining_time = 4, result = "forcefield-emitter", count = 0},
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    opening_speed = 0.1,
    activation_distance = 6,
    timeout_to_close = 5,
    order = "a[items]-f[forcefields-gate]",
    resistances =
    {
      {
        type = "physical",
        decrease = 3,
        percent = 20
      },
      {
        type = "impact",
        decrease = 45,
        percent = 100
      },
      {
        type = "explosion",
        decrease = 10,
        percent = 30
      },
      {
        type = "fire",
        percent = 100
      },
      {
        type = "laser",
        percent = 70
      }
    },
    vertical_animation =
    {
      layers =
      {
        {
          line_length = 8,
          width = 21,
          height = 60,
          frame_count = 16,
          shift = {0.015625, -0.40625}
        },
        {
          line_length = 8,
          width = 41,
          height = 50,
          frame_count = 16,
          shift = {0.328125, 0.3},
          draw_as_shadow = true
        }
      }
    },
    horizontal_animation =
    {
      layers =
      {
        {
          line_length = 8,
          width = 32,
          height = 36,
          frame_count = 16,
          shift = {0, -0.21875}
        },
        {
          line_length = 8,
          width = 62,
          height = 28,
          frame_count = 16,
          shift = {0.4375, 0.46875},
          draw_as_shadow = true
        }
      }
    },
    vertical_base =
    {
      layers =
      {
        {
          width = 32,
          height = 32
        },
        {
          width = 32,
          height = 32,
          apply_runtime_tint = true
        }
      }
    },
    horizontal_rail_animation_left =
    {
      layers =
      {
        {
          line_length = 8,
          width = 32,
          height = 47,
          frame_count = 16,
          shift = {0, -0.140625 + 0.125}
        },
        {
          line_length = 8,
          width = 73,
          height = 27,
          frame_count = 16,
          shift = {0.078125, 0.171875 + 0.125},
          draw_as_shadow = true
        }
      }
    },
    horizontal_rail_animation_right =
    {
      layers =
      {
        {
          line_length = 8,
          width = 32,
          height = 43,
          frame_count = 16,
          shift = {0, -0.203125 + 0.125}
        },
        {
          line_length = 8,
          width = 73,
          height = 28,
          frame_count = 16,
          shift = {0.60938, 0.2875 + 0.125},
          draw_as_shadow = true
        }
      }
    },
    vertical_rail_animation_left =
    {
      layers =
      {
        {
          line_length = 8,
          width = 22,
          height = 54,
          frame_count = 16,
          shift = {0, -0.46875}
        },
        {
          line_length = 8,
          width = 47,
          height = 48,
          frame_count = 16,
          shift = {0.27, -0.16125 + 0.5},
          draw_as_shadow = true
        }
      }
    },
    vertical_rail_animation_right =
    {
      layers =
      {
        {
          line_length = 8,
          width = 22,
          height = 55,
          frame_count = 16,
          shift = {0, -0.453125}
        },
        {
          line_length = 8,
          width = 47,
          height = 47,
          frame_count = 16,
          shift = {0.27, 0.803125 - 0.5},
          draw_as_shadow = true
        }
      }
    },
    vertical_rail_base =
    {
      line_length = 8,
      width = 64,
      height = 64,
      frame_count = 16,
      shift = {0, 0},
    },
    horizontal_rail_base =
    {
      line_length = 8,
      width = 64,
      height = 45,
      frame_count = 16,
      shift = {0, -0.015625 + 0.125},
    },
    vertical_rail_base_mask =
    {
      width = 63,
      height = 39,
      shift = {0.015625, -0.015625},
      apply_runtime_tint = true
    },
    horizontal_rail_base_mask =
    {
      width = 53,
      height = 45,
      shift = {0.015625, -0.015625 + 0.125},
      apply_runtime_tint = true
    },
    horizontal_base =
    {
      layers =
      {
        {
          width = 32,
          height = 23,
          shift = {0, 0.125}
        },
        {
          width = 32,
          height = 23,
          apply_runtime_tint = true,
          shift = {0, 0.125}
        }
      }
    },
    wall_patch =
    {
      north =
      {
        layers =
        {
          {
            width = 22,
            height = 35,
            shift = {0, -0.62}
          },
          {
            width = 46,
            height = 31,
            shift = {0.3, 0.20},
            draw_as_shadow = true
          }
        }
      },
      east =
      {
        layers =
        {
          {
            width = 11,
            height = 40,
            shift = {0.328125, -0.109375}
          },
          {
            width = 38,
            height = 32,
            shift = {0.8125, 0.46875},
            draw_as_shadow = true
          }
        }
      },
      south =
      {
        layers =
        {
          {
            width = 22,
            height = 40,
            shift = {0, -0.125}
          },
          {
            width = 48,
            height = 25,
            shift = {0.3, 0.95},
            draw_as_shadow = true
          }
        }
      },
      west =
      {
        layers =
        {
          {
            width = 11,
            height = 40,
            shift = {-0.328125, -0.109375}
          },
          {
            width = 46,
            height = 32,
            shift = {0.1875, 0.46875},
            draw_as_shadow = true
          }
        }
      }
    },
    wall_diode_green =
    {
      width = 21,
      height = 22,
      shift = {0, -0.78125}
    },
    wall_diode_green_light =
    {
      minimum_darkness = 0.3,
      color = {g=1},
      shift = {0, -0.78125},
      size = 1,
      intensity = 0.3
    },
    wall_diode_red =
    {
      width = 21,
      height = 22,
      shift = {0, -0.78125}
    },
    wall_diode_red_light =
    {
      minimum_darkness = 0.3,
      color = {r=1},
      shift = {0, -0.78125},
      size = 1,
      intensity = 0.3
    },
    open_trigger_effect =
    {
      type = "play-sound",
      sound = { filename = "__base__/sound/gate1.ogg", volume = 0.5 }
    },
    close_trigger_effect =
    {
      type = "play-sound",
      sound = { filename = "__base__/sound/gate1.ogg", volume = 0.5 }
    }
  }
end



function getForceFieldBaseAttackReaction()
  return
  {
    range = 2,
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
            damage = {amount = 5, type = "laser"}
          }
        }
      }
    }
  }
end



function addForceField(color, sourceAttackReaction)
  local newForceField = util.table.deepcopy(getForceFieldBaseWall())
  local imgDir = Settings.modName .. "/graphics/walls/"
  newForceField.name = color .. Settings.fieldSuffix
  newForceField.icon = imgDir .. color .. "/wall-icon.png"
  newForceField.icon_size = 42
  newForceField.max_health = Settings.forcefieldTypes[newForceField.name].maxHealth

  local p = newForceField.pictures
  p.single.layers[1].filename = imgDir .. color .. "/wall-single.png"
  p.single.layers[2].filename = imgDir .. color .. "/wall-single-shadow.png"
  p.straight_vertical[1].layers[1].filename = imgDir .. color .. "/wall-straight-vertical-1.png"
  p.straight_vertical[1].layers[2].filename = imgDir .. color .. "/wall-straight-vertical-shadow.png"
  p.straight_vertical[2].layers[1].filename = imgDir .. color .. "/wall-straight-vertical-2.png"
  p.straight_vertical[2].layers[2].filename = imgDir .. color .. "/wall-straight-vertical-shadow.png"
  p.straight_vertical[3].layers[1].filename = imgDir .. color .. "/wall-straight-vertical-3.png"
  p.straight_vertical[3].layers[2].filename = imgDir .. color .. "/wall-straight-vertical-shadow.png"
  p.straight_horizontal[1].layers[1].filename = imgDir .. color .. "/wall-straight-horizontal-1.png"
  p.straight_horizontal[1].layers[2].filename = imgDir .. color .. "/wall-straight-horizontal-shadow.png"
  p.straight_horizontal[2].layers[1].filename = imgDir .. color .. "/wall-straight-horizontal-2.png"
  p.straight_horizontal[2].layers[2].filename = imgDir .. color .. "/wall-straight-horizontal-shadow.png"
  p.straight_horizontal[3].layers[1].filename = imgDir .. color .. "/wall-straight-horizontal-3.png"
  p.straight_horizontal[3].layers[2].filename = imgDir .. color .. "/wall-straight-horizontal-shadow.png"
  p.corner_right_down.layers[1].filename = imgDir .. color .. "/wall-corner-right-down.png"
  p.corner_right_down.layers[2].filename = imgDir .. color .. "/wall-corner-right-down-shadow.png"
  p.corner_left_down.layers[1].filename = imgDir .. color .. "/wall-corner-left-down.png"
  p.corner_left_down.layers[2].filename = imgDir .. color .. "/wall-corner-left-down-shadow.png"
  p.t_up.layers[1].filename = imgDir .. color .. "/wall-t-down.png"
  p.t_up.layers[2].filename = imgDir .. color .. "/wall-t-down-shadow.png"
  p.ending_right.layers[1].filename = imgDir .. color .. "/wall-ending-right.png"
  p.ending_right.layers[2].filename = imgDir .. color .. "/wall-ending-right-shadow.png"
  p.ending_left.layers[1].filename = imgDir .. color .. "/wall-ending-left.png"
  p.ending_left.layers[2].filename = imgDir .. color .. "/wall-ending-left-shadow.png"

  if sourceAttackReaction then
    if not newForceField.attack_reaction then
      newForceField.attack_reaction = {}
    end
    table.insert(newForceField.attack_reaction, getForceFieldBaseAttackReaction())
  end

  data:extend({newForceField})
end



function addForceFieldGate(color, maxHealth, sourceAttackReaction)
  local newForceFieldGate = util.table.deepcopy(getForceFieldBaseGate())
  local imgDir = Settings.modName .. "/graphics/gates/"
  newForceFieldGate.name = color .. "-forcefield-gate"
  newForceFieldGate.icon = imgDir .. color .. "/" .. "/gate.png"
  newForceFieldGate.max_health = Settings.forcefieldTypes[newForceField.name].maxHealth

  newForceFieldGate.vertical_animation.layers[1].filename = imgDir .. color .. "/gate-vertical.png"
  newForceFieldGate.vertical_animation.layers[2].filename = imgDir .. color .. "/gate-vertical-shadow.png"
  newForceFieldGate.horizontal_animation.layers[1].filename = imgDir .. color .. "/gate-horizontal.png"
  newForceFieldGate.horizontal_animation.layers[2].filename = imgDir .. color .. "/gate-horizontal-shadow.png"
  newForceFieldGate.vertical_base.layers[1].filename = imgDir .. color .. "/gate-base-vertical.png"
  newForceFieldGate.vertical_base.layers[2].filename = imgDir .. color .. "/gate-base-vertical-mask.png"
  newForceFieldGate.horizontal_rail_animation_left.layers[1].filename = imgDir .. color .. "/gate-rail-horizontal-left.png"
  newForceFieldGate.horizontal_rail_animation_left.layers[2].filename = imgDir .. color .. "/gate-rail-horizontal-shadow-left.png"
  newForceFieldGate.horizontal_rail_animation_right.layers[1].filename = imgDir .. color .. "/gate-rail-horizontal-right.png"
  newForceFieldGate.horizontal_rail_animation_right.layers[2].filename = imgDir .. color .. "/gate-rail-horizontal-shadow-right.png"
  newForceFieldGate.vertical_rail_animation_left.layers[1].filename = imgDir .. color .. "/gate-rail-vertical-left.png"
  newForceFieldGate.vertical_rail_animation_left.layers[2].filename = imgDir .. color .. "/gate-rail-vertical-shadow-left.png"
  newForceFieldGate.vertical_rail_animation_right.layers[1].filename = imgDir .. color .. "/gate-rail-vertical-right.png"
  newForceFieldGate.vertical_rail_animation_right.layers[2].filename = imgDir .. color .. "/gate-rail-vertical-shadow-right.png"
  newForceFieldGate.vertical_rail_base.filename = imgDir .. color .. "/gate-rail-base-vertical.png"
  newForceFieldGate.horizontal_rail_base.filename = imgDir .. color .. "/gate-rail-base-horizontal.png"
  newForceFieldGate.vertical_rail_base_mask.filename = imgDir .. color .. "/gate-rail-base-mask-vertical.png"
  newForceFieldGate.horizontal_rail_base_mask.filename = imgDir .. color .. "/gate-rail-base-mask-horizontal.png"
  newForceFieldGate.horizontal_base.layers[1].filename = imgDir .. color .. "/gate-base-horizontal.png"
  newForceFieldGate.horizontal_base.layers[2].filename = imgDir .. color .. "/gate-base-horizontal-mask.png"
  newForceFieldGate.wall_patch.north.layers[1].filename = imgDir .. color .. "/wall-patch-north.png"
  newForceFieldGate.wall_patch.north.layers[2].filename = imgDir .. color .. "/wall-patch-north-shadow.png"
  newForceFieldGate.wall_patch.east.layers[1].filename = imgDir .. color .. "/wall-patch-east.png"
  newForceFieldGate.wall_patch.east.layers[2].filename = imgDir .. color .. "/wall-patch-east-shadow.png"
  newForceFieldGate.wall_patch.south.layers[1].filename = imgDir .. color .. "/wall-patch-south.png"
  newForceFieldGate.wall_patch.south.layers[2].filename = imgDir .. color .. "/wall-patch-south-shadow.png"
  newForceFieldGate.wall_patch.west.layers[1].filename = imgDir .. color .. "/wall-patch-west.png"
  newForceFieldGate.wall_patch.west.layers[2].filename = imgDir .. color .. "/wall-patch-west-shadow.png"
  newForceFieldGate.wall_diode_green.filename = imgDir .. color .. "/wall-diode-green.png"
  newForceFieldGate.wall_diode_red.filename = imgDir .. color .. "/wall-diode-red.png"

  if sourceAttackReaction then
    if not newForceField.attack_reaction then
      newForceField.attack_reaction = {}
    end
    table.insert(newForceFieldGate.attack_reaction, getForceFieldBaseAttackReaction())
  end

  data:extend({newForceFieldGate})
end
