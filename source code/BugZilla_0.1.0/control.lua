require 'lib/BugZilla/phaseCycler'

script.on_event(defines.event.on_init, function(_)
  PhaseCycler:Init()
end)


script.on_event(defines.event.on_runtime_mod_setting_changed, function(event)

end)
