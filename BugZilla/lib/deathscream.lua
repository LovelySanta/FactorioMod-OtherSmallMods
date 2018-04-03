
Deathscream = {}

function Deathscream.CreateScream(self, playerIndex)
  -- Try to create a deathscream, if it doesn't work, nothing wrong...
  -- So pcall is allowed here...
  pcall(function()
    local player = game.players[playerIndex]
    player.surface.create_entity{
      name = "deathscream",
      position = player.position
    }
  end)
end
