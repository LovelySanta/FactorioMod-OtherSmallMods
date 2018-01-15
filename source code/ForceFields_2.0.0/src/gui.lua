require 'src/settings'
require 'src/emitter'


Gui = {}



function Gui.onOpenGui(self, emitter, playerIndex)
  local emitterTable = Emitter:findEmitter(emitter)
  if emitterTable ~= nil then
    game.players[playerIndex].opened = self:showEmitterGui(emitterTable, playerIndex)
  end
end



function Gui:onCloseGui(guiElement)
  if guiElement and guiElement.valid and guiElement.name == "emitterConfig" then
    game.print("closig ui")
    guiElement.destroy() -- TODO: needs to update the globals
  end
end



function Gui.showEmitterGui(self, emitterTable, playerIndex)
  game.print("opening UI")
  local guiCenter = game.players[playerIndex].gui.center
  local canOpenGui = true

  -- Check if someone else has this gui open at this moment
  if global.forcefields.emitterConfigGUIs ~= nil then
    for index,player in pairs(game.players) do
      --if index ~= playerIndex then
        if global.forcefields.emitterConfigGUIs["I" .. index] ~= nil and global.forcefields.emitterConfigGUIs["I" .. index][1] == emitterTable then
          if index ~= playerIndex then
            game.players[playerIndex].print(player.name .. " (player " .. index .. ") has the GUI for this emitter open right now.")
          end
          canOpenGui = false
          break
        end
      --end
    end
  end

  -- Create the gui
  if canOpenGui and guiCenter and guiCenter.emitterConfig == nil then
    local frame = guiCenter.add({type = "frame", name = "emitterConfig", caption = game.entity_prototypes[Settings.emitterName].localised_name, direction = "vertical", style = frame_caption_label})
    local configTable = frame.add({type ="table", name = "emitterConfigTable", column_count = 2})

    -- Directions
    configTable.add({type = "label", name = "directionLabel", caption = "Direction:                       "})
    local directions = configTable.add({type = "table", name = "directions", column_count = 4})
    local d1 = directions.add({type = "button", name = "directionN", caption = "N", style = "selectbuttons"})
    local d2 = directions.add({type = "button", name = "directionS", caption = "S", style = "selectbuttons"})
    local d3 = directions.add({type = "button", name = "directionE", caption = "E", style = "selectbuttons"})
    local d4 = directions.add({type = "button", name = "directionW", caption = "W", style = "selectbuttons"})

    if emitterTable["direction"] == defines.direction.north then
      d1.style = "selectbuttonsselected"
    elseif emitterTable["direction"] == defines.direction.south then
      d2.style = "selectbuttonsselected"
    elseif emitterTable["direction"] == defines.direction.east then
      d3.style = "selectbuttonsselected"
    elseif emitterTable["direction"] == defines.direction.south then
      d4.style = "selectbuttonsselected"
    end

    -- Type of forcefield
    configTable.add({type = "label", name = "fieldTypeLabel", caption = "Field type:"})
    local fields = configTable.add({type = "table", name = "fields", column_count = 4})
    local f1 = fields.add({type = "button", name = "fieldB", caption = "B", style = "selectbuttons"})
    local f2 = fields.add({type = "button", name = "fieldG", caption = "G", style = "selectbuttons"})
    local f3 = fields.add({type = "button", name = "fieldR", caption = "R", style = "selectbuttons"})
    local f4 = fields.add({type = "button", name = "fieldP", caption = "P", style = "selectbuttons"})

    if emitterTable["type"] == "blue" .. Settings.fieldSuffix then
      f1.style = "selectbuttonsselected"
    elseif emitterTable["type"] == "green" .. Settings.fieldSuffix then
      f2.style = "selectbuttonsselected"
    elseif emitterTable["type"] == "red" .. Settings.fieldSuffix then
      f3.style = "selectbuttonsselected"
    elseif emitterTable["type"] == "purple" .. Settings.fieldSuffix then
      f4.style = "selectbuttonsselected"
    end

    -- Distance
    configTable.add({type = "label", name = "distanceLabel", caption = "Emitter distance:"})
    local distance = configTable.add({type = "table", name = "distance", column_count = 2})
    distance.add({type = "textfield", name = "emitterDistance", style = "distancetext"}).text = emitterTable["distance"]
    distance.add({type = "label", name = "emitterMaxDistance", caption = "Max: " .. tostring(Settings.emitterDefaultDistance + self:getEmitterBonusDistance(emitterTable)), style = description_title_label})

    -- Width
    configTable.add({type = "label", name = "currentWidthLabel", caption = "Emitter width:"})
    local width = configTable.add({type = "table", name = "width", column_count = 2})
    width.add({type = "textfield", name = "emitterWidth", style = "distancetext"}).text = emitterTable["width"]
    width.add({type = "label", name = "emitterMaxWidth", caption = "Max: " .. tostring(Settings.emitterDefaultWidth + self:getEmitterBonusWidth(emitterTable)), style = description_title_label})

    -- Upgrades
    configTable.add({type = "label", name = "upgradesLabel", caption = "Upgrades applied:"})
    local upgrades = configTable.add({type = "table", name = "upgrades", column_count = 2})
    if emitterTable["width-upgrades"] ~= 0 then
      upgrades.add({type = "button", name = "distanceUpgrades", caption = "x" .. tostring(emitterTable["width-upgrades"]), style = "advanced-circuit"})
    else
      upgrades.add({type = "button", name = "distanceUpgrades", caption = " ", style = "noitem"})
    end
    if emitterTable["distance-upgrades"] ~= 0 then
      upgrades.add({type = "button", name = "widthUpgrades", caption = "x" .. tostring(emitterTable["distance-upgrades"]), style = "processing-unit"})
    else
      upgrades.add({type = "button", name = "widthUpgrades", caption = " ", style = "noitem"})
    end

    -- Bottom buttons
    local buttonFlow = frame.add({type = "flow", name = "buttonsFlow", direction = "horizontal"})
    buttonFlow.add({type = "button", name = "emitterHelpButton", caption = "?"})
    buttonFlow.add({type = "button", name = "removeAllButton", caption = "Remove all upgrades"})
    buttonFlow.add({type = "button", name = "applyButton", caption = "Apply"})

    -- Save gui
    if global.forcefields.emitterConfigGUIs == nil then
      global.forcefields.emitterConfigGUIs = {}
    end
    global.forcefields.emitterConfigGUIs["I" .. playerIndex] = {}
    global.forcefields.emitterConfigGUIs["I" .. playerIndex][1] = emitterTable

    return frame
  else
    return nil
  end
end



function Gui.handleGuiDirectionButtons(self, event)
  game.print("button pressed")
end



function Gui.handleGuiFieldTypeButtons(self, event)
  game.print("button pressed")
end



function Gui.handleGuiUpgradeButtons(self, event)
  game.print("button pressed")
end



function Gui.handleGuiMenuButtons(self, event)
  game.print("button pressed")
end



Gui.guiButtonHandlers =
{
  ["directionN"] = Gui.handleGuiDirectionButtons,
  ["directionS"] = Gui.handleGuiDirectionButtons,
  ["directionE"] = Gui.handleGuiDirectionButtons,
  ["directionW"] = Gui.handleGuiDirectionButtons,

  ["fieldB"] = Gui.handleGuiFieldTypeButtons,
  ["fieldG"] = Gui.handleGuiFieldTypeButtons,
  ["fieldR"] = Gui.handleGuiFieldTypeButtons,
  ["fieldP"] = Gui.handleGuiFieldTypeButtons,

  ["distanceUpgrades"] = Gui.handleGuiUpgradeButtons,
  ["widthUpgrades"] = Gui.handleGuiUpgradeButtons,

  ["emitterHelpButton"] = Gui.handleGuiMenuButtons,
  ["removeAllButton"] = Gui.handleGuiMenuButtons,
  ["applyButton"] = Gui.handleGuiMenuButtons
}



function Gui.getEmitterBonusDistance(self, emitterTable)
  return emitterTable["distance-upgrades"]
end



function Gui.getEmitterBonusWidth(self, emitterTable)
  return emitterTable["width-upgrades"] * Settings.widthUpgradeMultiplier
end
