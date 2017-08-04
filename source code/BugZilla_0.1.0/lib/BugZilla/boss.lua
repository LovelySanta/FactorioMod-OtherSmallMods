require 'lib/utilities/math'

Boss = {}

function Boss.init()
  game.forces.enemy.ai_controllable = false -- Make sure Boss don't spawn a spawner
  Boss.entity = nil
end



function Boss.spawn(self)
  if Boss.entity == nil then
    -- TODO: check for luaSurface:: can_place_entity{...}
    Boss.entity = game.surfaces[1].create_entity{
      name = "behemoth-biter",
      force = game.forces.enemy,
      position = self:getSpawnPosition()
      target = self:getAttackTarget()
    }
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
  for chunk in surface.get_chunks() do
    if force.is_chunk_visible(surface, chunk)
      -- do calc
    end
  end
end
