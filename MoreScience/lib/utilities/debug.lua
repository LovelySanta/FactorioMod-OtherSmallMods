
Debug = {}

Debug.enabled = true

function Debug:reseachAllTechnologies()
  force = game.forces["player"]

  local function researchTechnology(technologyName)
    if force.technologies[technologyName] and force.technologies[technologyName].enabled then
      -- check prerequisites
      for _,prerequisite in pairs(force.technologies[technologyName].prerequisites) do
        if not prerequisite.researched then
          return false
        end
      end
      -- do the research
      force.technologies[technologyName].researched = true
      return true
    end
    return false
  end


--------------------------------------------------------------------------------
----- Start of the game: minor defence and automation of power             -----
--------------------------------------------------------------------------------

  -- Automation & Logistics: smelter setup
  researchTechnology("basic-automation")
  researchTechnology("automation")
  researchTechnology("logistics")

  -- Military: first defence systems
  researchTechnology("military")
  researchTechnology("stone-walls")
  researchTechnology("turrets")

  -- Military: bonusses
  researchTechnology("bullet-damage-1")
  researchTechnology("bullet-speed-1")
  researchTechnology("shotgun-shell-damage-1")
  researchTechnology("shotgun-shell-speed-1")

  -- Character management: light and inventory
  researchTechnology("optics")
  researchTechnology("toolbelt")



--------------------------------------------------------------------------------
----- Advancing to basic defence and automation of basic science           -----
--------------------------------------------------------------------------------

  -- Science: research green science (and bottling)
  researchTechnology("electronics")
  researchTechnology("automation-2")
  researchTechnology("steel-processing")
  researchTechnology("basic-science-research")

  researchTechnology("fluid-handling")
  researchTechnology("bottling-research")

  -- Science: bonusses
  researchTechnology("research-speed-1")
  researchTechnology("research-speed-2")

  -- Power network: beter power poles
  researchTechnology("electric-energy-distribution-1")

  -- Logistics: fluid storage, landfill
  researchTechnology("fluid-handling-2")
  researchTechnology("landfill")

  -- Military: basic defence systems
  researchTechnology("heavy-armor")
  researchTechnology("military-2")
  researchTechnology("gates")

  -- Military: bonusses
  researchTechnology("bullet-damage-2")
  researchTechnology("bullet-speed-2")
  researchTechnology("bullet-speed-3")
  researchTechnology("gun-turret-damage-1")
  researchTechnology("gun-turret-damage-2")
  researchTechnology("shotgun-shell-damage-2")
  researchTechnology("shotgun-shell-speed-2")
  researchTechnology("shotgun-shell-speed-3")

--------------------------------------------------------------------------------
----- Establishing main production                                         -----
--------------------------------------------------------------------------------

  -- Science: research orange science
  researchTechnology("basic-automation-science-research")

  -- Automation: getting into oil processing
  researchTechnology("circuit-network")
  researchTechnology("oil-processing")
  researchTechnology("plastics")
  researchTechnology("advanced-electronics")
  researchTechnology("sulfur-processing")
  researchTechnology("battery")

  -- Automation: optional research
  researchTechnology("advanced-material-processing")



  -- Science: research pink science
  researchTechnology("engine")
  researchTechnology("basic-logistics-science-research")


end
