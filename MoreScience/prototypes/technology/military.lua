require "lib/utilities/prototyping"

--------------------------------------------------------------------------------
----- Military                                                             -----
--------------------------------------------------------------------------------
addPrerequisiteTechnology("turrets", "military")
addPrerequisiteTechnology("stone-walls", "military")


--------------------------------------------------------------------------------
----- Military-2                                                           -----
--------------------------------------------------------------------------------
addPrerequisiteTechnology("military-2", "basic-science-research-1")
addPrerequisiteTechnology("bullet-damage-2", "military-2")
addPrerequisiteTechnology("bullet-speed-2", "military-2")
addPrerequisiteTechnology("gun-turret-damage-1", "military-2")


--------------------------------------------------------------------------------
----- Basic military science pack                                          -----
--------------------------------------------------------------------------------
-- remove recipe unlock from other technologies
removeRecipeUnlock("military-2", "military-science-pack")

-- create research for recipes
data:extend({
  {
    type = "technology",
    name = "basic-military-science-research",
    icon = "__MoreScience__/graphics/science-symbol.png",
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
        recipe = "military-science-pack"
      },
    },
    unit =
    {
      count = 30,
      ingredients = {
        {"science-pack-1", 2},
        {"science-pack-2", 2},
      },
      time = 5
    },
    upgrade = false,
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

removePrerequisiteTechnology("land-mine", "military-2")
addPrerequisiteTechnology("land-mine", "basic-military-science-research")

removePrerequisiteTechnology("combat-robotics", "military-2")
addPrerequisiteTechnology("combat-robotics", "basic-military-science-research")

removePrerequisiteTechnology("rocketry", "military-2")
addPrerequisiteTechnology("rocketry", "basic-military-science-research")

--removePrerequisiteTechnology("military-3", "military-2")
addPrerequisiteTechnology("military-3", "basic-military-science-research")

removePrerequisiteTechnology("grenade-damage-1", "military-2")
addPrerequisiteTechnology("grenade-damage-1", "basic-military-science-research")
