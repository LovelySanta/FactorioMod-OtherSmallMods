
if not BugzillaBuilder then
  BugzillaBuilder = {}
end



--############################################################################--
--##########   Icons                                                ##########--
--############################################################################--
function BugzillaBuilder:make_icon(ico_app)
  return
  {
    {
      icon = "__BugZilla__/graphics/icons/"..ico_app.type.."/"..ico_app.name..".png"
    }
  }
end



--############################################################################--
--##########   Make biter                                           ##########--
--############################################################################--
function BugzillaBuilder:make_alien(def_data)
  if not self[def_data.appearance.type] then
    require ("prototypes/bugzilla-builder-" .. def_data.appearance.type)
  end

  data:extend({
    {
      type = "unit",
      name = def_data.appearance.name,
      icons = self:make_icon(def_data.appearance),
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
      attack_parameters = self[def_data.appearance.type]:make_attack_parameter(def_data.appearance, def_data.attack),
      vision_distance = 30,
      movement_speed = def_data.appearance.speed,
      distance_per_frame = def_data.graphics.walk_distance_per_frame,
      pollution_to_join_attack = 200,
      distraction_cooldown = 300,
      min_pursue_time = 10 * 60,
      max_pursue_distance = 50,
      corpse = def_data.appearance.name.."-corpse",
      dying_explosion = "blood-explosion-"..def_data.graphics.dying_explosion,
      dying_sound =  self[def_data.appearance.type]:make_die_sound(def_data.appearance, 0.4),
      working_sound =  self[def_data.appearance.type]:make_call_sounds(def_data.appearance, 0.3),
      run_animation = self[def_data.appearance.type]:make_run_animation(def_data.appearance)
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
      animation = self[def_data.appearance.type]:make_die_animation(def_data.appearance)
    }
  })
end
