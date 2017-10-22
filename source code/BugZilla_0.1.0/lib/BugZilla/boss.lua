require 'lib/utilities/math'

Boss = {}

function Boss.Init()
  game.forces.enemy.ai_controllable = false -- Make sure Boss don't spawn a spawner
  Boss.entity = nil
end



function Boss.Spawn(_)
  if Boss.entity == nil then
    Boss.entity = game.surfaces['nauvis'].create_entity{
      name = "behemoth-biter",
      force = game.forces.enemy,
      position = Boss:createSpawnPosition("behemoth-biter", game.forces.enemy)
    }
    Boss.entity.set_command({
      type = defines.command.attack_area,
      destination = {x=0, y=0},
      radius = settings.global["BZ-min-spawn-range"].value,
      distraction = defines.distraction.by_anything
    })
  else
    game.print("BugZilla.lib.boss.lua: BugZilla already exist.")
  end
end



function Boss.createSpawnPosition(self, entity_name, entity_force)
  local iter = 10 -- For safety reasons
  local radius, angle, spawn

  while(iter > 0) do
    radius = Math.Lerp(settings.global["BZ-min-spawn-range"].value, settings.global["BZ-max-spawn-range"].value, math.random())
    angle = math.random()*2*math.pi
    spawn = {x = radius * math.cos(angle), y = radius * math.sin(angle)}

    if self:checkCollision(entity_name, entity_force, spawn) then
      iter = -1
    else
      iter = iter - 1
    end
  end
  
  return spawn
end



function Boss.checkCollision(_, entity_name, entity_force, entity_position)
  return game.surfaces['nauvis'].can_place_entity{
    name = entity_name,
    position = entity_position,
    force = entity_force
  }
end
