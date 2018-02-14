require 'util'

require 'src/settings'



function getBaseItemSlotButtonStyle()
  return util.table.deepcopy(
  {
    type = "button_style",
    parent = "button",
    scalable = false,
    width = 36,
    height = 36,
    top_padding = 1,
    right_padding = 1,
    bottom_padding = 1,
    left_padding = 1,
    default_graphical_set =
    {
      type = "monolith",
      top_monolith_border = 1,
      right_monolith_border = 1,
      bottom_monolith_border = 1,
      left_monolith_border = 1,
      monolith_image =
      {
        filename = "__core__/graphics/gui.png",
        priority = "extra-high-no-scale",
        width = 36,
        height = 36,
        x = 111
      }
    },
    hovered_graphical_set =
    {
      type = "monolith",
      top_monolith_border = 1,
      right_monolith_border = 1,
      bottom_monolith_border = 1,
      left_monolith_border = 1,
      monolith_image =
      {
        filename = "__core__/graphics/gui.png",
        priority = "extra-high-no-scale",
        width = 36,
        height = 36,
        x = 148
      }
    },
    clicked_graphical_set =
    {
      type = "monolith",
      top_monolith_border = 1,
      right_monolith_border = 1,
      bottom_monolith_border = 1,
      left_monolith_border = 1,
      monolith_image =
      {
        filename = "__core__/graphics/gui.png",
        priority = "extra-high-no-scale",
        width = 36,
        height = 36,
        x = 185
      }
    }
  })
end



function getBaseSelectButtonStyle(isSelected, dimensions, scalable)
  local selectButtonStyle =
    {
      type = "button_style",
      font = "default-button",
      default_font_color={r=1, g=1, b=1},
      align = "center",
      scalable = scalable,
      default_graphical_set =
      {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        priority = "extra-high-no-scale",
        corner_size = {3, 3},
        position = {0, 0}
      },
      hovered_font_color={r=1, g=1, b=1},
      hovered_graphical_set =
      {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        priority = "extra-high-no-scale",
        corner_size = {3, 3},
        position = {0, 8}
      },
      clicked_font_color={r=1, g=1, b=1},
      clicked_graphical_set =
      {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        priority = "extra-high-no-scale",
        corner_size = {3, 3},
        position = {0, 16}
      },
      disabled_font_color={r=0.5, g=0.5, b=0.5},
      disabled_graphical_set =
      {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        priority = "extra-high-no-scale",
        corner_size = {3, 3},
        position = {0, 0}
      }
    }

  for k, v in pairs(dimensions) do
    selectButtonStyle[k] = v
  end

  if isSelected then
    selectButtonStyle.default_graphical_set.position = {0, 16}
  end

  return util.table.deepcopy(selectButtonStyle)
end



function getBaseTextfieldStyle()
  return util.table.deepcopy(
  {
    type = "textfield_style",
    left_padding = 3,
    right_padding = 2,
    minimal_width = 85,
    font = "default",
    font_color = {},
    graphical_set =
    {
      type = "composition",
      filename = "__core__/graphics/gui.png",
      priority = "extra-high-no-scale",
      corner_size = {3, 3},
      position = {16, 0}
    },
    selection_background_color= {r=0.66, g=0.7, b=0.83}
  })
end



-- Upgrade button slots
data.raw["gui-style"].default["noitem"] = getBaseItemSlotButtonStyle()

local advancedCircuit = getBaseItemSlotButtonStyle()
advancedCircuit.default_graphical_set.monolith_image.filename = Settings.modName .. "/graphics/gui/advanced-circuit-default.png"
advancedCircuit.default_graphical_set.monolith_image.x = 0
advancedCircuit.hovered_graphical_set.monolith_image.filename = Settings.modName .. "/graphics/gui/advanced-circuit-hover.png"
advancedCircuit.hovered_graphical_set.monolith_image.x = 0
advancedCircuit.clicked_graphical_set.monolith_image.filename = Settings.modName .. "/graphics/gui/advanced-circuit-hover.png"
advancedCircuit.clicked_graphical_set.monolith_image.x = 0
data.raw["gui-style"].default["advanced-circuit"] = advancedCircuit

local processingUnit = getBaseItemSlotButtonStyle()
processingUnit.default_graphical_set.monolith_image.filename = Settings.modName .. "/graphics/gui/processing-unit-default.png"
processingUnit.default_graphical_set.monolith_image.x = 0
processingUnit.hovered_graphical_set.monolith_image.filename = Settings.modName .. "/graphics/gui/processing-unit-hover.png"
processingUnit.hovered_graphical_set.monolith_image.x = 0
processingUnit.clicked_graphical_set.monolith_image.filename = Settings.modName .. "/graphics/gui/processing-unit-hover.png"
processingUnit.clicked_graphical_set.monolith_image.x = 0
data.raw["gui-style"].default["processing-unit"] = processingUnit

-- Select buttons
local selectButtonDimensions =
  {
    top_padding = 3,
    right_padding = 3,
    bottom_padding = 3,
    left_padding = 3,
    minimal_width = 41,
    minimal_height = 41
  }
data.raw["gui-style"].default[Settings.guiSelectButtonStyle] = getBaseSelectButtonStyle(false, selectButtonDimensions)
data.raw["gui-style"].default[Settings.guiSelectButtonSelectedStyle] = getBaseSelectButtonStyle(true, selectButtonDimensions)

local smallSelectButtonDimensions =
  {
    width = 30,
    height = 30
  }
data.raw["gui-style"].default[Settings.guiSmallSelectButtonStyle] = getBaseSelectButtonStyle(false, smallSelectButtonDimensions, false)
data.raw["gui-style"].default[Settings.guiSmallSelectButtonSelectedStyle] = getBaseSelectButtonStyle(true, smallSelectButtonDimensions, false)

-- Text field
data.raw["gui-style"].default["distancetext"] = getBaseTextfieldStyle()
