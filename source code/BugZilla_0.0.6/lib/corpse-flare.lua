
CorpseFlare = {}

-- Becose i'm to lazy to give myself a corpse flare each time...
-- /c game.players['lovely_santa'].get_inventory(defines.inventory.player_main).insert{name='corpse-flare',count=1}

function CorpseFlare.OnPrePlayerDied(self, playerIndex)
  local player = game.players[playerIndex]
  local playerInventory = player.get_inventory(defines.inventory.player_main)

  if not playerInventory then
    game.print("BugZilla.lib.corpse-flare.lua: No player inventory found")
  else
    local playerInventoryContent = playerInventory.get_contents()
    if playerInventoryContent and playerInventoryContent["corpse-flare"] and playerInventoryContent["corpse-flare"] > 0 then
      game.print('flare found')
    else
      game.print('no flare found')
    end
  end
end
