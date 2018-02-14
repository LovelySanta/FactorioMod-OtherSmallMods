require 'src/settings'



function getForceFieldBaseItem()
  return
  {
    type = "item",
    name = "",
    icon = "",
    icon_size = nil,
    flags = {"goes-to-quickbar"},
    subgroup = "forcefields",
    order = "f[forcefield-wall]",
    place_result = "",
    stack_size = 1
  }
end



function getForceFieldbaseRecipe()
  return
  {
    type = "recipe",
    name = "",
    enabled = "false",
    energy_required = nil,
    ingredients = {nil},
    result = ""
  }
end



function createTechWallEffect(color)
  local imgDir = Settings.modName .. "/graphics/walls/"
  local fieldSuffix = Settings.fieldSuffix

  local item = util.table.deepcopy(getForceFieldBaseItem())
  item.name = color .. fieldSuffix
  item.icon = imgDir .. color .. "/wall-icon.png"
  item.icon_size = 42
  item.place_result = color .. fieldSuffix

  local recipe = util.table.deepcopy(getForceFieldbaseRecipe())
  recipe.name = color .. fieldSuffix
  recipe.energy_required = math.floor(Settings.forcefieldTypes[recipe.name]["chargeRate"] * Settings.tickRate * 100)/100
  recipe.result = color .. fieldSuffix

  data:extend({item, recipe})

  return
  {
    type = "unlock-recipe",
    recipe = recipe.name
  }
end



function createTechGateEffect(color)
  local imgDir = Settings.modName .. "/graphics/gates/"
  local fieldGateSuffix = Settings.fieldGateSuffix

  local item = util.table.deepcopy(getForceFieldBaseItem())
  item.name = color .. fieldGateSuffix
  item.icon = imgDir .. color .. "/gate-icon.png"
  item.icon_size = 32
  item.place_result = color .. fieldGateSuffix

  local recipe = util.table.deepcopy(getForceFieldbaseRecipe())
  recipe.name = color .. fieldGateSuffix
  recipe.energy_required = math.floor(Settings.forcefieldTypes[recipe.name]["chargeRate"] * Settings.tickRate * 100)/100
  recipe.result = color .. fieldGateSuffix

  data:extend({item, recipe})

  return
  {
    type = "unlock-recipe",
    recipe = recipe.name
  }
end
