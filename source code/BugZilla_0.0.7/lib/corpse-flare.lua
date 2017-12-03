
CorpseFlare = {}

function CorpseFlare.Init(self)
  if not global.BZ_flare then
    global.BZ_flare = {}
    -- Becose i'm to lazy to give myself a corpse flare each time while testing
    --game.players['lovely_santa'].get_inventory(defines.inventory.player_main).insert{name='corpse-flare',count=1}
  end
end



function CorpseFlare.OnPrePlayerDied(self, playerIndex)
  local player = game.players[playerIndex]
  local playerInventory = player.get_inventory(defines.inventory.player_main)

  if not playerInventory then
    game.print("BugZilla.lib.corpse-flare.lua: No player inventory found")
  else
    local playerInventoryContent = playerInventory.get_contents()
    if playerInventoryContent and playerInventoryContent["corpse-flare"] and playerInventoryContent["corpse-flare"] > 0 then
      -- Create a flare entity
      self:CreateNewFlare(playerIndex)
      -- Remove a flare from the inventory
      playerInventory.remove{name="corpse-flare", count=1}
    end
  end
end



function CorpseFlare.CreateNewFlare(_, playerIndex)
  local player = game.players[playerIndex]

  global.BZ_flare[playerIndex] = player.surface.create_entity{
    name='flare',
    position = player.position,
    force = 'enemy',
    target = player.character,
    speed = 0.15
  }
end
