data.raw.recipe["landfill"].enabled = false -- Disable landfill recipe

-- Edit the landfill research accordingly
local landfillTechnology = data.raw.technology["landfill"]

-- Edit the icon
landfillTechnology.icon = "__LandMover__/graphics/landmover_tech.png"
landfillTechnology.icon_size = 128

-- Disable the landfill recipe effect
if settings.startup["LM-disable-landfill-recipe"].value then
  for index, effect in pairs(landfillTechnology.effects) do
    if effect.type == "unlock-recipe" and effect.recipe == "landfill" then
      table.remove(landfillTechnology.effects, index)
      break
    end
  end
end

-- Add the new recipe effects to create landfill
table.insert(landfillTechnology.effects,
  {
    type = "unlock-recipe",
    recipe = "landmover"
  })
table.insert(landfillTechnology.effects,
  {
    type = "unlock-recipe",
    recipe = "landmover-shovel"
  })

-- Add the required prerequisites
if not landfillTechnology.prerequisites then
  landfillTechnology.prerequisites = {}
end
table.insert(landfillTechnology.prerequisites, "concrete")

-- Edit the data.raw to updated landfill version
data.raw.technology["landfill"] = landfillTechnology



data:extend({
  {
    type = "item",
    name = "landmover-shovel",
    icon = "__LandMover__/graphics/shovel.png",
    icon_size = 32,
    flags = {"goes-to-main-inventory"},
    subgroup = "tool",
    order = "a[mining]-c[shovel]",
    stack_size = 20
  },

  {
    type = "item",
    name = "landmover",
    icon = "__LandMover__/graphics/landmover_ent.png",
    icon_size = 64,
    flags = {"goes-to-main-inventory"},
    subgroup = "terrain",
    order = "c[landfill]-a[dirt]",
    stack_size = 100,
    place_as_tile =
    {
      result = "water",
      condition_size = 1,
      condition = { "water-tile" }
    }
  },

  {
    type = "recipe",
    name = "landmover-shovel",
    enabled = false,
    ingredients =
    {
    {type="item", name="iron-stick", amount=5},
    {type="item", name="steel-plate", amount=3},
    },
    energy_required = 5,
    result= "landmover-shovel",
    result_count = 1
  },

  {
    type = "recipe",
    name = "landmover",
    energy_required = 10,
    enabled = false,
    category = "crafting-with-fluid",
    ingredients =
    {
    {type="item", name="landmover-shovel", amount=1},
    {type="item", name="steel-plate", amount=5},
    {type="item", name="concrete", amount=20},
    },
    energy_required = 10,
    result= "landmover",
    result_count = 100
  },
})
