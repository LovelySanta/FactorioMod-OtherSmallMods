
Debug = {}

Debug.enabled = false
Debug.returnValue = 10

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

  -- Logistics: fluid storage, science barreling, landfill
  researchTechnology("fluid-handling-2")
  researchTechnology("fluid-handling-3")
  researchTechnology("landfill")

  -- Military: basic defence systems
  researchTechnology("military-2")
  researchTechnology("gates")

  -- Military: Armor upgrades
  researchTechnology("heavy-armor")

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
----- Get specific automation research (orange science)                    -----
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

  -- Military: beter armor
  researchTechnology("modular-armor")
  researchTechnology("night-vision-equipment")

  -- Military: advanced defence systems
  researchTechnology("flammables")
  researchTechnology("flamethrower")
  researchTechnology("explosives")
  researchTechnology("land-mine")
  researchTechnology("rocketry")

  -- Military: optional research
  researchTechnology("laser")
  researchTechnology("cliff-explosives")

  -- Military: bonusses
  researchTechnology("flamethrower-damage-1")
  researchTechnology("flamethrower-damage-2")
  researchTechnology("rocket-damage-1")
  researchTechnology("rocket-damage-2")
  researchTechnology("rocket-speed-1")
  researchTechnology("rocket-speed-2")

  if self.returnValue == 4 then
    return
  end



--------------------------------------------------------------------------------
----- Get beter power source (light blue science)                          -----
--------------------------------------------------------------------------------

  -- Science: research light blue science
  researchTechnology("basic-power-science-research")

  -- Power: solar energy
  researchTechnology("solar-energy")
  researchTechnology("electric-energy-accumulators-1")

  -- Power: optional research
  researchTechnology("effectivity-module")

  -- Military: electricity powered defence
  researchTechnology("laser-turrets")

  -- Military: armor upgrades
  researchTechnology("solar-panel-equipment")
  researchTechnology("battery-equipment")
  researchTechnology("energy-shield-equipment")

  -- Military: bonusses
  researchTechnology("laser-turret-damage-1")
  researchTechnology("laser-turret-damage-2")
  researchTechnology("laser-turret-speed-1")
  researchTechnology("laser-turret-speed-2")

  if self.returnValue == 5 then
    return
  end



--------------------------------------------------------------------------------
----- Get more basic technology research (blue science)                         -----
--------------------------------------------------------------------------------

  -- Science: research blue science
  researchTechnology("basic-science-research-2")

  -- Science: bonusses
  researchTechnology("research-speed-4")

  -- Automation: advance automation process
  researchTechnology("advanced-oil-processing")

  -- Automation: optional research
  researchTechnology("advanced-material-processing-2")
  researchTechnology("advanced-electronics-2")
  researchTechnology("electric-engine")
  researchTechnology("flying")
  researchTechnology("speed-module-2")
  researchTechnology("productivity-module-2")

  -- Automation: bonusses
  researchTechnology("mining-productivity-4")

  -- Power network: beter power
  researchTechnology("electric-energy-distribution-2")
  researchTechnology("nuclear-power")
  researchTechnology("effectivity-module-2")

  -- Military: extra defence systems
  researchTechnology("flying")
  researchTechnology("combat-robotics")
  researchTechnology("military-3")
  researchTechnology("explosive-rocketry")
  researchTechnology("combat-robotics-2")

  -- Military: armor upgrades
  researchTechnology("battery-mk2-equipment")
  researchTechnology("exoskeleton-equipment")
  researchTechnology("power-armor")
  researchTechnology("energy-shield-mk2-equipment")
  researchTechnology("personal-laser-defense-equipment")
  researchTechnology("discharge-defense-equipment")

  -- Military: bonusses
  researchTechnology("bullet-damage-5")
  researchTechnology("bullet-speed-5")
  researchTechnology("gun-turret-damage-5")
  researchTechnology("shotgun-shell-damage-5")
  researchTechnology("shotgun-shell-speed-5")
  researchTechnology("grenade-damage-4")
  researchTechnology("grenade-damage-5")
  researchTechnology("flamethrower-damage-3")
  researchTechnology("flamethrower-damage-4")
  researchTechnology("rocket-damage-3")
  researchTechnology("rocket-damage-4")
  researchTechnology("rocket-damage-5")
  researchTechnology("rocket-speed-3")
  researchTechnology("rocket-speed-4")
  researchTechnology("rocket-speed-5")
  researchTechnology("laser-turret-damage-3")
  researchTechnology("laser-turret-damage-4")
  researchTechnology("laser-turret-speed-3")
  researchTechnology("laser-turret-speed-4")
  researchTechnology("combat-robot-damage-1")
  researchTechnology("combat-robot-damage-2")
  researchTechnology("combat-robot-damage-3")
  researchTechnology("combat-robot-damage-4")
  researchTechnology("follower-robot-count-1")
  researchTechnology("follower-robot-count-2")
  researchTechnology("follower-robot-count-3")
  researchTechnology("follower-robot-count-4")

  if self.returnValue == 6 then
    return
  end



--------------------------------------------------------------------------------
----- Get specific logistic technology (pink science)                         -----
--------------------------------------------------------------------------------

  -- Science: research pink science
  researchTechnology("basic-logistics-science-research")

  -- Logistics: Inserters
  researchTechnology("logistics-2")
  researchTechnology("stack-inserter")

  -- Logistics: train network
  researchTechnology("railway")
  researchTechnology("automated-rail-transportation")
  researchTechnology("rail-signals")
  researchTechnology("fluid-wagon")

  -- Logistics: robot network
  researchTechnology("robotics")
  researchTechnology("construction-robotics")
  researchTechnology("logistic-robotics")

  -- Logistics inventory managing
  researchTechnology("character-logistic-slots-1")
  researchTechnology("character-logistic-slots-2")
  researchTechnology("character-logistic-slots-3")
  researchTechnology("character-logistic-trash-slots-1")
  researchTechnology("character-logistic-trash-slots-2")
  researchTechnology("auto-character-logistic-trash-slots")

  -- Military: armor upgrades
  researchTechnology("personal-roboport-equipment")

  -- Military: tanks
  researchTechnology("automobilism")
  researchTechnology("tanks")

  -- Logistics: bonusses
  researchTechnology("inserter-capacity-bonus-1")
  researchTechnology("inserter-capacity-bonus-2")
  researchTechnology("inserter-capacity-bonus-3")
  researchTechnology("braking-force-1")
  researchTechnology("braking-force-2")
  researchTechnology("worker-robots-storage-1")
  researchTechnology("worker-robots-speed-1")
  researchTechnology("worker-robots-speed-2")

  -- Military: bonusses
  researchTechnology("cannon-shell-damage-1")
  researchTechnology("cannon-shell-damage-2")
  researchTechnology("cannon-shell-damage-3")
  researchTechnology("cannon-shell-speed-1")
  researchTechnology("cannon-shell-speed-2")
  researchTechnology("cannon-shell-speed-3")

  if self.returnValue == 7 then
    return
  end



--------------------------------------------------------------------------------
----- Get advanced technology research (purple science)                    -----
--------------------------------------------------------------------------------

  -- Science: research purple science
  researchTechnology("advanced-science-research-1")

  -- Science: bonusses
  researchTechnology("research-speed-5")

  -- Automation
  researchTechnology("automation-3")
  researchTechnology("logistics-3")

  -- Automation: optional research
  researchTechnology("coal-liquefaction")
  researchTechnology("productivity-module-3")

  -- Logistics: inventory management
  researchTechnology("character-logistic-slots-4")
  researchTechnology("character-logistic-slots-5")

  -- Automation: bonusses
  researchTechnology("mining-productivity-8")

  -- Logistics: bonusses
  researchTechnology("inserter-capacity-bonus-4")
  researchTechnology("inserter-capacity-bonus-5")
  researchTechnology("inserter-capacity-bonus-6")
  researchTechnology("braking-force-3")
  researchTechnology("braking-force-4")
  researchTechnology("braking-force-5")
  researchTechnology("worker-robots-storage-2")
  researchTechnology("worker-robots-speed-3")
  researchTechnology("worker-robots-speed-4")

  -- Power network
  researchTechnology("nuclear-fuel-reprocessing")

  if self.returnValue == 8 then
    return
  end



--------------------------------------------------------------------------------
----- Get more advanced technology research (yellow science)               -----
--------------------------------------------------------------------------------

  -- Science: research yellow science
  researchTechnology("advanced-science-research-2")

  -- Science: bonusses
  researchTechnology("research-speed-6")

  -- Automation: modules
  researchTechnology("speed-module-3")
  researchTechnology("effectivity-module-3")
  researchTechnology("effect-transmission")

  -- Automation: optional research
  researchTechnology("rocket-silo")

  -- Logistics: robot network
  researchTechnology("logistic-system")

  -- Logistics: inventory management
  researchTechnology("character-logistic-slots-6")

  -- Power
  researchTechnology("kovarex-enrichment-process")

  -- Military: extra defence systems
  researchTechnology("military-4")
  researchTechnology("combat-robotics-3")
  researchTechnology("uranium-ammo")
  researchTechnology("atomic-bomb")
  researchTechnology("artillery")

  -- Military: armor upgrades
  researchTechnology("fusion-reactor-equipment")
  researchTechnology("personal-roboport-equipment-2")
  researchTechnology("power-armor-2")

  -- Automation: bonusses
  researchTechnology("mining-productivity-12")

  -- Logistics: bonusses
  researchTechnology("inserter-capacity-bonus-7")
  researchTechnology("braking-force-6")
  researchTechnology("braking-force-7")
  researchTechnology("worker-robots-storage-3")
  researchTechnology("worker-robots-speed-5")

  -- Military: bonusses
  researchTechnology("bullet-damage-6")
  researchTechnology("bullet-speed-6")
  researchTechnology("gun-turret-damage-6")
  researchTechnology("shotgun-shell-damage-6")
  researchTechnology("shotgun-shell-speed-6")
  researchTechnology("grenade-damage-6")
  researchTechnology("flamethrower-damage-5")
  researchTechnology("flamethrower-damage-6")
  researchTechnology("rocket-damage-6")
  researchTechnology("rocket-speed-6")
  researchTechnology("rocket-speed-7")
  researchTechnology("laser-turret-damage-5")
  researchTechnology("laser-turret-damage-6")
  researchTechnology("laser-turret-damage-7")
  researchTechnology("laser-turret-speed-5")
  researchTechnology("laser-turret-speed-6")
  researchTechnology("laser-turret-speed-7")
  researchTechnology("combat-robot-damage-5")
  researchTechnology("follower-robot-count-5")
  researchTechnology("follower-robot-count-6")
  researchTechnology("cannon-shell-damage-4")
  researchTechnology("cannon-shell-damage-5")
  researchTechnology("cannon-shell-speed-4")
  researchTechnology("cannon-shell-speed-5")


  if self.returnValue == 9 then
    return
  end

--------------------------------------------------------------------------------
----- Infinite science research                                            -----
--------------------------------------------------------------------------------

  -- Science: research tehcnology
  researchTechnology("infinite-science-research")

  -- Unlock other science packs
  researchTechnology("infused-basic-science-research-1")
  researchTechnology("infused-basic-science-research-2")
  researchTechnology("infused-basic-science-research-3")
  researchTechnology("infused-advanced-science-research-1")
  researchTechnology("infused-advanced-science-research-2")
  researchTechnology("infused-basic-military-science-research")
  researchTechnology("infused-basic-automation-science-research")
  researchTechnology("infused-basic-logistics-science-research")
  researchTechnology("infused-basic-power-science-research")

  if self.returnValue == 10 then
    return
  end


end
