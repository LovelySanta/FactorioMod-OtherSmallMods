require 'src/settings'
require 'src/utilities'

require 'src/forcefield'
require 'src/emitter'


Gui = {}



Gui.guiElementNames =
{
  -- EMITTER GUI --
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
  buttonConfigure = "configureWallButton",
  buttonApplySettings = "applyButton",

  -- FORCEFIELD GUI --
  -- Gui base
  configFrame = "fieldConfig",
  configTableFrame = "fieldConfigTable",

  -- Wall table row header
  configTableHeader = "fieldConfigTableHeader",
  configRowOptionLabel = "fieldConfigRowLabel",
  configRowOption = "fieldConfigRowOption",
  configRowDescriptionLabel = "fieldConfigRowDescriptionLabel",

  -- Wall table row data
  configTableSlider = "fieldConfigSlider",
  configTableData = "fieldConfigTableData",
  configOptionLabel = "fieldConfigOptionLabel",
  configOption = "fieldConfigOption",

  -- Bottom buttons
  configButtonFrame = "fieldConfigButtons",
  configButtonAlign = "fieldConfigButtonsAlign",
  configCancelButton = "fieldConfigButtonsCancel",
  configApplyButton = "fieldConfigButtonsApply",
}



function Gui:onOpenGui(emitter, playerIndex)
  local emitterTable = Emitter:findEmitter(emitter)
  if emitterTable ~= nil then
    game.players[playerIndex].opened = self:showEmitterGui(emitterTable, playerIndex)
  end
end



function Gui:onCloseGui(guiElement, playerIndex)
  if guiElement and guiElement.valid and guiElement.name == self.guiElementNames.guiFrame then
    if global.forcefields.emitterConfigGuis["I" .. playerIndex] ~= nil then
      -- Check the upgrade items
      if global.forcefields.emitterConfigGuis["I" .. playerIndex][1]["entity"].valid then
        local emitterTable = global.forcefields.emitterConfigGuis["I" .. playerIndex][1]
        local upgrades = guiElement[self.guiElementNames.configTable][self.guiElementNames.upgradesTable]

        -- Distance upgrades
        local oldDistanceUpgrades = emitterTable["distance-upgrades"]
        local newDistanceUpgrades = tonumber(string.sub(upgrades[self.guiElementNames.upgradesDistance].caption, 2))
        if not newDistanceUpgrades then
          newDistanceUpgrades = 0
        end
        if newDistanceUpgrades ~= oldDistanceUpgrades then
          if newDistanceUpgrades > oldDistanceUpgrades then
            transferToPlayer(game.players[playerIndex], {name = "advanced-circuit", count = newDistanceUpgrades - oldDistanceUpgrades})
          else
            takeFromPlayer(game.players[playerIndex], {name = "advanced-circuit", count = oldDistanceUpgrades - newDistanceUpgrades})
          end
        end

        -- Width upgrades
        local oldWidthUpgrades = emitterTable["width-upgrades"]
        local newWidthUpgrades = tonumber(string.sub(upgrades[self.guiElementNames.upgradesWidth].caption, 2))
        if not newWidthUpgrades then
          newWidthUpgrades = 0
        end
        if newWidthUpgrades ~= oldWidthUpgrades then
          if newWidthUpgrades > oldWidthUpgrades then
            transferToPlayer(game.players[playerIndex], {name = "processing-unit", count = newWidthUpgrades - oldWidthUpgrades})
          else
            takeFromPlayer(game.players[playerIndex], {name = "processing-unit", count = oldWidthUpgrades - newWidthUpgrades})
          end
        end
      end

      -- Delete the gui data now...
      global.forcefields.emitterConfigGuis["I" .. playerIndex] = nil
    end
    if tableIsEmpty(global.forcefields.emitterConfigGuis) then
      global.forcefields.emitterConfigGuis = nil
    end
    if game.players[playerIndex].gui.center[self.guiElementNames.configFrame] then
      game.players[playerIndex].gui.center[self.guiElementNames.configFrame].destroy()
    end
    guiElement.destroy()
  end
end



function Gui:showEmitterGui(emitterTable, playerIndex)
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
    local frame = guiCenter.add{type = "frame", name = self.guiElementNames.guiFrame, caption = game.entity_prototypes[Settings.emitterName].localised_name, direction = "vertical", style = frame_caption_label}
    local configTable = frame.add{type ="table", name = self.guiElementNames.configTable, column_count = 2}

    -- Direction of forcefield
    configTable.add{type = "label", name = self.guiElementNames.directionLabel, caption = "Direction:                       "}
    local directions = configTable.add{type = "table", name = self.guiElementNames.directionTable, column_count = 4}
    local d1 = directions.add{type = "sprite-button", name = self.guiElementNames.directionOptionN, style = Settings.guiSelectButtonStyle, sprite = "virtual-signal/signal-N"}
    local d2 = directions.add{type = "sprite-button", name = self.guiElementNames.directionOptionS, style = Settings.guiSelectButtonStyle, sprite = "virtual-signal/signal-S"}
    local d3 = directions.add{type = "sprite-button", name = self.guiElementNames.directionOptionE, style = Settings.guiSelectButtonStyle, sprite = "virtual-signal/signal-E"}
    local d4 = directions.add{type = "sprite-button", name = self.guiElementNames.directionOptionW, style = Settings.guiSelectButtonStyle, sprite = "virtual-signal/signal-W"}

    if emitterTable["direction"] == defines.direction.north then
      d1.style = Settings.guiSelectButtonSelectedStyle
    elseif emitterTable["direction"] == defines.direction.south then
      d2.style = Settings.guiSelectButtonSelectedStyle
    elseif emitterTable["direction"] == defines.direction.east then
      d3.style = Settings.guiSelectButtonSelectedStyle
    elseif emitterTable["direction"] == defines.direction.west then
      d4.style = Settings.guiSelectButtonSelectedStyle
    end

    -- Type of forcefield
    configTable.add{type = "label", name = self.guiElementNames.fieldTypeLabel, caption = "Field type:"}
    local fields = configTable.add{type = "table", name = self.guiElementNames.fieldTypeTable, column_count = 4}
    local f1 = fields.add{type = "sprite-button", name = self.guiElementNames.fieldTypeOptionB, sprite = "item/blue" .. Settings.fieldSuffix, style = Settings.guiSelectButtonStyle}
    local f2 = fields.add{type = "sprite-button", name = self.guiElementNames.fieldTypeOptionG, sprite = "item/green" .. Settings.fieldSuffix, style = Settings.guiSelectButtonStyle}
    local f3 = fields.add{type = "sprite-button", name = self.guiElementNames.fieldTypeOptionR, sprite = "item/red" .. Settings.fieldSuffix, style = Settings.guiSelectButtonStyle}
    local f4 = fields.add{type = "sprite-button", name = self.guiElementNames.fieldTypeOptionP, sprite = "item/purple" .. Settings.fieldSuffix, style = Settings.guiSelectButtonStyle}

    if emitterTable["type"] == "blue" then
      f1.style = Settings.guiSelectButtonSelectedStyle
    elseif emitterTable["type"] == "green" then
      f2.style = Settings.guiSelectButtonSelectedStyle
    elseif emitterTable["type"] == "red" then
      f3.style = Settings.guiSelectButtonSelectedStyle
    elseif emitterTable["type"] == "purple" then
      f4.style = Settings.guiSelectButtonSelectedStyle
    end

    -- Distance of forcefield
    configTable.add{type = "label", name = self.guiElementNames.distanceLabel, caption = "Emitter distance:"}
    local distance = configTable.add{type = "table", name = self.guiElementNames.distanceTable, column_count = 2}
    distance.add{type = "textfield", name = self.guiElementNames.distanceInput, style = "distancetext"}.text = emitterTable["distance"]
    distance.add{type = "label", name = self.guiElementNames.distanceMaxInput, caption = "Max: " .. tostring(Settings.emitterDefaultDistance + emitterTable["distance-upgrades"]), style = description_title_label}

    -- Width of forcefield
    configTable.add{type = "label", name = self.guiElementNames.widthLabel, caption = "Emitter width:"}
    local width = configTable.add{type = "table", name = self.guiElementNames.widthTable, column_count = 2}
    width.add{type = "textfield", name = self.guiElementNames.widthInput, style = "distancetext"}.text = emitterTable["width"]
    width.add{type = "label", name = self.guiElementNames.widthMaxInput, caption = "Max: " .. tostring(Settings.emitterDefaultWidth + emitterTable["width-upgrades"] * Settings.widthUpgradeMultiplier), style = description_title_label}

    -- Upgrades of emitter
    configTable.add{type = "label", name = self.guiElementNames.upgradesLabel, caption = "Upgrades applied:"}
    local upgrades = configTable.add{type = "table", name = self.guiElementNames.upgradesTable, column_count = 2}
    if emitterTable["distance-upgrades"] ~= 0 then
      upgrades.add{type = "button", name = self.guiElementNames.upgradesDistance, caption = "x" .. tostring(emitterTable["distance-upgrades"]), style = "advanced-circuit"}
    else
      upgrades.add{type = "button", name = self.guiElementNames.upgradesDistance, caption = " ", style = "noitem"}
    end
    if emitterTable["width-upgrades"] ~= 0 then
      upgrades.add{type = "button", name = self.guiElementNames.upgradesWidth, caption = "x" .. tostring(emitterTable["width-upgrades"]), style = "processing-unit"}
    else
      upgrades.add{type = "button", name = self.guiElementNames.upgradesWidth, caption = " ", style = "noitem"}
    end

    -- Bottom buttons
    local buttonFlow = frame.add{type = "flow", name = self.guiElementNames.buttonFrame, direction = "horizontal"}
    buttonFlow.add{type = "button", name = self.guiElementNames.buttonHelp, caption = "?"}
    buttonFlow.add{type = "button", name = self.guiElementNames.buttonRemoveUpgrades, caption = "Remove all upgrades"}
    buttonFlow.add{type = "sprite-button", name = self.guiElementNames.buttonConfigure, sprite = "entity/" .. Settings.configWallIconName, style = Settings.guiSelectButtonStyle}
    buttonFlow.add{type = "button", name = self.guiElementNames.buttonApplySettings, caption = "Apply"}

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



function Gui:createForcefieldGui(playerIndex, fieldWidth)
  local player = game.players[playerIndex]
  local emitterTable = global.forcefields.emitterConfigGuis["I" .. playerIndex][1]
  local guiCenter = player.gui.center
  local configTableSlider
  if guiCenter and guiCenter[self.guiElementNames.guiFrame] then
    if not guiCenter[self.guiElementNames.configFrame] then
      -- If config gui doesn't exist yet we have to make it
      local frame = guiCenter.add{type = "frame", name = self.guiElementNames.configFrame, caption = game.entity_prototypes[Settings.emitterName].localised_name, direction = "vertical", style = frame_caption_label}

      -- Table for wall config
      local configTable = frame.add{type = "flow", name = self.guiElementNames.configTableFrame, direction = "horizontal"}

      -- Table row headers
      local configTableHeader = configTable.add{type = "table", name = self.guiElementNames.configTableHeader, column_count = 2}
      configTableHeader.style.column_alignments[1] = "center"
      configTableHeader.style.column_alignments[2] = "right"
      configTableHeader.add{type = "label", name = self.guiElementNames.configRowOptionLabel, caption = "All"}
      configTableHeader.add{type = "label", name = self.guiElementNames.configRowDescriptionLabel, caption = ""}
      configTableHeader.add{type = "sprite-button", name = self.guiElementNames.configRowOption .. "E", sprite = "utility/set_bar_slot", style = Settings.guiSmallSelectButtonStyle}
      configTableHeader.add{type = "label", name = self.guiElementNames.configRowDescriptionLabel .. "E", caption = "   empty   "}
      configTableHeader.add{type = "sprite-button", name = self.guiElementNames.configRowOption .. "W", sprite = "item/stone-wall", style = Settings.guiSmallSelectButtonStyle}
      configTableHeader.add{type = "label", name = self.guiElementNames.configRowDescriptionLabel .. "W", caption = "wall   "}
      configTableHeader.add{type = "sprite-button", name = self.guiElementNames.configRowOption .. "G", sprite = "item/gate", style = Settings.guiSmallSelectButtonStyle}
      configTableHeader.add{type = "label", name = self.guiElementNames.configRowDescriptionLabel .. "G", caption = "gate   "}

      -- Table row data
      configTableSlider = configTable.add{type = "scroll-pane", name = self.guiElementNames.configTableSlider, horizontal_scroll_policy = "auto", vertical_scroll_policy = "never"}
      configTableSlider.style.maximal_width = math.floor(player.display_resolution.width/2)

      -- Buttons on the bottom (cancel, save)
      local buttonFrame = frame.add{type = "table", name = self.guiElementNames.configButtonFrame, column_count = 3}
      buttonFrame.style.horizontally_stretchable = true
      local buttonAlign = buttonFrame.add{type = "flow", name = self.guiElementNames.configButtonAlign, direction = "horizontal"}
      buttonAlign.style.horizontally_stretchable = true
      buttonFrame.add{type = "button", name = self.guiElementNames.configCancelButton, caption = "Cancel changes"}
      buttonFrame.add{type = "button", name = self.guiElementNames.configApplyButton, caption = "Save configuration"}
    else -- gui already exist, now we have to recreate it if needed
      local frame = guiCenter[self.guiElementNames.configFrame]
      frame.style.visible = true
      configTableSlider = frame[self.guiElementNames.configTableFrame][self.guiElementNames.configTableSlider]
      -- recreate the gui
      configTableSlider[self.guiElementNames.configTableData].destroy()
    end

    local configTableData = configTableSlider.add{type ="table", name = self.guiElementNames.configTableData, column_count = fieldWidth}
    for fieldIndex=1, fieldWidth do
      configTableData.style.column_alignments[fieldIndex] = "center"
    end
    for fieldIndex=1, fieldWidth do
      configTableData.add{type = "label", name = self.guiElementNames.configOptionLabel ..string.format("%02d", fieldIndex), caption = string.format("%02d", fieldIndex)}
    end
    for fieldIndex=1, fieldWidth do
      configTableData.add{type = "sprite-button", name = self.guiElementNames.configOption .. "E" .. string.format("%02d", fieldIndex), sprite = "utility/pump_cannot_connect_icon", style = Settings.guiSmallSelectButtonStyle}
    end
    for fieldIndex=1, fieldWidth do
      configTableData.add{type = "sprite-button", name = self.guiElementNames.configOption .. "W" .. string.format("%02d", fieldIndex), sprite = "utility/pump_cannot_connect_icon", style = Settings.guiSmallSelectButtonStyle}
    end
    for fieldIndex=1, fieldWidth do
      configTableData.add{type = "sprite-button", name = self.guiElementNames.configOption .. "G" .. string.format("%02d", fieldIndex), sprite = "utility/pump_cannot_connect_icon", style = Settings.guiSmallSelectButtonStyle}
    end

    -- Select the correct setting for each wall
    local fieldOffset = (fieldWidth + 1)/2
    local emitterWallConfigTable = emitterTable["config"]
    for fieldIndex = 1, fieldWidth do
      local type = emitterWallConfigTable[fieldIndex-fieldOffset]
      if type == Settings.fieldSuffix then
        configTableData[self.guiElementNames.configOption .. "W" .. string.format("%02d", fieldIndex)].style = Settings.guiSmallSelectButtonSelectedStyle
      elseif type == Settings.fieldGateSuffix then
        configTableData[self.guiElementNames.configOption .. "G" .. string.format("%02d", fieldIndex)].style = Settings.guiSmallSelectButtonSelectedStyle
      else
        configTableData[self.guiElementNames.configOption .. "E" .. string.format("%02d", fieldIndex)].style = Settings.guiSmallSelectButtonSelectedStyle
      end
    end
  end
end



function Gui:handleGuiDirectionButtons(event)
  local playerIndex = event.element.player_index
  local player = game.players[playerIndex]
  local frame = player.gui.center[self.guiElementNames.guiFrame]
  local nameToDirection =
  {
    [self.guiElementNames.directionOptionN] = defines.direction.north,
    [self.guiElementNames.directionOptionS] = defines.direction.south,
    [self.guiElementNames.directionOptionE] = defines.direction.east,
    [self.guiElementNames.directionOptionW] = defines.direction.west
  }

  if frame ~= nil then
    local directions = frame[self.guiElementNames.configTable][self.guiElementNames.directionTable]

    -- Save the newly selected direction
    global.forcefields.emitterConfigGuis["I" .. playerIndex][2] = nameToDirection[event.element.name]

    -- Set the buttons accordingly to pressed selection
    directions[self.guiElementNames.directionOptionN].style = Settings.guiSelectButtonStyle
    directions[self.guiElementNames.directionOptionS].style = Settings.guiSelectButtonStyle
    directions[self.guiElementNames.directionOptionE].style = Settings.guiSelectButtonStyle
    directions[self.guiElementNames.directionOptionW].style = Settings.guiSelectButtonStyle
    directions[event.element.name].style = Settings.guiSelectButtonSelectedStyle
  end
end



function Gui:handleGuiFieldTypeButtons(event)
  local playerIndex = event.element.player_index
  local player = game.players[playerIndex]
  local force = player.force
  local frame = player.gui.center[self.guiElementNames.guiFrame]
  local nameToFieldName =
  {
    [self.guiElementNames.fieldTypeOptionB] = "blue",
    [self.guiElementNames.fieldTypeOptionG] = "green",
    [self.guiElementNames.fieldTypeOptionR] = "red",
    [self.guiElementNames.fieldTypeOptionP] = "purple"
  }

  if frame ~= nil then
    -- Current fieldtype
    local fields = frame[self.guiElementNames.configTable][self.guiElementNames.fieldTypeTable]
    local selectedButtonName = event.element.name

    -- Check if the force of that player has the required researched
    local shouldSwitch = true
    if selectedButtonName == self.guiElementNames.fieldTypeOptionG then
      shouldSwitch = force.technologies["green-fields"].researched
    elseif selectedButtonName == self.guiElementNames.fieldTypeOptionR then
      shouldSwitch = force.technologies["red-fields"].researched
    elseif selectedButtonName == self.guiElementNames.fieldTypeOptionP then
      shouldSwitch = force.technologies["purple-fields"].researched
    end

    if shouldSwitch then
      -- Save the newly selected direction
      global.forcefields.emitterConfigGuis["I" .. playerIndex][3] = nameToFieldName[selectedButtonName]

      -- Set the buttons accordingly to pressed selection
      fields[self.guiElementNames.fieldTypeOptionB].style = Settings.guiSelectButtonStyle
      fields[self.guiElementNames.fieldTypeOptionG].style = Settings.guiSelectButtonStyle
      fields[self.guiElementNames.fieldTypeOptionR].style = Settings.guiSelectButtonStyle
      fields[self.guiElementNames.fieldTypeOptionP].style = Settings.guiSelectButtonStyle
      fields[selectedButtonName].style = Settings.guiSelectButtonSelectedStyle
    else
      player.print("You need to complete the required research before this field type can be used.")
    end
  end
end



function Gui:handleGuiUpgradeButtons(event)
  local playerIndex = event.element.player_index
  local player = game.players[playerIndex]
  local frame = player.gui.center[self.guiElementNames.guiFrame]
  local nameToUpgradeLimit =
  {
    [self.guiElementNames.upgradesDistance] = Settings.maxRangeUpgrades,
    [self.guiElementNames.upgradesWidth] = Settings.maxWidthUpgrades
  }
  local nameToStyle =
  {
    [self.guiElementNames.upgradesDistance] = "advanced-circuit",
    [self.guiElementNames.upgradesWidth] = "processing-unit"
  }
  local styleToName = {}
  for k,v in pairs(nameToStyle) do
    styleToName[v] = k
  end

  if frame ~= nil then
    local upgrades = frame[self.guiElementNames.configTable][self.guiElementNames.upgradesTable]
    local upgradeButton
    local count

    -- Check if the player has items on his cursor => increase upgrades
    local stack = player.cursor_stack
    if stack.valid_for_read then
      if styleToName[stack.name] ~= nil then
        upgradeButton = upgrades[styleToName[stack.name]]
        -- Add one to the upgrades
        if upgradeButton.caption ~= " " then
          count = tonumber(string.sub(upgradeButton.caption, 2)) + 1
        else
          count = 1
        end

        -- Update the gui if it didn't exceeded the max limit
        if count <= nameToUpgradeLimit[upgradeButton.name] then
          upgradeButton.caption = "x" .. tostring(count)
          self:updateMaxLabel(frame, upgradeButton)

          -- If this is the first item we need to change the style too
          if count == 1 then
            upgradeButton.style = nameToStyle[upgradeButton.name]
          end

          -- Remove one item from the players cursos
          stack.count = stack.count - 1
        else
          player.print("Maximum upgrades of this type already installed.")
        end
      end
    else -- player has an empty cursor => decrease upgrades
      upgradeButton = upgrades[event.element.name]

      if upgradeButton.caption ~= " " then
        count = tonumber(string.sub(upgradeButton.caption, 2)) - 1

        if count == 0 then
          upgradeButton.caption = " "
          -- if count is zero we need to change the style too
          upgradeButton.style = "noitem"
        else
          upgradeButton.caption = "x" .. tostring(count)
        end

        self:updateMaxLabel(frame, upgradeButton)
        transferToPlayer(player, {name = nameToStyle[upgradeButton.name], count = 1})
      end
    end
  end
end



function Gui:handleConfigureButton(event)
  -- get the width of the emitter, needed for the gui...
  local player = game.players[event.player_index]
  local guiCenter = player.gui.center
  local emitterConfigTable = guiCenter[self.guiElementNames.guiFrame][self.guiElementNames.configTable]

  local width = tonumber(emitterConfigTable[self.guiElementNames.widthTable][self.guiElementNames.widthInput].text)
  local maxWidth = tonumber(string.sub(emitterConfigTable[self.guiElementNames.widthTable][self.guiElementNames.widthMaxInput].caption, 6))
  local settingsAreGood = true

  if not width then
    player.print("New Width is not a valid number.")
    settingsAreGood = false
  elseif width > maxWidth then
    player.print("New Width is larger than the allowed maximum.")
    settingsAreGood = false
  elseif width < 1 then
    player.print("New Width is smaller than the allowed minimum (1).")
    settingsAreGood = false
  elseif math.floor(width) ~= width then
    player.print("New Width is not a valid number (can't have decimals).")
    settingsAreGood = false
  elseif (math.floor((width - 1) / 2) * 2) + 1 ~= width then
    player.print("New Width has to be an odd number.")
    emitterConfigTable[self.guiElementNames.widthTable][self.guiElementNames.widthInput].text = tostring((math.floor((width - 1) / 2) * 2) + 1)
    settingsAreGood = false
  end

  if settingsAreGood then
    -- We need to configure the wall/gates for this wall, depending on the current settings in the gui
    self:createForcefieldGui(event.player_index, width)
    -- It opened the configGui, now make the emitterGui invisible
    guiCenter[self.guiElementNames.guiFrame].style.visible = false
  end
end



function Gui:handleGuiMenuButtons(event)
  local playerIndex = event.player_index
  local player = game.players[playerIndex]
  local guiCenter = player.gui.center
  local frame = guiCenter[self.guiElementNames.guiFrame]
  if frame ~= nil then
    -- Apply button
    if event.element.name == self.guiElementNames.buttonApplySettings then
      if self:verifyAndSetFromGui(playerIndex) then
        -- Close the gui in the data
        global.forcefields.emitterConfigGuis["I" .. playerIndex] = nil
        if tableIsEmpty(global.forcefields.emitterConfigGuis) then
          global.forcefields.emitterConfigGuis = nil
        end
        -- Close the gui visualy
        if guiCenter[self.guiElementNames.configFrame] then
          guiCenter[self.guiElementNames.configFrame].destroy()
        end
        frame.destroy()
      end
    -- Help button
  elseif event.element.name == self.guiElementNames.buttonHelp then
      self:printGuiHelp(player)
    -- Remove upgrades buttons
  elseif event.element.name == self.guiElementNames.buttonRemoveUpgrades then
      self:removeAllUpgrades(playerIndex)
    end
  end
end



function Gui:handleGuiConfigWallChange(event)
  -- Get the button info
  local buttonId = string.sub(event.element.name, -3)
  local fieldConfig = string.sub(buttonId,1,1)
  local fieldIndex = string.sub(buttonId, -2)

  -- If its a gate, check if we have the required research
  if fieldConfig == "G" then
    local playerIndex = event.player_index
    local player = game.players[playerIndex]
    local force = player.force
    local fieldType
    if global.forcefields.emitterConfigGuis["I" .. playerIndex][3] ~= nil then
      fieldType = global.forcefields.emitterConfigGuis["I" .. playerIndex][3]
    else
      fieldType = global.forcefields.emitterConfigGuis["I" .. playerIndex][1]["type"]
    end

    if fieldType == "blue" and not force.technologies["force-field-gates"].researched
      or fieldType == "green" and not force.technologies["green-field-gates"].researched
      or fieldType == "purple" and not force.technologies["purple-field-gates"].researched
      or fieldType == "red" and not force.technologies["red-field-gates"].researched then
      player.print("You need to complete the required research before gates of this field type can be used.")
      return
    end
  end

  -- Change to new selection
  local configTableData = event.element.parent
  configTableData[self.guiElementNames.configOption .. "E" .. fieldIndex].style = Settings.guiSmallSelectButtonStyle
  configTableData[self.guiElementNames.configOption .. "W" .. fieldIndex].style = Settings.guiSmallSelectButtonStyle
  configTableData[self.guiElementNames.configOption .. "G" .. fieldIndex].style = Settings.guiSmallSelectButtonStyle
  configTableData[self.guiElementNames.configOption .. fieldConfig .. fieldIndex].style = Settings.guiSmallSelectButtonSelectedStyle
end



function Gui:handleGuiConfigWallRowChange(event)
  -- Select the correct styles for each row
  local playerIndex = event.player_index
  local fieldConfig = string.sub(event.element.name, -1)
  local StyleE, styleW, styleG

  if fieldConfig == "E" then
    styleE = Settings.guiSmallSelectButtonSelectedStyle
    styleW = Settings.guiSmallSelectButtonStyle
    styleG = Settings.guiSmallSelectButtonStyle

  elseif fieldConfig == "G" then
    -- If its a gate, check if we have the required research
    local player = game.players[playerIndex]
    local force = player.force
    local fieldType
    if global.forcefields.emitterConfigGuis["I" .. playerIndex][3] ~= nil then
      fieldType = global.forcefields.emitterConfigGuis["I" .. playerIndex][3]
    else
      fieldType = global.forcefields.emitterConfigGuis["I" .. playerIndex][1]["type"]
    end

    if fieldType == "blue" and not force.technologies["force-field-gates"].researched
      or fieldType == "green" and not force.technologies["green-field-gates"].researched
      or fieldType == "purple" and not force.technologies["purple-field-gates"].researched
      or fieldType == "red" and not force.technologies["red-field-gates"].researched then
      player.print("You need to complete the required research before gates of this field type can be used.")
      return
    end

    styleE = Settings.guiSmallSelectButtonStyle
    styleW = Settings.guiSmallSelectButtonStyle
    styleG = Settings.guiSmallSelectButtonSelectedStyle

  else -- default == "W"
    styleE = Settings.guiSmallSelectButtonStyle
    styleW = Settings.guiSmallSelectButtonSelectedStyle
    styleG = Settings.guiSmallSelectButtonStyle
  end

  -- Now change all the buttons
  local guiCenter = game.players[playerIndex].gui.center
  local emitterConfigTable = guiCenter[self.guiElementNames.guiFrame][self.guiElementNames.configTable]
  local fieldWidth = tonumber(emitterConfigTable[self.guiElementNames.widthTable][self.guiElementNames.widthInput].text)
  local configTableData = guiCenter[self.guiElementNames.configFrame][self.guiElementNames.configTableFrame][self.guiElementNames.configTableSlider][self.guiElementNames.configTableData]
  for fieldIndex = 1, fieldWidth do
    configTableData[self.guiElementNames.configOption .. "E" .. string.format("%02d", fieldIndex)].style = styleE
    configTableData[self.guiElementNames.configOption .. "W" .. string.format("%02d", fieldIndex)].style = styleW
    configTableData[self.guiElementNames.configOption .. "G" .. string.format("%02d", fieldIndex)].style = styleG
  end
end



function Gui:handleGuiConfigWallClose(event)
  local playerIndex = event.player_index
  local guiCenter = game.players[playerIndex].gui.center

  local emitterConfigTable = guiCenter[self.guiElementNames.guiFrame][self.guiElementNames.configTable]
  --local fieldWidth = (#configTableData.children_names)/4
  local fieldWidth = tonumber(emitterConfigTable[self.guiElementNames.widthTable][self.guiElementNames.widthInput].text)
  local fieldOffset = (fieldWidth + 1)/2
  local configTableData = guiCenter[self.guiElementNames.configFrame][self.guiElementNames.configTableFrame][self.guiElementNames.configTableSlider][self.guiElementNames.configTableData]

  local configTable -- Undo all the changes that has been done
  if not global.forcefields.emitterConfigGuis["I" .. playerIndex][4] then
    -- No previous settings, still using the settings from the emitterTable
    configTable = util.table.deepcopy(global.forcefields.emitterConfigGuis["I" .. playerIndex][1]["config"])
  else
    -- There where settings when opened, lets use these
    configTable = global.forcefields.emitterConfigGuis["I" .. playerIndex][4]
  end

  -- First we need to save the data
  if event.element.name == self.guiElementNames.configCancelButton then
    -- Redo the the correct setting for each wall
    for fieldIndex = 1, fieldWidth do
      -- Default back to not selected
      configTableData[self.guiElementNames.configOption .. "E" .. string.format("%02d", fieldIndex)].style = Settings.guiSmallSelectButtonStyle
      configTableData[self.guiElementNames.configOption .. "W" .. string.format("%02d", fieldIndex)].style = Settings.guiSmallSelectButtonStyle
      configTableData[self.guiElementNames.configOption .. "G" .. string.format("%02d", fieldIndex)].style = Settings.guiSmallSelectButtonStyle

      -- Now select the correct setting
      local type = configTable[fieldIndex-fieldOffset]
      if type == Settings.fieldSuffix then
        configTableData[self.guiElementNames.configOption .. "W" .. string.format("%02d", fieldIndex)].style = Settings.guiSmallSelectButtonSelectedStyle
      elseif type == Settings.fieldGateSuffix then
        configTableData[self.guiElementNames.configOption .. "G" .. string.format("%02d", fieldIndex)].style = Settings.guiSmallSelectButtonSelectedStyle
      else
        configTableData[self.guiElementNames.configOption .. "E" .. string.format("%02d", fieldIndex)].style = Settings.guiSmallSelectButtonSelectedStyle
      end
    end

  elseif event.element.name == self.guiElementNames.configApplyButton then
    -- Extract info out of the gui
    for fieldIndex = 1, fieldWidth do
      if configTableData[self.guiElementNames.configOption .. "W" .. string.format("%02d", fieldIndex)].style.name == Settings.guiSmallSelectButtonSelectedStyle then
        configTable[fieldIndex-fieldOffset] = Settings.fieldSuffix
      elseif configTableData[self.guiElementNames.configOption .. "G" .. string.format("%02d", fieldIndex)].style.name == Settings.guiSmallSelectButtonSelectedStyle then
        configTable[fieldIndex-fieldOffset] = Settings.fieldGateSuffix
      else
        configTable[fieldIndex-fieldOffset] = Settings.fieldEmptySuffix
      end
    end
    global.forcefields.emitterConfigGuis["I" .. playerIndex][4] = configTable
  end

  -- Now we need to change the guis back
  guiCenter[self.guiElementNames.guiFrame].style.visible = true
  guiCenter[self.guiElementNames.configFrame].style.visible = false
end



Gui.guiButtonHandlers =
{
  -- Emitter gui
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
  [Gui.guiElementNames.buttonConfigure] = Gui.handleConfigureButton,
  [Gui.guiElementNames.buttonApplySettings] = Gui.handleGuiMenuButtons,

  -- Forcefield gui
  [Gui.guiElementNames.configOption] = Gui.handleGuiConfigWallChange,
  [Gui.guiElementNames.configRowOption] = Gui.handleGuiConfigWallRowChange,
  [Gui.guiElementNames.configCancelButton] = Gui.handleGuiConfigWallClose,
  [Gui.guiElementNames.configApplyButton] = Gui.handleGuiConfigWallClose,
}



function Gui:printGuiHelp(player)
  player.print("Direction: the direction the emitter projects the forcefields in.")
  player.print("Field type: the type of forcefield the emitter projects:")
  player.print("    [B]lue: normal health, normal re-spawn, normal power usage.")
  player.print("    [G]reen: higher health, very slow re-spawn, below-normal power usage.")
  player.print("    [R]ed: normal health, slow re-spawn, very high power usage. Damages living things that directly attack them.")
  player.print("    [P]urple: low health, very slow re-spawn, high power usage. On death, heavily damages living things near-by.")
  player.print("Emitter distance: the distance from the emitter in the configured direction the fields are constructed.")
  player.print("Emitter width: the width of the field constructed by the emitter.")
  player.print("Upgrades applied: the distance (advanced circuit) and width (processing unit) upgrades applied to the emitter.")
  player.print("Help button: displays this information.")
  player.print("Remove all upgrades: removes all upgrades from the emitter.")
  player.print("Apply: saves and applies the settings to the emitter.")
end



function Gui:verifyAndSetFromGui(playerIndex)
  -- emitter settings
  local newDirection
  local newFieldType
  local newFieldConfig
  local newDistance
  local newWidth
  local maxDistance
  local maxWidth
  local newWidthUpgrades
  local newDistanceUpgrades
  local player = game.players[playerIndex]
  local settingsAreGood = true
  local settingsChanged = false
  local frame = player.gui.center[self.guiElementNames.guiFrame]
  local emitterConfigTable = frame[self.guiElementNames.configTable]
  local upgrades = emitterConfigTable[self.guiElementNames.upgradesTable]

  if global.forcefields.emitterConfigGuis ~= nil
    and global.forcefields.emitterConfigGuis["I" .. playerIndex] ~= nil
    and global.forcefields.emitterConfigGuis["I" .. playerIndex][1]["entity"].valid then

    -- Check if settings have changed
    local emitterTable = global.forcefields.emitterConfigGuis["I" .. playerIndex][1]

    -- Direction of the forcefield
    if global.forcefields.emitterConfigGuis["I" .. playerIndex][2] ~= nil then
      newDirection = global.forcefields.emitterConfigGuis["I" .. playerIndex][2]
    else
      newDirection = emitterTable["direction"]
    end

    -- Type of forcefield
    if global.forcefields.emitterConfigGuis["I" .. playerIndex][3] ~= nil then
      newFieldType = global.forcefields.emitterConfigGuis["I" .. playerIndex][3]
    else
      newFieldType = emitterTable["type"]
    end

    -- Distance of forcefield
    newDistance = tonumber(emitterConfigTable[self.guiElementNames.distanceTable][self.guiElementNames.distanceInput].text)
    maxDistance = tonumber(string.sub(emitterConfigTable[self.guiElementNames.distanceTable][self.guiElementNames.distanceMaxInput].caption, 6))
    if upgrades[self.guiElementNames.upgradesDistance].caption ~= " " then
      newDistanceUpgrades = tonumber(string.sub(upgrades[self.guiElementNames.upgradesDistance].caption, 2))
    else
      newDistanceUpgrades = 0
    end
    if not newDistance then
      player.print("New Distance is not a valid number.")
      settingsAreGood = false
    elseif newDistance > maxDistance then
      player.print("New Distance is larger than the allowed maximum.")
      settingsAreGood = false
    elseif newDistance < 1 then
      player.print("New Distance is smaller than the allowed minimum (1).")
      settingsAreGood = false
    elseif math.floor(newDistance) ~= newDistance then
      player.print("New Distance is not a valid number (can't have decimals).")
      settingsAreGood = false
    end

    -- Width of forcefield
    newWidth = tonumber(emitterConfigTable[self.guiElementNames.widthTable][self.guiElementNames.widthInput].text)
    maxWidth = tonumber(string.sub(emitterConfigTable[self.guiElementNames.widthTable][self.guiElementNames.widthMaxInput].caption, 6))
    if upgrades[self.guiElementNames.upgradesWidth].caption ~= " " then
      newWidthUpgrades = tonumber(string.sub(upgrades[self.guiElementNames.upgradesWidth].caption, 2))
    else
      newWidthUpgrades = 0
    end
    if not newWidth then
      player.print("New Width is not a valid number.")
      settingsAreGood = false
    elseif newWidth > maxWidth then
      player.print("New Width is larger than the allowed maximum.")
      settingsAreGood = false
    elseif newWidth < 1 then
      player.print("New Width is smaller than the allowed minimum (1).")
      settingsAreGood = false
    elseif math.floor(newWidth) ~= newWidth then
      player.print("New Width is not a valid number (can't have decimals).")
      settingsAreGood = false
    elseif (math.floor((newWidth - 1) / 2) * 2) + 1 ~= newWidth then
      player.print("New Width has to be an odd number.")
      emitterConfigTable[self.guiElementNames.widthTable][self.guiElementNames.widthInput].text = tostring((math.floor((newWidth - 1) / 2) * 2) + 1)
      settingsAreGood = false
    end

    -- New field configuration
    if global.forcefields.emitterConfigGuis["I" .. playerIndex][4] ~= nil then
      newFieldConfig = global.forcefields.emitterConfigGuis["I" .. playerIndex][4]
    else
      newFieldConfig = emitterTable["config"]
    end

    -- If settings are all checked and correct, we can update the emitterTable
    if settingsAreGood then
      -- If any changes on the forcefield, we need to rebuild it
      if emitterTable["width"] ~= newWidth
        or emitterTable["distance"] ~= newDistance
        or emitterTable["type"] ~= newFieldType
        or emitterTable["direction"] ~= newDirection
        or not tablesAreEqual(emitterTable["config"], newFieldConfig) then

        Forcefield:degradeLinkedFields(emitterTable)
        emitterTable["damaged-fields"] = nil
        emitterTable["width"] = newWidth
        emitterTable["distance"] = newDistance
        emitterTable["type"] = newFieldType
        emitterTable["config"] = newFieldConfig
        emitterTable["direction"] = newDirection
        emitterTable["generating-fields"] = nil
        Emitter:setActive(emitterTable, true)
      end

      -- If the upgrades changed we have to update that too, but no need to rebuild
      emitterTable["distance-upgrades"] = newDistanceUpgrades
      emitterTable["width-upgrades"] = newWidthUpgrades

      -- Return true to close the UI
      return true
    end
    -- Not closing UI yet (settingsAreGood == false)
  else
    -- Invalid entity, close this UI
    return true
  end
end



function Gui:removeAllUpgrades(playerIndex)
  local frame = game.players[playerIndex].gui.center[self.guiElementNames.guiFrame]

  if frame then -- This shouldn't ever be required but won't hurt to check
    if global.forcefields.emitterConfigGuis ~= nil
      and global.forcefields.emitterConfigGuis["I" .. playerIndex] ~= nil
      and global.forcefields.emitterConfigGuis["I" .. playerIndex][1]["entity"].valid then
      local upgrades = frame[self.guiElementNames.configTable][self.guiElementNames.upgradesTable]
      local count
      --local buttonName
      for upgradeItemName, button in pairs({
        ["advanced-circuit"] = upgrades[self.guiElementNames.upgradesDistance],
        ["processing-unit"] = upgrades[self.guiElementNames.upgradesWidth]
      }) do
        if button.caption ~= " " then
          count = tonumber(string.sub(button.caption, 2))
          button.caption = " "
          button.style = "noitem"

          self:updateMaxLabel(frame, button)
          transferToPlayer(game.players[playerIndex], {name = upgradeItemName, count = count})
        end
      end
    else -- invalid emitter entity (for example when someone destroys the emitter while another person is viewing the gui)
      if global.forcefields.emitterConfigGuis ~= nil and global.forcefields.emitterConfigGuis["I" .. playerIndex] ~= nil then
        global.forcefields.emitterConfigGuis["I" .. playerIndex] = nil
        if tableIsEmpty(global.forcefields.emitterConfigGuis) then
          global.forcefields.emitterConfigGuis = nil
        end
      end
      -- close the gui
      frame.destroy()
    end
  end
end



function Gui:updateMaxLabel(frame, upgradeButton)
  local count
  if upgradeButton.caption == " " then
    count = 0
  else
    count = tonumber(string.sub(upgradeButton.caption, 2))
  end
  if upgradeButton.name == self.guiElementNames.upgradesDistance then
    -- Distance upgrade button
    frame[self.guiElementNames.configTable][self.guiElementNames.distanceTable][self.guiElementNames.distanceMaxInput].caption = "Max: " .. tostring(Settings.emitterDefaultDistance + count)
  else
    -- Width upgrade button
    frame[self.guiElementNames.configTable][self.guiElementNames.widthTable][self.guiElementNames.widthMaxInput].caption = "Max: " .. tostring(Settings.emitterDefaultWidth + (count * Settings.widthUpgradeMultiplier))
  end
end
