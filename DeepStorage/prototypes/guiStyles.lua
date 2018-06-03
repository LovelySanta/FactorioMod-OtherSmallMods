require 'lib/utilities/util'
require 'src/settings'



local function dataExtend(dataTable)
  for _,dataElement in pairs(dataTable) do
    data.raw["gui-style"]["default"][dataElement.name] = deepcopy(dataElement)
  end
end



local guiFlowStyle_noHorizontalSpacing =
{
  type = "horizontal_flow_style",
  name = Settings.storageItemName .. "-guiFlow-noHorizontalSpacing",
  parent = "horizontal_flow",

  horizontal_spacing = 0,
}

local guiFlowStyle_noVerticalSpacing =
{
  type = "vertical_flow_style",
  name = Settings.storageItemName .. "-guiFlow-noVerticalSpacing",
  parent = "vertical_flow",

  vertical_spacing = 0,
}


local inventoryHorizontalSpacing =
{
  type = "horizontal_flow_style",
  name = Settings.storageItemName .. "-guiFlow-inventoryHorizontalSpacing",
  parent = "horizontal_flow",

  horizontal_spacing = 2,
}
local inventoryVerticalSpacing =
{
  type = "vertical_flow_style",
  name = Settings.storageItemName .. "-guiFlow-inventoryVerticalSpacing",
  parent = "vertical_flow",

  vertical_spacing = 2,
}
local inventoryVerticalSpacing =
{
  type = "vertical_flow_style",
  name = Settings.storageItemName .. "-guiFlow-inventoryVerticalSpacing",
  parent = "vertical_flow",

  vertical_spacing = 2,
}


dataExtend{
  guiFlowStyle_noHorizontalSpacing,
  guiFlowStyle_noVerticalSpacing,

  inventoryHorizontalSpacing,
  inventoryVerticalSpacing,
}
