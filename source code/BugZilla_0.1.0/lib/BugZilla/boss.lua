require 'lib/utilities/math'

Boss = {}

function Boss.Init()
  game.forces.enemy.ai_controllable = false -- Make sure Boss don't spawn a spawner
  Boss.entity = nil
end



function Boss.Spawn(self)
  if Boss.entity == nil then
    -- TODO: check for luaSurface:: can_place_entity{...}
    Boss.entity = game.surfaces[1].create_entity{
      name = "behemoth-biter",
      force = game.forces.enemy,
      position = self:getSpawnPosition()
    }
    local cmd = defines.command.attack_area
    cmd.destination =
    cmd.radius = settings.global["BZ-min-spawn-range"].value
    cmd.distraction = defines.distraction.by_anything
    Boss.entity.set_command(cmd)
  else
    game.print("BugZilla.lib.boss.lua: BugZilla already exist.")
  end



function Boss.getSpawnPosition(_)
  local radius = Math.lerp(settings.global["BZ-min-spawn-range"].value, settings.global["BZ-max-spawn-range"].value, math.random)
  local angle = Math.random()*2*math.pi
  return {x = radius * math.cos(angle), y = radius * math.sin(angle)}
end



function Boss.getAttackTarget(_)
  local force = game.forces.player
  local surface = game.surfaces[1]

  local biggestEntitycount = 0
  local attackTarget = nil
  for chunk in surface.get_chunks() do
    local entityCount = surface.count_entities_filtered({
      area = { left_top = { x = chunk.x * 32, y = chunk.y * 32 }, right_bottom = {x = (chunk.x + 1) * 32, y = (chunk.y + 1) * 32}},
      force = force
    })
    if entityCount > biggestEntitycount then
      biggestEntityCount = entityCount
      attackTarget = surface.find_entities_filtered({
        area = { left_top = { x = chunk.x * 32, y = chunk.y * 32 }, right_bottom = {x = (chunk.x + 1) * 32, y = (chunk.y + 1) * 32}},
        force = force,
        limit = 1
      })
    end
  end

  return attackTarget -- This can be a player (!)
end
