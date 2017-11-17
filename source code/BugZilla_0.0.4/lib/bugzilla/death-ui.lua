
DeathUI = {}



function DeathUI.Init(self)
  if not global.BZ_gui then
    self:InitGlobalData()
  end
end



function DeathUI.OnNewPlayerCreated(self, playerIndex)
  self:InitPlayer(playerIndex)
  self:UpdateAllLabels()
end



function DeathUI.OnClick(self, event)
  if event.element.name == "BZ_gui_btnMore" then
    local playerIndex = event.player_index
    global.BZ_gui.guiState[playerIndex].detailsVisible = not global.BZ_gui.guiState[playerIndex].detailsVisible
    self:UpdateButtons(playerIndex)
    self:UpdateLabels(playerIndex)
  end
end


function DeathUI.InitGlobalData(self)
  global.BZ_gui = {}
  global.BZ_gui.deaths = {}
  global.BZ_gui.guiState = {}

  for playerIndex, _ in pairs(game.players) do
    self:InitPlayer(playerIndex)
  end
end



function DeathUI.InitPlayer(self, playerIndex)
  -- init deaths
  if not global.BZ_gui.deaths[playerIndex] then
    global.BZ_gui.deaths[playerIndex] = 0
  end

  -- init gui for the player
  if not global.BZ_gui.guiState[playerIndex] then
    local frame = game.players[playerIndex].gui.top.add{
      type = "frame",
      name = "BZ_gui_frame"
    }
    local flow = frame.add{
      type = "flow",
      name = "BZ_gui_flow",
      direction = "vertical"
    }
    local scrollPane = flow.add{
      type = "scroll-pane",
      name = "BZ_gui_scrollPane",
      vertical_scroll_policy = "auto"
    }
    scrollPane.style.maximal_height = 500

    scrollPane.add{
      type = "label",
      name = "BZ_gui_lblDeaths",
      caption = "Deahts: 0",
      single_line = false
    }

    flow.add{
      type = "button",
      name = "BZ_gui_btnMore",
      caption = "More..."
    }

    -- init gui state visible for the player
    local state = {}
    state.detailsVisible = false
    global.BZ_gui.guiState[playerIndex] = state
  end
end



function DeathUI.AddDeath(self, playerIndex)
  global.BZ_gui.deaths[playerIndex] = global.BZ_gui.deaths[playerIndex] + 1
  self:UpdateAllLabels()
end



function DeathUI.UpdateButtons(self, playerIndex)
  local frame = game.players[playerIndex].gui.top.BZ_gui_frame
  if frame then
    local btnMore = frame.BZ_gui_flow.BZ_gui_btnMore
    local state = global.BZ_gui.guiState[playerIndex]
    if state.detailsVisible then
      btnMore.caption = "Less..."
    else
      btnMore.caption = "More..."
    end
  end
end



function DeathUI.UpdateAllLabels(self)
  for playerIndex, _ in pairs(game.players) do
    self:UpdateLabels(playerIndex)
  end
end



function DeathUI.UpdateLabels(self, playerIndex)
-- Update label UI elements to match death count / GUI state
  local frame = game.players[playerIndex].gui.top.BZ_gui_frame
  if frame then
    local lblDeaths = frame.BZ_gui_flow.BZ_gui_scrollPane.BZ_gui_lblDeaths
    lblDeaths.caption = self:GetDeathsLabelText(playerIndex)
  end
end



function DeathUI.GetDeathsLabelText(self, playerIndex)
  -- Either single line or multi line string depending on GUI state
  if global.BZ_gui.guiState[playerIndex].detailsVisible then
    local text = "Deahts:"
    for i, player in pairs(game.players) do
      text = text .. "\n" .. player.name .. ": " .. global.BZ_gui.deaths[i]
    end
    return text
  else
    return "Deaths: " .. global.BZ_gui.deaths[playerIndex]
  end
end
