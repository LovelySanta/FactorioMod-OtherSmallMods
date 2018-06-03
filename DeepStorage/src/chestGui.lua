require 'src/settings'


ChestGui = {}



ChestGui.guiElementNames =
{
  -- GUI PARENT --
  ["guiFlow"] = Settings.storageGuiName,

  -- CHARACTER INVENTORY --
  ["characterInventoryFrame"] = "characterInventory",
    ["characterInventoryFlow"] = "characterInventoryFlow",
      ["characterInventoryRowFlow"] = "characterInventoryRowFlow",
        ["characterInventorySlot"] = "characterInventorySlot",

  -- MAIN GUI --
  ["mainGuiFlow"] = "mainGui",

  -- INVENTORY SLOTS
    ["chestTakeSlot"] = "chestTakeSlots",
      ["chestTakeSlot-label"] = "chestTakeSlot-label",
      ["chestTakeSlot-inventory"] = "chestTakeSlot-inventory",
    ["chestInsertSlot"] = "chestInsertSlots",
      ["chestInsertSlot-label"] = "chestInsertSlot-label",
      ["chestInsertSlot-inventory"] = "chestInsertSlot-inventory",



}



function ChestGui:onOpenGui(chestMonitor, playerIndex)
  game.players[playerIndex].opened = self:createPlayerGui(playerIndex)


end



function ChestGui:destroyPlayerGui(chestMonitor, chestGui, playerIndex)
  if chestGui and chestGui.valid and chestGui.name == self.guiElementNames["guiFlow"] then
    chestGui.destroy()
    return true -- correct gui
  else
    return false -- wrong gui
  end
end



function ChestGui:createPlayerGui(playerIndex)

  local chestGui = game.players[playerIndex].gui.center.add{
    type = "flow",
    name = self.guiElementNames["guiFlow"],
    direction = "horizontal",
    style = Settings.storageItemName .. "-guiFlow-noHorizontalSpacing"
  }

  -- CIRCUIT NETWORK --
  self:createPlayerInventory(chestGui)

  -- MAIN GUI --
  self:createMainGuiFrame(chestGui)

  game.players[playerIndex].opened = chestGui
end



function ChestGui:createPlayerInventory(parentElement)
  local playerInventory = game.players[parentElement.player_index].get_main_inventory()
  local slotsPerRow = 10

  local inventoryFlow = parentElement.add{
    type = "frame",
    name = self.guiElementNames["characterInventoryFrame"],
    direction = "vertical",
    style = "frame",
    caption = {"gui.character"}
  }
    .add{
      type = "flow",
      name = self.guiElementNames["characterInventoryFlow"],
      direction = "vertical",
      style = Settings.storageItemName .. "-guiFlow-inventoryVerticalSpacing",
    }

  for row = 1, math.ceil(#playerInventory / slotsPerRow), 1 do
    local inventoryRowFlow = inventoryFlow.add{
      type = "flow",
      name = self.guiElementNames["characterInventoryRowFlow"] .. "-" .. row,
      direction = "horizontal",
      style = Settings.storageItemName .. "-guiFlow-inventoryHorizontalSpacing",
    }

    for slot = 1 , math.min(slotsPerRow, #playerInventory - slotsPerRow * (row - 1)), 1 do
      local slotIndex = ((row - 1) * 10) + slot
      local inventorySlot = inventoryRowFlow.add{
        type = "sprite-button",
        name = self.guiElementNames["characterInventorySlot"] .. "-" .. slot,
      }

      if playerInventory.is_filtered() and playerInventory.get_filter(slotIndex) then
        inventorySlot.style = "slot_with_filter_button"

        local spritePath = "deepStorage-" .. playerInventory.get_filter(slotIndex) .. "-alphaSprite"
        log(spritePath)
        if game.players[parentElement.player_index].gui.is_valid_sprite_path(spritePath) then
          inventorySlot.sprite = spritePath
        end

      else
        inventorySlot.style = "slot_button"
      end

      local inventoryItemStack = playerInventory[slotIndex]
      if inventoryItemStack and inventoryItemStack.valid and inventoryItemStack.valid_for_read then
        inventorySlot.sprite = "item/" .. inventoryItemStack.name
        inventorySlot.number = "" .. inventoryItemStack.count
      end
    end


  end
end



function ChestGui:createMainGuiFrame(parentElement)
  return parentElement.add{
    type = "frame",
    name = self.guiElementNames["mainGuiFlow"],
    direction = "vertical",
    style = "frame",
    caption = {"item-name." .. Settings.storageItemName},
  }
    -- INVENTORY SLOTS
    .add{
      type = "flow",
      name = self.guiElementNames["chestTakeSlot"],
      direction = "horizontal",
    }
      .add{
        type = "label",
        name = self.guiElementNames["chestInsertSlot-label"],
      }.parent
      .add{
        type = "sprite-button",
        name = self.guiElementNames["chestInsertSlot-inventory"],
        style = "slot_button",
      }.parent
    .parent
    .add{
      type = "flow",
      name = self.guiElementNames["chestInsertSlot"],
      direction = "horizontal",
    }
      .add{
        type = "label",
        name = self.guiElementNames["chestInsertSlot-label"],
      }.parent
      .add{
        type = "sprite-button",
        name = self.guiElementNames["chestInsertSlot-inventory"],
        style = "slot_button",
      }.parent
    .parent

end
