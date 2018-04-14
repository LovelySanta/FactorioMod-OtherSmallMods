
Debug = {}

Debug.enabled = true
Debug.returnValue = 4

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

  if self.returnValue == 1 then
    return
  end



--------------------------------------------------------------------------------
----- Advancing to basic defence and automation of basic (green) science   -----
--------------------------------------------------------------------------------

  -- Science: research green science (and bottling)
  researchTechnology("electronics")
  researchTechnology("automation-2")
  researchTechnology("steel-processing")
  researchTechnology("basic-science-research-1")

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

  -- Military: optional research
  researchTechnology("flammables")

  -- Military: bonusses
  researchTechnology("bullet-damage-2")
  researchTechnology("bullet-speed-2")
  researchTechnology("bullet-speed-3")
  researchTechnology("gun-turret-damage-1")
  researchTechnology("gun-turret-damage-2")
  researchTechnology("shotgun-shell-damage-2")
  researchTechnology("shotgun-shell-speed-2")
  researchTechnology("shotgun-shell-speed-3")

  if self.returnValue == 2 then
    return
  end



--------------------------------------------------------------------------------
----- Establishing beter defence systems (gray science)                    -----
--------------------------------------------------------------------------------

  -- Science: research gray science
  researchTechnology("basic-military-science-research")

  -- Military: bonusses
  researchTechnology("bullet-damage-3")
  researchTechnology("bullet-damage-4")
  researchTechnology("bullet-speed-4")
  researchTechnology("gun-turret-damage-3")
  researchTechnology("gun-turret-damage-4")
  researchTechnology("shotgun-shell-damage-3")
  researchTechnology("shotgun-shell-damage-4")
  researchTechnology("shotgun-shell-speed-4")
  researchTechnology("grenade-damage-1")
  researchTechnology("grenade-damage-2")
  researchTechnology("grenade-damage-3")

  if self.returnValue == 3 then
    return
  end



--------------------------------------------------------------------------------
----- Get specific automation research (orange science)               -----
--------------------------------------------------------------------------------

  -- Science: research orange science
  researchTechnology("basic-automation-science-research")

  -- Science: bonusses
  researchTechnology("research-speed-3")

  -- Automation: getting into oil processing
  researchTechnology("circuit-network")
  researchTechnology("oil-processing")
  researchTechnology("plastics")
  researchTechnology("advanced-electronics")
  researchTechnology("sulfur-processing")
  researchTechnology("battery")

  -- Automation: optional research
  researchTechnology("engine")
  researchTechnology("advanced-material-processing")
  researchTechnology("concrete")
  researchTechnology("modules")
  researchTechnology("speed-module")
  researchTechnology("productivity-module")

  -- Automation: bonusses
  researchTechnology("mining-productivity-1")

  -- Military: advanced defence systems
  researchTechnology("flammables")
  researchTechnology("flamethrower")
  researchTechnology("laser")
  researchTechnology("laser-turrets")
  researchTechnology("explosives")
  researchTechnology("land-mine")
  researchTechnology("rocketry")

  -- Military: optional research
  researchTechnology("cliff-explosives")

  -- Military: bonusses
  researchTechnology("flamethrower-damage-1")
  researchTechnology("flamethrower-damage-2")
  researchTechnology("laser-turret-damage-1")
  researchTechnology("laser-turret-damage-2")
  researchTechnology("laser-turret-speed-1")
  researchTechnology("laser-turret-speed-2")
  researchTechnology("rocket-damage-1")
  researchTechnology("rocket-damage-2")
  researchTechnology("rocket-speed-1")
  researchTechnology("rocket-speed-2")



  if self.returnValue == 4 then
    return
  end

  -- Science: research blue science
  researchTechnology("basic-science-research-2")

  -- Science: bonusses
  researchTechnology("research-speed-4")

  -- Science: research pink science
  researchTechnology("electric-engine")
  researchTechnology("basic-logistics-science-research")

  -- Logistics: train network
  researchTechnology("railway")
  researchTechnology("automated-rail-transportation")
  researchTechnology("rail-signals")
  researchTechnology("fluid-wagon")
  researchTechnology("logistics-2")

  -- Logistics: robot network
  researchTechnology("robotics")
  researchTechnology("flying")
  researchTechnology("construction-robotics")
  researchTechnology("logistic-robotics")

  return
end
