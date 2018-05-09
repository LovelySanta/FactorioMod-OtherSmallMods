require "lib/utilities/prototyping"

--------------------------------------------------------------------------------
----- Military                                                             -----
--------------------------------------------------------------------------------
disableRecipe("light-armor")
addRecipeUnlock("military", "light-armor")
addPrerequisiteTechnology("turrets", "military")
addPrerequisiteTechnology("stone-walls", "military")



--------------------------------------------------------------------------------
----- Military-2: require green science                                    -----
--------------------------------------------------------------------------------
-- add science dependency
addPrerequisiteTechnology("military-2", "basic-science-research-1")

-- add other dependencies on military-2
addPrerequisiteTechnology("modular-armor", "military-2")

-- bonusses requiring green science now require military-2
addPrerequisiteTechnology("bullet-damage-2", "military-2")
addPrerequisiteTechnology("bullet-speed-2", "military-2")
addPrerequisiteTechnology("gun-turret-damage-1", "military-2")
addPrerequisiteTechnology("shotgun-shell-damage-2", "military-2")
addPrerequisiteTechnology("shotgun-shell-speed-2", "military-2")


--------------------------------------------------------------------------------
----- Basic military science pack (gray science)                           -----
--------------------------------------------------------------------------------
-- remove recipe unlock from other technologies
removeRecipeUnlock("military-2", "military-science-pack")

-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "basic-military-science-research",
    icon = "__MoreScience__/graphics/technology/science-symbol.png",
    icon_size = 2000,
    prerequisites = {
      "basic-science-research-1",
      "turrets",
      "military-2",
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "basic-military-science-fluid"
      },
      {
        type = "unlock-recipe",
        recipe = "military-science-pack"
      },
    },
    unit =
    {
      count = 30,
      ingredients = {
        {"science-pack-1", 2},
        {"science-pack-2", 3},
      },
      time = 5
    },
    order = "c-a"
  },
})
addPrerequisiteTechnology("bullet-damage-3", "basic-military-science-research")
addPrerequisiteTechnology("bullet-speed-4", "basic-military-science-research")
addPrerequisiteTechnology("gun-turret-damage-3", "basic-military-science-research")
addPrerequisiteTechnology("shotgun-shell-damage-3", "basic-military-science-research")
addPrerequisiteTechnology("shotgun-shell-speed-4", "basic-military-science-research")

-- requiring military science instead of military-2
removePrerequisiteTechnology("laser-turrets", "military-2")
addPrerequisiteTechnology("laser-turrets", "basic-military-science-research")
removePrerequisiteTechnology("flamethrower", "military-2")
addPrerequisiteTechnology("flamethrower", "basic-military-science-research")
removePrerequisiteTechnology("combat-robotics", "military-2")
addPrerequisiteTechnology("combat-robotics", "basic-military-science-research")
removePrerequisiteTechnology("rocketry", "military-2")
addPrerequisiteTechnology("rocketry", "basic-military-science-research")
removePrerequisiteTechnology("explosives", "military-2")
addPrerequisiteTechnology("explosives", "basic-military-science-research")
removePrerequisiteTechnology("grenade-damage-1", "military-2")
addPrerequisiteTechnology("grenade-damage-1", "basic-military-science-research")
--removePrerequisiteTechnology("military-3", "military-2")
addPrerequisiteTechnology("military-3", "basic-military-science-research")



--------------------------------------------------------------------------------
----- Military-3: require blue science                                     -----
--------------------------------------------------------------------------------
-- add science dependency
addPrerequisiteTechnology("military-3", "basic-science-research-2")

-- armor equipment
addPrerequisiteTechnology("energy-shield-mk2-equipment", "military-3")
addPrerequisiteTechnology("personal-laser-defense-equipment", "military-3")
addPrerequisiteTechnology("discharge-defense-equipment", "military-3")
addPrerequisiteTechnology("power-armor", "military-3")

-- bonusses requiring blue science now require military-3
addPrerequisiteTechnology("bullet-damage-5", "military-3")
addPrerequisiteTechnology("bullet-speed-5", "military-3")
addPrerequisiteTechnology("gun-turret-damage-5", "military-3")
addPrerequisiteTechnology("shotgun-shell-damage-5", "military-3")
addPrerequisiteTechnology("shotgun-shell-speed-5", "military-3")
addPrerequisiteTechnology("grenade-damage-4", "military-3")
addPrerequisiteTechnology("flamethrower-damage-3", "military-3")
addPrerequisiteTechnology("laser-turret-damage-3", "military-3")
addPrerequisiteTechnology("laser-turret-speed-3", "military-3")
addPrerequisiteTechnology("rocket-damage-3", "military-3")
addPrerequisiteTechnology("rocket-speed-3", "military-3")

addPrerequisiteTechnology("combat-robot-damage-3", "combat-robotics-2")
addPrerequisiteTechnology("follower-robot-count-3", "combat-robotics-2")



--------------------------------------------------------------------------------
----- Military-4: require yellow science                                   -----
--------------------------------------------------------------------------------
-- add science dependency
addPrerequisiteTechnology("military-4", "advanced-science-research-2")
-- add other dependencies
addPrerequisiteTechnology("military-4", "explosives")

-- armor equipment
addPrerequisiteTechnology("fusion-reactor-equipment", "military-4")
addPrerequisiteTechnology("personal-roboport-equipment-2", "military-4")
addPrerequisiteTechnology("power-armor-2", "military-4")

-- bonusses requiring yellow science now require military-4
addPrerequisiteTechnology("bullet-damage-6", "military-4")
addPrerequisiteTechnology("bullet-speed-6", "military-4")
addPrerequisiteTechnology("gun-turret-damage-6", "military-4")
addPrerequisiteTechnology("shotgun-shell-damage-6", "military-4")
addPrerequisiteTechnology("shotgun-shell-speed-6", "military-4")
addPrerequisiteTechnology("grenade-damage-6", "military-4")
addPrerequisiteTechnology("flamethrower-damage-5", "military-4")
addPrerequisiteTechnology("laser-turret-damage-5", "military-4")
addPrerequisiteTechnology("laser-turret-speed-5", "military-4")
addPrerequisiteTechnology("rocket-damage-6", "military-4")
addPrerequisiteTechnology("rocket-speed-6", "military-4")
addPrerequisiteTechnology("cannon-shell-damage-4", "military-4")
addPrerequisiteTechnology("cannon-shell-speed-4", "military-4")

addPrerequisiteTechnology("combat-robot-damage-5", "combat-robotics-3")
