require "lib/utilities/debug"


-- on load game for first time
script.on_init(function(_)
  if Debug.enabled then
    Debug:reseachAllTechnologies()
  end
end)



script.on_configuration_changed(function(data)
  -- Check if this mod has changed
  for modName, modData in pairs(data.mod_changes) do
    if modName == "MoreScience" then

      -- Mod has beed added/changed make sure recipes are unlocked if early research was conducted
      for _, force in pairs(game.forces) do
        -- basic automation
        if force.technologies["automation"].researched or force.technologies["logistics"].researched then
          force.technologies["basic-automation"].researched = true
          force.technologies["basic-science-research-1"].researched = true
          force.technologies["basic-automation-science-research"].researched = true
          force.technologies["bottling-research"].researched = true

          -- fluid handling
          if force.technologies["fluid-handling"].researched then
            force.technologies["fluid-handling-2"].researched = true
          end

          -- blue science
          if force.technologies["advanced-electronics"].researched then
            force.technologies["basic-science-research-2"].researched = true

            -- purple science
            if force.technologies["advanced-material-processing-2"].researched then
              force.technologies["advanced-science-research-1"].researched = true
            end

            -- yellow science
            if force.technologies["advanced-electronics-2"].researched then
              force.technologies["advanced-science-research-2"].researched = true
            end
          end

          -- military research
          if force.technologies["military-2"].researched then
            force.technologies["basic-military-science-research"].researched = true
          end

          -- power science
          if force.technologies["battery"].researched then
            force.technologies["basic-power-science-research"].researched = true
          end

          -- logistics science
          if force.technologies["electric-engine"].researched then
            force.technologies["basic-logistics-science-research"].researched = true
          end
        end

        force.reset_technology_effects()
      end

      -- No need to look further, we found our mod already
      break
    end
  end
end)
