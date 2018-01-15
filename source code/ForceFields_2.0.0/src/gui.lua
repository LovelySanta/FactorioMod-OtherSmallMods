require 'src/settings'
require 'src/emitter'


Gui = {}



Gui.guiElementNames =
{
  -- gui base
  guiFrame = "emitterConfig",
  configTable = "emitterConfigTable",

  -- Direction of forcefield
  directionLabel = "directionLabel",
  directionTable = "directions",
  directionOptionN = "directionN",
  directionOptionS = "directionS",
  directionOptionE = "directionE",
  directionOptionW = "directionW",

  -- Type of forcefield
  fieldTypeLabel = "fieldTypeLabel",
  fieldTypeTable = "fields",
  fieldTypeOptionB = "fieldB",
  fieldTypeOptionG = "fieldG",
  fieldTypeOptionR = "fieldR",
  fieldTypeOptionP = "fieldP",

  -- Distance of forcefield
  distanceLabel = "distanceLabel",
  distanceTable = "distance",
  distanceInput = "emitterDistance",
  distanceMaxInput = "emitterMaxDistance",

  -- Width of forcefield
  widthLabel = "currentWidthLabel",
  widthTable = "width",
  widthInput = "emitterWidth",
  widthMaxInput = "emitterMaxWidth",

  -- Upgrades of emitter
  upgradesLabel = "upgradesLabel",
  upgradesTable = "upgrades",
  upgradesDistance = "distanceUpgrades",
  upgradesWidth = "widthUpgrades",

  -- Bottom buttons
  buttonFrame = "buttonsFlow",
  buttonHelp = "emitterHelpButton",
  buttonRemoveUpgrades = "removeAllButton",
  buttonApplySettings = "applyButton"
}



function Gui.onOpenGui(self, emitter, playerIndex)
  local emitterTable = Emitter:findEmitter(emitter)
  if emitterTable ~= nil then
    game.players[playerIndex].opened = self:showEmitterGui(emitterTable, playerIndex)
  end
end



function Gui.onCloseGui(self, guiElement, playerIndex)
  if guiElement and guiElement.valid and guiElement.name == self.guiElementNames.guiFrame then
    game.print("closig ui")
    guiElement.destroy() -- TODO: needs to update the globals
  end
end



function Gui.showEmitterGui(self, emitterTable, playerIndex)
  game.print("opening UI")
  local guiCenter = game.players[playerIndex].gui.center
  local canOpenGui = true

  -- Check if someone else has this gui open at this moment
  if global.forcefields.emitterConfigGuis ~= nil then
    for index,player in pairs(game.players) do
      --if index ~= playerIndex then
        if global.forcefields.emitterConfigGuis["I" .. index] ~= nil and global.forcefields.emitterConfigGuis["I" .. index][1] == emitterTable then
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
    local frame = guiCenter.add({type = "frame", name = self.guiElementNames.guiFrame, caption = game.entity_prototypes[Settings.emitterName].localised_name, direction = "vertical", style = frame_caption_label})
    local configTable = frame.add({type ="table", name = self.guiElementNames.configTable, column_count = 2})

    -- Direction of forcefield
    configTable.add({type = "label", name = self.guiElementNames.directionLabel, caption = "Direction:                       "})
    local directions = configTable.add({type = "table", name = self.guiElementNames.directionTable, column_count = 4})
    local d1 = directions.add({type = "button", name = self.guiElementNames.directionOptionN, caption = "N", style = "selectbuttons"})
    local d2 = directions.add({type = "button", name = self.guiElementNames.directionOptionS, caption = "S", style = "selectbuttons"})
    local d3 = directions.add({type = "button", name = self.guiElementNames.directionOptionE, caption = "E", style = "selectbuttons"})
    local d4 = directions.add({type = "button", name = self.guiElementNames.directionOptionW, caption = "W", style = "selectbuttons"})

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
    configTable.add({type = "label", name = self.guiElementNames.fieldTypeLabel, caption = "Field type:"})
    local fields = configTable.add({type = "table", name = self.guiElementNames.fieldTypeTable, column_count = 4})
    local f1 = fields.add({type = "button", name = self.guiElementNames.fieldTypeOptionB, caption = "B", style = "selectbuttons"})
    local f2 = fields.add({type = "button", name = self.guiElementNames.fieldTypeOptionG, caption = "G", style = "selectbuttons"})
    local f3 = fields.add({type = "button", name = self.guiElementNames.fieldTypeOptionR, caption = "R", style = "selectbuttons"})
    local f4 = fields.add({type = "button", name = self.guiElementNames.fieldTypeOptionP, caption = "P", style = "selectbuttons"})

    if emitterTable["type"] == "blue" .. Settings.fieldSuffix then
      f1.style = "selectbuttonsselected"
    elseif emitterTable["type"] == "green" .. Settings.fieldSuffix then
      f2.style = "selectbuttonsselected"
    elseif emitterTable["type"] == "red" .. Settings.fieldSuffix then
      f3.style = "selectbuttonsselected"
    elseif emitterTable["type"] == "purple" .. Settings.fieldSuffix then
      f4.style = "selectbuttonsselected"
    end

    -- Distance of forcefield
    configTable.add({type = "label", name = self.guiElementNames.distanceLabel, caption = "Emitter distance:"})
    local distance = configTable.add({type = "table", name = self.guiElementNames.distanceTable, column_count = 2})
    distance.add({type = "textfield", name = self.guiElementNames.distanceInput, style = "distancetext"}).text = emitterTable["distance"]
    distance.add({type = "label", name = self.guiElementNames.distanceMaxInput, caption = "Max: " .. tostring(Settings.emitterDefaultDistance + self:getEmitterBonusDistance(emitterTable)), style = description_title_label})

    -- Width of forcefield
    configTable.add({type = "label", name = self.guiElementNames.widthLabel, caption = "Emitter width:"})
    local width = configTable.add({type = "table", name = self.guiElementNames.widthTable, column_count = 2})
    width.add({type = "textfield", name = self.guiElementNames.widthInput, style = "distancetext"}).text = emitterTable["width"]
    width.add({type = "label", name = self.guiElementNames.widthMaxInput, caption = "Max: " .. tostring(Settings.emitterDefaultWidth + self:getEmitterBonusWidth(emitterTable)), style = description_title_label})

    -- Upgrades of emitter
    configTable.add({type = "label", name = self.guiElementNames.upgradesLabel, caption = "Upgrades applied:"})
    local upgrades = configTable.add({type = "table", name = self.guiElementNames.upgradesTable, column_count = 2})
    if emitterTable["width-upgrades"] ~= 0 then
      upgrades.add({type = "button", name = self.guiElementNames.upgradesDistance, caption = "x" .. tostring(emitterTable["width-upgrades"]), style = "advanced-circuit"})
    else
      upgrades.add({type = "button", name = self.guiElementNames.upgradesDistance, caption = " ", style = "noitem"})
    end
    if emitterTable["distance-upgrades"] ~= 0 then
      upgrades.add({type = "button", name = self.guiElementNames.upgradesWidth, caption = "x" .. tostring(emitterTable["distance-upgrades"]), style = "processing-unit"})
    else
      upgrades.add({type = "button", name = self.guiElementNames.upgradesWidth, caption = " ", style = "noitem"})
    end

    -- Bottom buttons
    local buttonFlow = frame.add({type = "flow", name = self.guiElementNames.buttonFrame, direction = "horizontal"})
    buttonFlow.add({type = "button", name = self.guiElementNames.buttonHelp, caption = "?"})
    buttonFlow.add({type = "button", name = self.guiElementNames.buttonRemoveUpgrades, caption = "Remove all upgrades"})
    buttonFlow.add({type = "button", name = self.guiElementNames.buttonApplySettings, caption = "Apply"})

    -- Save gui
    if global.forcefields.emitterConfigGuis == nil then
      global.forcefields.emitterConfigGuis = {}
    end
    global.forcefields.emitterConfigGuis["I" .. playerIndex] = {}
    global.forcefields.emitterConfigGuis["I" .. playerIndex][1] = emitterTable

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
  [Gui.guiElementNames.directionOptionN] = Gui.handleGuiDirectionButtons,
  [Gui.guiElementNames.directionOptionS] = Gui.handleGuiDirectionButtons,
  [Gui.guiElementNames.directionOptionE] = Gui.handleGuiDirectionButtons,
  [Gui.guiElementNames.directionOptionW] = Gui.handleGuiDirectionButtons,

  [Gui.guiElementNames.fieldTypeOptionB] = Gui.handleGuiFieldTypeButtons,
  [Gui.guiElementNames.fieldTypeOptionG] = Gui.handleGuiFieldTypeButtons,
  [Gui.guiElementNames.fieldTypeOptionR] = Gui.handleGuiFieldTypeButtons,
  [Gui.guiElementNames.fieldTypeOptionP] = Gui.handleGuiFieldTypeButtons,

  [Gui.guiElementNames.upgradesDistance] = Gui.handleGuiUpgradeButtons,
  [Gui.guiElementNames.upgradesWidth] = Gui.handleGuiUpgradeButtons,

  [Gui.guiElementNames.buttonHelp] = Gui.handleGuiMenuButtons,
  [Gui.guiElementNames.buttonRemoveUpgrades] = Gui.handleGuiMenuButtons,
  [Gui.guiElementNames.buttonApplySettings] = Gui.handleGuiMenuButtons
}



function Gui.getEmitterBonusDistance(self, emitterTable)
  return emitterTable["distance-upgrades"]
end



function Gui.getEmitterBonusWidth(self, emitterTable)
  return emitterTable["width-upgrades"] * Settings.widthUpgradeMultiplier
end
