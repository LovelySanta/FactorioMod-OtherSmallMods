--require 'src/settings'
require 'src/emitter'


Gui = {}


function Gui.onOpenGui(self, emitter, playerIndex)
  local emitterTable = Emitter:findEmitter(emitter)
  if emitterTable ~= nil then
    self:showEmitterGui(emitterTable, playerIndex) -- TODO
  end
end



function Gui.showEmitterGui(self, emitterTable, playerIndex)
  game.print("UI opened")
end
