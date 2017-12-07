
Boss = {}

Boss.types = {
  [1] = "bugzilla-biter",
}

Boss.messages = {}
Boss.messages.spawn_messages = {
  "BugZilla is prepairing an attack, being prepared would be advised.",
  "BugZilla found your hiding place, she will come after you...",
  "BugZilla couldn't sleep with all the noise... She might come silence you.",
  "Darkness falls upon the land... Evil is coming..."
}
Boss.messages.kill_messages = {
  "BugZilla died, let's hope there aren't any others...",
  "Here lies BugZilla, the big irritating bug... let's keep it that way.",
  "Rest in pieces BugZilla! Now let\'s automate More Faster!",
  "The stinky BugZilla died, she farts no more..."
}
Boss.messages.despawn_messages = {
  "BugZilla is gone, let's hope \'it\' stays away...",
  "BugZilla was bored and walked away... Let's keep it away!",
  "You blinked with your eyes and before you knew BugZilla retreated."
}

Boss.reward = {
  {name='science-pack-1', count=300},
  {name='science-pack-2', count=250},
  {name='military-science-pack', count=200},
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



function Boss.OnConfigurationChanged(self)
  local bossData = global.BZ_boss

  if not bossData.Version then
    bossData = self:InitGlobalData()

  else
    -- update version 1 --> 2
    if bossData.Version == '1' then
      bossData.Version = '2'

      bossData.entities = {}
      bossData.entityCount = 0
      if bossData.entity then
        local boss = {}
        boss.bossEntity = bossData.entity
        boss.fartEntity = bossData.fart_cloud
        boss.fartEntityTimer = 0
        bossData.entityCount = bossData.entityCount + 1
        bossData.entities[bossData.entityCount] = boss

        bossData.entity = nil
        bossData.fart_cloud = nil
      end
      bossData.killScore = 0

    end

    -- current version running: 2
    global.BZ_boss = bossData
  end
end



function Boss.InitGlobalData(_)
  local bossData = {
    -- meta data
    Name = 'BZ_boss',
    Version = '2',

    entities = {},
    entityCount = 0,
    killScore = 0
  }
  return DeepCopy(bossData)
end



function Boss.OnSecond(self)
  if self:IsAlive() then
    local entities = global.BZ_boss.entities
    for bossIndex, bossData in pairs(entities) do
      local bossEntity = bossData.bossEntity
      if bossEntity and bossEntity.valid and bossEntity.name == self.types[1] then -- bugzilla-biter
        self:FartCloudBehaviour(bossIndex)
      end
    end
  end
end



function Boss.Spawn(self)
  local bossEntities = global.BZ_boss.entities
  local bossEntityCount = global.BZ_boss.entityCount

  if bossEntityCount == 0 then
    -- for each type
    for _,spawnData in pairs(self:GetSpawnAmounts()) do
      local bossType = spawnData.type
      local bossAmount = spawnData.amount

      -- spawn amount
      for _=1, bossAmount, 1 do
        -- create a new boss and add it to existing entities
        bossEntityCount = bossEntityCount + 1
        bossEntities[bossEntityCount] = self:CreateNewBoss(bossType)
        -- game.print("DEBUG BugZilla.lib.boss.lua: BugZilla spawned.")
      end
    end

    -- save changes in data
    global.BZ_boss.entities = bossEntities
    global.BZ_boss.entityCount = bossEntityCount

  else
    -- game.print("DEBUG BugZilla.lib.boss.lua: BugZilla already exist.")
  end
end



function Boss.Despawn(self)
  local bossEntities = global.BZ_boss.entities
  local bossEntityCount = global.BZ_boss.entityCount
  local bossKillScore = global.BZ_boss.killScore

  -- Despawn all bosses
  while bossEntityCount > 0 do
    local bossData = bossEntities[bossEntityCount]

    local bossEntity = bossData.bossEntity
    local entityData = {}
    entityData.surface = bossEntity.surface
    entityData.name = bossEntity.name
    entityData.position = bossEntity.position
    entityData.force = bossEntity.force

    local fartEntity = bossData.fartEntity

    if bossEntity and bossEntity.valid and bossEntity.destroy() then
      if fartEntity and fartEntity.valid and fartEntity.can_be_destroyed() then
        fartEntity.destroy()
      end
      -- game.print("DEBUG BugZilla.lib.boss.lua: BugZilla destroyed.")

      -- Spawn Penalty
      DespawnPenalty:CreateNewPenalty(entityData)
    else
      -- game.print("DEBUG BugZilla.lib.boss.lua: BugZilla not destroyed.")
    end
    -- garbage collection will destroy the empty table

    bossEntities[bossEntityCount] = nil
    bossEntityCount = bossEntityCount - 1
    bossKillScore = bossKillScore - 1
  end

  -- Make score keeps 0 or above
  if bossKillScore < 0 then
    bossKillScore = 0
  end

  -- Display despawn message
  MessageAll(self:GetDespawnMessage())

  -- save changes in data
  global.BZ_boss.entities = bossEntities
  global.BZ_boss.entityCount = bossEntityCount
  global.BZ_boss.killScore = bossKillScore

  -- update UI
  DeathUI:UpdateAllLabels()
end



function Boss.OnEntityDied(self, event)
  -- Check if the boss died
  if self:CheckBossDied(event) then
    local bossEntities = global.BZ_boss.entities
    local bossEntityCount = global.BZ_boss.entityCount
    local bossKillScore = global.BZ_boss.killScore

    -- Find the correct bossEntity (it will be invalid)
    for bossIndex = 1, bossEntityCount, 1 do
      local bossEntity = bossEntities[bossIndex].bossEntity

      if bossEntity and bossEntity == event.entity then
        local fartEntity = bossEntities[bossIndex].fartEntity

        -- Spawn a reward
        self:SpawnReward(bossIndex)

        -- Remove the boss out of bossEntities
        bossRemovedData = bossEntities[bossIndex]
        -- Close the gap of the array
        for i = bossIndex + 1, bossEntityCount, 1 do
          bossEntities[i-1] = bossEntities[i]
        end
        bossEntities[bossEntityCount] = nil
        bossEntityCount = bossEntityCount - 1
        bossKillScore = bossKillScore + 1

        -- Check to remove the fart as wel
        if fartEntity and fartEntity.valid and fartEntity.can_be_destroyed() then
          fartEntity.destroy()
        end

        -- Display message if character kills it
        if event.cause and event.cause.valid and event.cause.type == "player" then
          MessageAll(event.cause.player.name.." delt the last bit of damage to BugZilla!")
        end
        -- Display the kill message
        MessageAll(self:GetKillMessage())

        -- No need to look further, it's already found
        break
      end
    end

    -- save changes in data
    global.BZ_boss.entities = bossEntities
    global.BZ_boss.entityCount = bossEntityCount
    global.BZ_boss.killScore = bossKillScore

    -- update UI
    DeathUI:UpdateAllLabels()

    -- Now we deleted the boss, check if we need to go to nextPhase
    if bossEntityCount == 0 then
      PhaseCycler:GoToNextPhase()
    end
  else
    -- TODO check for fart cloud entity died
  end
end



function Boss.CreateNewBoss(self, boss_type)
  local bossEntity = {}

  bossEntity.bossEntity = game.surfaces['nauvis'].create_entity{
    name = boss_type,
    force = game.forces.enemy,
    position = self:CreateBossSpawnPosition(boss_type, game.forces.enemy)
  }
  bossEntity.bossEntity.set_command({
    type = defines.command.attack_area,
    destination = {x=0, y=0},
    radius = settings.global["BZ-min-spawn-range"].value,
    distraction = defines.distraction.by_anything
  })
  bossEntity.fartEntity = nil
  bossEntity.fartEntityTimer = 0

  return bossEntity
end



function Boss.GetSpawnAmounts(self)
  local spawns = {}

  -- We only have one type yet
  --local spawnBiters = {type = self.types[1], amount = 2}
  --table.insert(spawns, spawnBiters)

  local killScore = global.BZ_boss.killScore

  local amount = Math:Round(math.sqrt((2*killScore+3)/5+1/2))
  if amount < 1 then
    amount = 1
  end

  local spawnBiters = {type = self.types[1], amount = amount}
  table.insert(spawns, spawnBiters)

  return spawns
end



function Boss.SpawnReward(self, bossIndex)
  local bossEntity = global.BZ_boss.entities[bossIndex].bossEntity
  local chest = 'steel-chest'
  local chest_entity = bossEntity.surface.create_entity{
    name = chest,
    force = game.forces.player,
    position = self:CreateRewardSpawnPosition(chest, game.forces.player, bossEntity.position)
  }
  chest_entity.destructible = false

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

    -- Now lets cap the chest
    chest_inventory.setbar(0)
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
  if global.BZ_boss.entityCount > 0 then
    return true
  end
  return false
end



function Boss.CheckBossDied(self, event)
  local EntityName = event.entity.name
  for _, BossName in pairs (self.types) do
    if EntityName == BossName then
      return true
    end
  end
  return false
end



function Boss.CreateBossSpawnPosition(self, entityName, entityForce)
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

    if self:CheckCollision(entityName, entityForce, spawn) then
      iter = -1
    elseif try >= 10 then
      try = 0
      iter = iter + 1
    else
      try = try + 1
    end
  end

  return spawn
end



function Boss.CreateRewardSpawnPosition(self, entityName, entityForce, position)
  local iter = 0 -- TODO why not 0?
  local try = 0
  local radius, angle, spawn

  while iter >= 0 do
    radius = Math:Lerp(0, 0 + iter, math.random())
    angle = math.random()*2*math.pi
    spawn = {
      x = Math:Round(position.x + radius * math.cos(angle)),
      y = Math:Round(position.y + radius * math.sin(angle))
    }

    if self:CheckCollision(entityName, entityForce, spawn) then
      iter = -1
    elseif try >= 10 then
      try = 0
      iter = iter + 1
    else
      try = try + 1
    end
  end

  return spawn
end



function Boss.CheckCollision(_, entityName, entityForce, entityPosition)
  return game.surfaces['nauvis'].can_place_entity{
    name = entityName,
    position = entityPosition,
    force = entityForce
  }
end



function Boss.FartCloudBehaviour(self, bossIndex)
  local bossData = global.BZ_boss.entities[bossIndex]
  local bossEntity = bossData.bossEntity
  local fartEntity = bossData.fartEntity
  local fartEntityTimer = bossData.fartEntityTimer

  local threshold = 20

  -- Create fart cloud if requirements are met
  if not fartEntity then
    local surface = bossEntity.surface
    local pos = bossEntity.position
    local area = {
      left_top = {pos.x-5, pos.y-5},
      right_bottom = {pos.x+5, pos.y+5}
    }
    local entities = surface.count_entities_filtered{
      area = area,
      type = 'transport-belt',
      limit = threshold
    }
    entities = entities + surface.count_entities_filtered{
      area = area,
      type = 'splitter',
      limit = threshold
    }
    entities = entities + 4 * surface.count_entities_filtered{
      area = area,
      type = 'land-mine',
      limit = Math:Round(threshold / 4)
    }
    entities = entities + .5 * surface.count_entities_filtered{
      area = area,
      type = 'ammo-turret',
      limit = threshold * 2
    }
    entities = entities + 2 * surface.count_entities_filtered{
      area = area,
      type = 'tree',
      limit = Math:Round(threshold / 2)
    }

    if (entities >= threshold and fartEntityTimer > 1) or fartEntityTimer > 15 then
      fartEntity = surface.create_entity{
        name = 'fart',
        position = self:GetFartPosition(bossEntity),
        force = 'enemy',
        target = bossEntity,
        speed = 0.15
      }
      fartEntityTimer = 0

    else -- No cloud spawned, then increase default time
      fartEntityTimer = fartEntityTimer + 1
    end

  -- There is/was a fart cloud,
  -- update date if it's invalid, or fart_cloud is gone
  elseif not fartEntity.valid then
    fartEntity = nil
    fartEntityTimer = 0
    -- game.print("BugZilla.lib.bugzilla.boss.lua: Invalid fart-cloud.")
  end

  -- save changes in data
  bossData.fartEntity = fartEntity
  bossData.fartEntityTimer = fartEntityTimer
  global.BZ_boss.entities[bossIndex] = bossData

end



function Boss.GetFartPosition(self, bossEntity)
  local orientation = bossEntity.orientation
  local offset = game.entity_prototypes[bossEntity.name].selection_box.left_top
  return {
    x = bossEntity.position.x - offset.x * math.sin(2*math.pi*orientation),
    y = bossEntity.position.y - offset.y * math.cos(2*math.pi*orientation)
  }
end
