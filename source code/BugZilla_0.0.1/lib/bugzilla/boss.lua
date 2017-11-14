require 'lib/utilities/math'

Boss = {}

Boss.types = {
  [0] = "bugzilla-biter",
}



function Boss.Init()
  game.forces.enemy.ai_controllable = false -- Make sure Boss don't spawn a spawner
  Boss.entity = nil
end



function Boss.Spawn(boss_type)
  if Boss.entity == nil then
    Boss.entity = game.surfaces['nauvis'].create_entity{
      name = boss_type,
      force = game.forces.enemy,
      position = Boss:createSpawnPosition(boss_type, game.forces.enemy)
    }
    Boss.entity.set_command({
      type = defines.command.attack_area,
      destination = {x=0, y=0},
      radius = settings.global["BZ-min-spawn-range"].value,
      distraction = defines.distraction.by_anything
    })
    game.print("DEBUG BugZilla.lib.boss.lua: BugZilla spawned.")
  else
    game.print("DEBUG BugZilla.lib.boss.lua: BugZilla already exist.")
  end
end



function Boss.IsAlive()
  if Boss.entity and Boss.entity.valid then
    return true
  else
    return false
  end
end



function Boss.Despawn()
  if Boss.entity then
    if Boss.entity.valid and Boss.entity.destroy() then
      Boss.entity = nil
      game.print("DEBUG BugZilla.lib.boss.lua: BugZilla destroyed.")
    else
      game.print("DEBUG BugZilla.lib.boss.lua: BugZilla not destroyed.")
    end
  else
    Boss.entity = nil
    game.print("DEBUG BugZilla.lib.boss.lua: BugZilla didn't exist.")
  end
end



function Boss.OnEntityDied(self, event)
  if self.entity and self.entity.valid and event.entity == self.entity then
    self.entity = nil
    game.print("DEBUG BugZilla.lib.boss.lua: BugZilla killed.")
    PhaseCycler:GoToNextPhase()
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
