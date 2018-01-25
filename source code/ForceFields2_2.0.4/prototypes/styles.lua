local baseItemButton =
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
}

local selectbuttonsselected =
{
  type = "button_style",
  font = "default-button",
  default_font_color={r=1, g=1, b=1},
  align = "center",
  top_padding = 5,
  right_padding = 5,
  bottom_padding = 5,
  left_padding = 5,
  minimal_width = 32,
  default_graphical_set =
  {
    type = "composition",
    filename = "__core__/graphics/gui.png",
    priority = "extra-high-no-scale",
    corner_size = {3, 3},
    position = {0, 16}
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

local selectbuttons =
{
  type = "button_style",
  font = "default-button",
  default_font_color={r=1, g=1, b=1},
  align = "center",
  top_padding = 5,
  right_padding = 5,
  bottom_padding = 5,
  left_padding = 5,
  minimal_width = 32,
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

local distancetextfield_style =
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
}

local advancedCircuit = util.table.deepcopy(baseItemButton)
local processingUnit = util.table.deepcopy(baseItemButton)

advancedCircuit.default_graphical_set.monolith_image.filename = "__ForceFields2__/graphics/gui/advanced-circuit-default.png"
advancedCircuit.default_graphical_set.monolith_image.x = 0
advancedCircuit.hovered_graphical_set.monolith_image.filename = "__ForceFields2__/graphics/gui/advanced-circuit-hover.png"
advancedCircuit.hovered_graphical_set.monolith_image.x = 0
advancedCircuit.clicked_graphical_set.monolith_image.filename = "__ForceFields2__/graphics/gui/advanced-circuit-hover.png"
advancedCircuit.clicked_graphical_set.monolith_image.x = 0

processingUnit.default_graphical_set.monolith_image.filename = "__ForceFields2__/graphics/gui/processing-unit-default.png"
processingUnit.default_graphical_set.monolith_image.x = 0
processingUnit.hovered_graphical_set.monolith_image.filename = "__ForceFields2__/graphics/gui/processing-unit-hover.png"
processingUnit.hovered_graphical_set.monolith_image.x = 0
processingUnit.clicked_graphical_set.monolith_image.filename = "__ForceFields2__/graphics/gui/processing-unit-hover.png"
processingUnit.clicked_graphical_set.monolith_image.x = 0

data.raw["gui-style"].default["noitem"] = baseItemButton
data.raw["gui-style"].default["advanced-circuit"] = advancedCircuit
data.raw["gui-style"].default["processing-unit"] = processingUnit
data.raw["gui-style"].default["selectbuttons"] = selectbuttons
data.raw["gui-style"].default["selectbuttonsselected"] = selectbuttonsselected
data.raw["gui-style"].default["distancetext"] = distancetextfield_style
