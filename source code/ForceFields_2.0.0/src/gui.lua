--require 'src/settings'
require 'src/emitter'


Gui = {}


function Gui.onOpenGui(self, emitter, playerIndex)
  local emitterTable = Emitter:findEmitter(emitter)
  if emitterTable ~= nil then
    self:showEmitterGui(emitterTable, playerIndex)
  end
end



function Gui:onCloseGui(guiElement)
  if guiElement and guiElement.valid and guiElement.name == "emitter-frame" then
    guiElement.destroy()
  end
end



function Gui.showEmitterGui(self, emitterTable, playerIndex)
  game.print("UI opened")
  local player = game.players[playerIndex]

  -- Check if its already open
  if player.gui.center[name] then
    player.gui.center[name].destroy()
  end
  -- Add own gui
  local frame = player.gui.center.add{
    type = "frame",
    name = "emitter-frame",
    direction = "vertical"
  }
  local label = frame.add{
    type = "label",
    name = "test-label",
    caption = "test123"
  }

  -- divert the opened GUI to the new layout
  player.opened = frame

end
