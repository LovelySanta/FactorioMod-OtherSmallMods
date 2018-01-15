require("lib.utilities.generic")

local default_frame_font_vertical_compensation = -6


DeathUI = {}



DeathUI.bossNames = {
  ["bugzilla-biter"] = "BugZilla Biter",
}



function DeathUI.Init(self)
  if not global.BZ_gui then
    self:InitGlobalData()
  end
end



function DeathUI.OnConfigurationChanged(self)
  local guiData = global.BZ_gui

  if not guiData then
    self:InitGlobalData()
    return
  end

  if not guiData.Version then
    -- We need to check if it was the first test version without version number
    if not guiData.guiState then
      -- No guiState means no UI exist
      self:InitGlobalData()
    else
      -- We need to update to version 1
      guiData.Name = "BZ_gui"
      guiData.Version = "1"

      -- update guiState to new data
      local guiState = guiData.guiState
      guiState.deathDetailsVisible = guiState.detailsVisible
      guiState.detailsVisible = nil
      guiData.guiState = guiState

      -- update deathData
      local oldDeaths = guiData.deaths
      deathRank = {}
      deathRankLength = 0

      for playerIndex, _ in pairs(game.players) do
        deathRankLength = deathRankLength + 1
        deathRank[deathRankLength] = playerIndex

        -- Now we added the player as last rank, check if we need to move it up
        if deathRankLength > 1 then
          local playerRank = deathRankLength
          local playerDeaths = guiData.deaths[playerIndex]

          while playerRank > 1 and playerDeaths > guiData.deaths[deathRank[playerRank - 1]] do
            -- switch places
            deathRank[playerRank] = deathRank[playerRank-1]
            playerRank = playerRank - 1
            deathRank[playerRank] = playerIndex
          end
        end

        -- Destroy the old UI
        local frame = game.players[playerIndex].gui.top.BZ_gui_frame
        frame.destroy() -- Destroy the old flow
      end

      -- All players are added, now sync the data
      guiData.deathRank = deathRank
      guiData.deathRankLength = deathRankLength
    end
  end

  if guiData.Version == "1" then
    guiData.Version = "2"

    for playerIndex,_ in pairs(game.players) do
      local gui = game.players[playerIndex].gui.top

      -- Destroy the old UI
      local frame = gui.BZ_gui_frame
      if frame and frame.valid then
        frame.destroy()
      end

      local flow = gui.add{
        type = "flow",
        name = "BZ_gui_flow",
        direction = "vertical"
      }
      -- create the buttons
      local buttons = flow.add{
        type = "frame",
        name = "BZ_gui_buttonFrame",
        direction = "horizontal"
      }
      buttons.style.top_padding = -1 * default_frame_font_vertical_compensation
      buttons.add{
        type = "sprite-button",
        name = "BZ_gui_buttonDeaths",
        sprite = "item/death-skull",
        style = "icon_button"
      }
      buttons.add{
        type = "sprite-button",
        name = "BZ_gui_buttonBiterstats",
        sprite = "entity/bugzilla-biter",
        style = "icon_button"
      }
      -- create the detailed view
      local detailFrame = flow.add{
        type = "frame",
        name = "BZ_gui_detailFrame",
        direction = "vertical"
      }
      detailFrame.style.top_padding = -1 * default_frame_font_vertical_compensation
      local detailedView = detailFrame.add{
        type = "scroll-pane",
        name = "BZ_gui_detailedView",
        vertical_scroll_policy = "auto"
      }
      detailedView.style.maximal_height = 500

      guiData.guiState[playerIndex].bugzillaDetailsVisible = false
    end
  end

  -- All players are added, now sync the data and redraw all UI's
  global.BZ_gui = guiData
  self:UpdateAllLabels()
end



function DeathUI.OnNewPlayerCreated(self, playerIndex)
  self:InitPlayer(playerIndex)
  self:UpdateAllLabels()
end



function DeathUI.OnClick(self, event)
  local playerIndex = event.player_index
  local guiState = global.BZ_gui.guiState[playerIndex]
  if event.element.name == "BZ_gui_buttonDeaths" then
    -- show the not detailed view
    guiState.deathDetailsVisible = not guiState.deathDetailsVisible
    guiState.bugzillaDetailsVisible = false

    -- update data
    global.BZ_gui.guiState[playerIndex] = guiState
    -- draw new detailed view
    self:UpdateLabel(playerIndex)

  elseif event.element.name == "BZ_gui_buttonBiterstats" then
    -- show the not biter stats
    guiState.bugzillaDetailsVisible = not guiState.bugzillaDetailsVisible
    guiState.deathDetailsVisible = false

    -- update data
    global.BZ_gui.guiState[playerIndex] = guiState
    -- draw new detailed view
    self:UpdateLabel(playerIndex)
  end
end



function DeathUI.InitGlobalData(self)
  global.BZ_gui = {}
  global.BZ_gui.Name = "BZ_gui"
  global.BZ_gui.Version = "2"

  global.BZ_gui.deaths = {}
  global.BZ_gui.deathRank = {}
  global.BZ_gui.deathRankLength = 0
  global.BZ_gui.guiState = {}

  for playerIndex, _ in pairs(game.players) do
    self:InitPlayer(playerIndex)
  end
end



function DeathUI.InitPlayer(self, playerIndex)
  -- init deaths
  if not global.BZ_gui.deaths[playerIndex] then
    global.BZ_gui.deaths[playerIndex] = 0
    global.BZ_gui.deathRankLength = global.BZ_gui.deathRankLength + 1
    global.BZ_gui.deathRank[global.BZ_gui.deathRankLength] = playerIndex
  end

  -- init gui for the player
  if not global.BZ_gui.guiState[playerIndex] then

    local gui = game.players[playerIndex].gui.top
    local flow = gui.add{
      type = "flow",
      name = "BZ_gui_flow",
      direction = "vertical"
    }
    -- create the buttons
    local buttons = flow.add{
      type = "frame",
      name = "BZ_gui_buttonFrame",
      direction = "horizontal"
    }
    buttons.style.top_padding = -1 * default_frame_font_vertical_compensation
    buttons.add{
      type = "sprite-button",
      name = "BZ_gui_buttonDeaths",
      sprite = "item/death-skull",
      style = "icon_button"
    }
    buttons.add{
      type = "sprite-button",
      name = "BZ_gui_buttonBiterstats",
      sprite = "entity/bugzilla-biter",
      style = "icon_button"
    }
    -- create the detailed view
    local detailFrame = flow.add{
      type = "frame",
      name = "BZ_gui_detailFrame",
      direction = "vertical"
    }
    detailFrame.style.top_padding = -1 * default_frame_font_vertical_compensation
    local detailedView = detailFrame.add{
      type = "scroll-pane",
      name = "BZ_gui_detailedView",
      vertical_scroll_policy = "auto"
    }
    detailedView.style.maximal_height = 500

    -- set initial detailed view
    detailedView.add{
      type = "label",
      name = "BZ_gui_lblDeaths",
      caption = "",
      single_line = false
    }

    -- init gui state visible for the player
    local state = {}
    state.deathDetailsVisible = false
    state.bugzillaDetailsVisible = false
    global.BZ_gui.guiState[playerIndex] = state
  end
end



function DeathUI.AddDeath(self, playerIndex)
  local guiData = global.BZ_gui

  -- Add death
  local playerDeaths = guiData.deaths[playerIndex]
  playerDeaths = playerDeaths + 1
  guiData.deaths[playerIndex] = playerDeaths

  -- Check if we need to move the player a rank up, first find its current rank
  local playerRank = 0
  local deathRank = guiData.deathRank
  for i = 1, global.BZ_gui.deathRankLength, 1 do
    if deathRank[i] == playerIndex then
      playerRank = i
    end
  end

  -- We can assume we are sure we found a rank, now orden the player
  while playerRank > 1 and playerDeaths > guiData.deaths[deathRank[playerRank - 1]] do
    -- switch places
    deathRank[playerRank] = deathRank[playerRank-1]
    playerRank = playerRank - 1
    deathRank[playerRank] = playerIndex
  end
  guiData.deathRank = deathRank

  -- save changes
  global.BZ_gui = guiData

  self:UpdateAllLabels()
end



function DeathUI.UpdateAllLabels(self)
  for playerIndex, _ in pairs(game.players) do
    self:UpdateLabel(playerIndex)
  end
end



function DeathUI.UpdateLabel(self, playerIndex)
  -- GUI state will determin what to draw
  local guiState = global.BZ_gui.guiState[playerIndex]

  -- Update label UI elements to match GUI state
  local flow = game.players[playerIndex].gui.top.BZ_gui_flow
  if flow then
    local detailedView = flow.BZ_gui_detailFrame.BZ_gui_detailedView

    -- Create GUI to fit details
    if not guiState.bugzillaDetailsVisible then
      -- We need the deathUI
      local deathsRank, deathsName, deathsCount = self:GetDeathsLabelText(playerIndex)

      if TableHasValue(detailedView.children_names, "BZ_gui_deathsTable") then
        -- If the GUI was there, we only have to update the caption
        local deathsTable = detailedView.BZ_gui_deathsTable
        deathsTable.BZ_gui_lblDeathsRank.caption = deathsRank
        deathsTable.BZ_gui_lblDeathsName.caption = deathsName
        deathsTable.BZ_gui_lblDeathsCount.caption = deathsCount

      else
        -- We need to redraw the detailedView
        detailedView.clear()

        -- Create the new labels
        local deathsTable = detailedView.add{
          type = "table",
          name = "BZ_gui_deathsTable",
          column_count = 3
        }
        local lblDeathsRank = deathsTable.add{
          type = "label",
          name = "BZ_gui_lblDeathsRank",
          caption = deathsRank,
        }
        lblDeathsRank.style.single_line = false
        local lblDeathsName = deathsTable.add{
          type = "label",
          name = "BZ_gui_lblDeathsName",
          caption = deathsName,
        }
        lblDeathsName.style.single_line = false
        local lblDeathsCount = deathsTable.add{
          type = "label",
          name = "BZ_gui_lblDeathsCount",
          caption = deathsCount,
        }
        lblDeathsCount.style.single_line = false
      end

    else
      -- we need the bugzilla UI
      local bugzillaName, bugzillaScore = self:GetBugzillaLabelText()

      if TableHasValue(detailedView.children_names, "BZ_gui_bugzillaTable") then
        -- If the GUI was there, we only have to update the captions
        local bugzillaTable = detailedView.BZ_gui_bugzillaTable
        bugzillaTable.BZ_gui_lblBugzillaName.caption = bugzillaName
        bugzillaTable.BZ_gui_lblBugzillaScore.caption = bugzillaScore

      else
        -- We need to redraw the detailedView
        detailedView.clear()

        -- Create the new labels
        local bugzillaTable = detailedView.add{
          type = "table",
          name = "BZ_gui_bugzillaTable",
          column_count = 2
        }
        local lblBugzillaName = bugzillaTable.add{
          type = "label",
          name = "BZ_gui_lblBugzillaName",
          caption = bugzillaName,
        }
        lblBugzillaName.style.single_line = false
        local lblBugzillaScore = bugzillaTable.add{
          type = "label",
          name = "BZ_gui_lblBugzillaScore",
          caption = bugzillaScore,
        }
        lblBugzillaScore.style.single_line = false

      end
    end
  end
end



function DeathUI.GetDeathsLabelText(self, playerIndex)
  -- Either single line or multi line string depending on GUI state
  if global.BZ_gui.guiState[playerIndex].deathDetailsVisible then
    local deathsRank = "†\n"
    local deathsName = "Deaths:\n"
    local deathsCount = "\n"

    for i = 1, global.BZ_gui.deathRankLength, 1 do
      local playerIndex = global.BZ_gui.deathRank[i]

      -- "00 | playerName | playerDeaths"
      if i < 10 then
        deathsRank = deathsRank .. "\n0" .. i
      else
        deathsRank = deathsRank .. "\n" .. i
      end

      deathsName = deathsName .. " \n " .. game.players[playerIndex].name
      deathsCount = deathsCount .. " \n " .. global.BZ_gui.deaths[playerIndex]
    end

    return deathsRank, deathsName, deathsCount

  else
    return "Score: \n† Deaths: ", global.BZ_boss.killScore .. "\n" .. global.BZ_gui.deaths[playerIndex], ""
  end
end



function DeathUI.GetBugzillaLabelText(self)
  local bugzillaName = "Score: \n"
  local bugzillaScore = global.BZ_boss.killScore .. "\n"

  local killCount = global.BZ_boss.killCount
  for bossName,bossCount in pairs(killCount) do
    if bossCount.total > 0 then
      bugzillaName = bugzillaName .. "\n" .. self.bossNames[bossName]  .. ": "
      bugzillaScore = bugzillaScore .. "\n" .. bossCount.killed .. "/" .. bossCount.total
    end
  end

  return bugzillaName, bugzillaScore
end
