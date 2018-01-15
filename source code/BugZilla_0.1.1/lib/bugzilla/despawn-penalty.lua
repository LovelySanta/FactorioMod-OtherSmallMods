
DespawnPenalty = {}

function DespawnPenalty.Init(self)
  if not global.BZ_despawnPenalty then
    global.BZ_despawnPenalty = self:InitGlobalData()
  end
end



function DespawnPenalty.OnConfigurationChanged(self)
  if not global.BZ_despawnPenalty then
    global.BZ_despawnPenalty = self:InitGlobalData()
  end
end



function DespawnPenalty.OnSecond(self)
  local penaltyData = global.BZ_despawnPenalty
  if penaltyData.entityCount > 0 and (game.tick % penaltyData.fartUpdateRate) == 0 then

    for _, entity in pairs(penaltyData.entities) do
      if entity and entity.valid and entity.health > 0 then
        entity.surface.create_entity{
          name = "fart-cloud",
          position = entity.position,
          force = entity.force
        }
      end
    end

  end
end



function DespawnPenalty.OnEntityDied(self, event)
  local penaltyData = global.BZ_despawnPenalty
  local entity = event.entity

  if penaltyData.entityCount > 0 and entity and entity.name == "pile-of-poop" then
    -- find the index of this entityData
    for poopIndex, poopEntity in pairs(penaltyData.entities) do
      if entity == poopEntity then
        -- swap out this entity with last entity to keep all entities correctly
        penaltyData.entities[poopIndex] = penaltyData.entities[penaltyData.entityCount]
        penaltyData.entities[penaltyData.entityCount] = nil
        penaltyData.entityCount = penaltyData.entityCount - 1

        -- Safe data
        global.BZ_despawnPenalty = penaltyData

        -- no need to look further, we found the entity already
        break
      end
    end
  end
end



function DespawnPenalty.CreateNewPenalty(self, entityData)
  local penaltyData = global.BZ_despawnPenalty

  if entityData.name == "bugzilla-biter" then
    penaltyData.entityCount = penaltyData.entityCount + 1
    penaltyData.entities[penaltyData.entityCount] = entityData.surface.create_entity{
      name = "pile-of-poop",
      position = entityData.position,
      force = entityData.force,
    }
  end

  -- save new data
  global.BZ_despawnPenalty = penaltyData
end



function DespawnPenalty.InitGlobalData(self)
  local penaltyData = {
    -- meta data
    Name = 'BZ_despawnPenalty',
    Version = '1',

    entities = {},
    entityCount = 0,

    fartUpdateRate = 60 * (5 - 2),
  }

  return DeepCopy(penaltyData)
end
