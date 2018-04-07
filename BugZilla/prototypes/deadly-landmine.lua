require "lib.utilities.generic"

local landmine = DeepCopy(data.raw['land-mine']['land-mine'])
landmine.name = "deadly-mine"
landmine.minable = nil
landmine.max_health = 250
landmine.timeout = 0
landmine.selection_box = nil
landmine.trigger_radius = .5
landmine.action.action_delivery.source_effects = DeepCopy(data.raw['projectile']['atomic-rocket'].action.action_delivery.target_effects)
landmine.order = 'bz-[deadly-mine]'

data:extend({
  landmine,
})
