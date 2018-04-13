require "lib/utilities/debug"


-- on load game for first time
script.on_init(function(_)
  if Debug.enabled then
    Debug:reseachAllTechnologies()
  end
end)
