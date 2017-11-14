require 'lib/utilities/math'

Boss = {}

Boss.types = {
  [1] = "bugzilla-biter",
}

Boss.messages = {}
Boss.messages.spawn_messages = {
  "BugZilla is prepairing an attack, being prepared would be advised.",
  "BugZilla found your hiding place, she will come after you...",
  "BugZilla couldn't sleep with all the noise... She might come silence you.",
  "Darkness falls upon the land... Evil is comming..."
}
Boss.messages.kill_messages = {
  "BugZilla died, let's hope there aren't any others...",
  "Here lies BugZilla, the big irritating bug... let's keep it that way.",
  "Rest in pieces BugZilla! Now let\'s automate More Faster!"
}
Boss.messages.despawn_messages = {
  "BugZilla is gone, let's hope \'it\' stays away...",
  "BugZilla was bored and walked away... Let's keep it away!",
  "You blinked with your eyes and before you knew BugZilla retreated."
}

Boss.reward = {
  {name='science-pack-1', count=200},
  {name='science-pack-2', count=200},
  {name='military-science-pack', count=150},
  {name='science-pack-3', count=150},
  {name='production-science-pack', count=150},
  {name='high-tech-science-pack', count=100},
  {name='space-science-pack', count=100}
}



function Boss.Init(self)
  game.forces.enemy.ai_controllable = false -- Make sure Boss don't spawn a spawner

  if not global.BZ_boss then
    global.BZ_boss = self:InitGlobalData()
  end
end



function Boss.InitGlobalData(_)
  local bossData = {
    -- meta data
    Name = 'BZ_boss',
    Version = '1',

    entity = nil,
    fart_cloud = nil,
  }
  return DeepCopy(bossData)
end



function Boss.OnSecond(self)
  if self:IsAlive() then
    if global.BZ_boss.entity.name == self.types[1] then -- bugzilla-biter
      self:FartCloudBehaviour()
    end
  end
end



function Boss.Spawn(self, boss_type)
  local boss_entity = global.BZ_boss.entity

  if boss_entity == nil then
    boss_entity = game.surfaces['nauvis'].create_entity{
      name = boss_type,
      force = game.forces.enemy,
      position = self:CreateBossSpawnPosition(boss_type, game.forces.enemy)
    }
    boss_entity.set_command({
      type = defines.command.attack_area,
      destination = {x=0, y=0},
      radius = settings.global["BZ-min-spawn-range"].value,
      distraction = defines.distraction.by_anything
    })

    global.BZ_boss.entity = boss_entity
    -- game.print("DEBUG BugZilla.lib.boss.lua: BugZilla spawned.")
  else
    -- game.print("DEBUG BugZilla.lib.boss.lua: BugZilla already exist.")
  end
end



function Boss.SpawnReward(self)
  local chest = 'steel-chest'
  local chest_entity = game.surfaces['nauvis'].create_entity{
    name = chest,
    force = game.forces.player,
    position = self:CreateRewardSpawnPosition(chest, game.forces.player)
  }

  local chest_inventory = chest_entity.get_inventory(defines.inventory.chest)
  if chest_inventory and chest_inventory.valid then
    local reward_index = math.random(#self.reward)
    local reward = self.reward[reward_index]
    local amount = chest_inventory.insert(reward)
    local prev_amount = 0

    -- Try to insert
    while amount == 0 do
      if reward_index == #reward_index then
        reward_index = 1
      else
        reward_index = reward_index + 1
      end
      amount = chest_inventory.insert(reward)
    end

    -- Add more if reward is more than one stack, till finished or chest full
    while amount < reward.count and amount ~= prev_amount do
      reward_extra = {name=reward.name, count=reward.count-amount}
      amount_added = chest_inventory.insert(reward_extra)
      if amount_added == 0 then
        break
      end
      amount = amount + amount_added
    end
  end
end



function Boss.GetSpawnMessage(self)
  return self.messages.spawn_messages[math.random(#self.messages.spawn_messages)]
end
function Boss.GetKillMessage(self)
  return self.messages.kill_messages[math.random(#self.messages.kill_messages)]
end
function Boss.GetDespawnMessage(self)
  return self.messages.despawn_messages[math.random(#self.messages.despawn_messages)]
end



function Boss.IsAlive(_)
  local boss_entity = global.BZ_boss.entity
  if boss_entity and boss_entity.valid then
    return true
  else
    return false
  end
end



function Boss.Despawn(self)
  local boss_entity = global.BZ_boss.entity
  local fart_cloud_entity = nil
  if boss_entity.name == self.types[0] then -- bugzilla-biter
    fart_cloud_entity = global.BZ_boss.fart_cloud
  end

  if boss_entity then
    if boss_entity.valid and boss_entity.destroy() then
      boss_entity = nil
      if fart_cloud_entity and fart_cloud_entity.valid and fart_cloud_entity.destroy() then
        fart_cloud_entity = nil
      end
      -- game.print("DEBUG BugZilla.lib.boss.lua: BugZilla destroyed.")
    else
      -- game.print("DEBUG BugZilla.lib.boss.lua: BugZilla not destroyed.")
    end
  else
    boss_entity = nil
    -- game.print("DEBUG BugZilla.lib.boss.lua: BugZilla didn't exist.")
  end

  global.BZ_boss.entity = boss_entity
end



function Boss.OnEntityDied(self, event)
  local boss = global.BZ_boss
  if boss.entity and event.entity == boss.entity then
    --game.print("DEBUG BugZilla.lib.bsoss.lua: BugZilla killed.")

    -- Spawn a reward
    self:SpawnReward()

    -- Update data
    boss.entity = nil
    if boss.fart_cloud then
      boss.fart_cloud.destroy()
      boss.fart_cloud = nil
    end
    global.BZ_boss = boss

    -- Go to the next phase
    PhaseCycler:GoToNextPhase()
  end
end



function Boss.CreateBossSpawnPosition(self, entity_name, entity_force)
  local iter = 0
  local try = 0
  local radius, angle, spawn

  while(iter >= 0) do
    radius = Math:Lerp(settings.global["BZ-min-spawn-range"].value, settings.global["BZ-max-spawn-range"].value + iter, math.random())
    angle = math.random()*2*math.pi
    spawn = {
      x = radius * math.cos(angle),
      y = radius * math.sin(angle)
    }

    if self:CheckCollision(entity_name, entity_force, spawn) then
      iter = -1
    elseif try >= 10 then
      try = 0
      iter = iter + 1
    end
  end

  return spawn
end



function Boss.CreateRewardSpawnPosition(self, entity_name, entity_force)
  local pos = global.BZ_boss.entity.position
  local iter = 5
  local try = 0
  local radius, angle, spawn

  while iter >= 0 do
    radius = Math:Lerp(0, 0 + iter, math.random())
    angle = math.random()*2*math.pi
    spawn = {
      x = Math:Round(pos.x + radius * math.cos(angle)),
      y = Math:Round(pos.y + radius * math.sin(angle))
    }

    if self:CheckCollision(entity_name, entity_force, spawn) then
      iter = -1
    elseif try >= 10 then
      try = 0
      iter = iter + 1
    end
  end

  return spawn
end


function Boss.CheckCollision(_, entity_name, entity_force, entity_position)
  return game.surfaces['nauvis'].can_place_entity{
    name = entity_name,
    position = entity_position,
    force = entity_force
  }
end



function Boss.FartCloudBehaviour(self)
  local boss = global.BZ_boss
  local threshold = 20

  -- Create fart cloud if requirements are met
  if not boss.fart_cloud then
    local pos = boss.entity.position
    local area = {
      left_top = {pos.x-5, pos.y-5},
      right_bottom = {pos.x+5, pos.y+5}
    }
    local belts = game.surfaces['nauvis'].count_entities_filtered{
      area = area,
      type = 'transport-belt',
      limit = threshold
    }
    belts = belts + game.surfaces['nauvis'].count_entities_filtered{
      area = area,
      type = 'splitter',
      limit = threshold
    }
    belts = belts + 4 * game.surfaces['nauvis'].count_entities_filtered{
      area = area,
      type = 'land-mine',
      limit = threshold/2
    }

    if belts >= threshold then
      boss.fart_cloud = game.surfaces['nauvis'].create_entity{
        name = 'fart-cloud',
        position = self:GetFartPosition(),
        force = 'enemy'
      }
      global.BZ_boss = boss
    end

  -- Fart cloud exist, time to deal some damage
  elseif boss.fart_cloud.valid then
    local pos = boss.entity.position
    local range = 10
    local entities = game.surfaces['nauvis'].find_entities_filtered {
      area = {
        left_top = {pos.x-range, pos.y-range},
        right_bottom = {pos.x+range, pos.y+range}
      },
      force = 'player'
    }
    if #entities then
      for _,entity in pairs(entities) do
        if entity.valid and entity.destructible then
          entity.damage(40, 'enemy', 'poison')
        end
      end
    end

  -- Invalid, or fart_cloud is gone
  else
    boss.fart_cloud = nil
    global.BZ_boss = boss
    -- game.print("BugZilla.lib.bugzilla.boss.lua: Invalid fart-cloud.")
  end
end



function Boss.GetFartPosition(self)
  local boss_entity = global.BZ_boss.entity
  local orientation = boss_entity.orientation
  local offset = game.entity_prototypes[boss_entity.name].selection_box.left_top
  return {
    x = boss_entity.position.x - offset.x * math.sin(2*math.pi*orientation),
    y = boss_entity.position.y - offset.y * math.cos(2*math.pi*orientation)
  }
end
