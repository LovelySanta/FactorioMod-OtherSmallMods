
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
  if playerInventory then
    local playerInventoryContent = playerInventory.get_contents()

    if playerInventoryContent and playerInventoryContent["corpse-flare"] and playerInventoryContent["corpse-flare"] > 0 then
      -- Remove a flare from the inventory
      playerInventory.remove{name="corpse-flare", count=1}
      -- Create a flare entity
      self:CreateNewFlare(playerIndex)
      -- No need to look further, we can quit this function
      return
    end
  end

  local playerQuickbar = player.get_inventory(defines.inventory.player_quickbar)
  if playerQuickbar then
    local playerQuickbarContent = playerQuickbar.get_contents()

    if playerQuickbarContent and playerQuickbarContent["corpse-flare"] and playerQuickbarContent["corpse-flare"] > 0 then
      -- Remove a flare from the inventory
      playerQuickbar.remove{name="corpse-flare", count=1}
      -- Create a flare entity
      self:CreateNewFlare(playerIndex)
      -- No need to look further, we can quit this function
      return
    end
  end
end



function CorpseFlare.CreateNewFlare(_, playerIndex)
  local player = game.players[playerIndex]

  global.BZ_flare[playerIndex] = player.surface.create_entity{
    name='flare-cloud',
    position = {
      x = player.position.x + 3.25,
      y = player.position.y - 2.5
    },
    force = 'enemy',
    -- target = player.character,
    speed = 0.15
  }
end
