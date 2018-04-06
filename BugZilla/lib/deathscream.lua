
Deathscream = {}

function Deathscream:CreateScream(playerIndex)
  local player = game.players[playerIndex]

  player.force.play_sound{
    path = "deathscream",
    position = player.position,
    volume_modifier = 1
  }
end
