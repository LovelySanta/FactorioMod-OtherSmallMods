local opositeDirection =
{
  [defines.direction.north    ] = defines.direction.south    ,
  [defines.direction.northeast] = defines.direction.southwest,
  [defines.direction.east     ] = defines.direction.west     ,
  [defines.direction.southeast] = defines.direction.northwest,
  [defines.direction.south    ] = defines.direction.north    ,
  [defines.direction.southwest] = defines.direction.northeast,
  [defines.direction.west     ] = defines.direction.east     ,
  [defines.direction.northwest] = defines.direction.southeast,
}

script.on_event(defines.events.on_player_rotated_entity, function(event)
  local entityName = event.entity.name
  if entityName == "fluid-compressor" or entityName == "fluid-decompressor" then
    event.entity.direction = opositeDirection[event.previous_direction]
  end
end)
