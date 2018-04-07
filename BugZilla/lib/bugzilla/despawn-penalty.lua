require "lib/utilities/generic"
--require "util"

DespawnPenalty = {}

DespawnPenalty.penalties = {
  ["bugzilla-biter"] = "pile-of-poop",
  ["bugzilla-spitter"] = "deadly-mine",
}



function DespawnPenalty:Init()
  if not global.BZ_despawnPenalty then
    global.BZ_despawnPenalty = self:InitGlobalData()
  end
end



function DespawnPenalty:OnConfigurationChanged()
  if not global.BZ_despawnPenalty then
    global.BZ_despawnPenalty = self:InitGlobalData()
  end

  if global.BZ_despawnPenalty.Version == '1' then
    global.BZ_despawnPenalty.Version = '2'

    local entities = DeepCopy(global.BZ_despawnPenalty.entities)
    global.BZ_despawnPenalty.entities = {
      ["pile-of-poop"] = DeepCopy(entities),
      ["deadly-mine"] = {},
    }

    local entityCount = global.BZ_despawnPenalty.entityCount
    global.BZ_despawnPenalty.entityCount = {
      ["pile-of-poop"] = entityCount,
      ["deadly-mine"] = 0,
    }

  end
end



function DespawnPenalty:OnSecond()
  local penaltyData = global.BZ_despawnPenalty

  -- pile of poops creating fart clouds
  if penaltyData.entityCount["pile-of-poop"] > 0 and (game.tick % penaltyData.fartUpdateRate) == 0 then

    for _, entity in pairs(penaltyData.entities["pile-of-poop"]) do
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



function DespawnPenalty:OnEntityDied(event)
  local penaltyData = global.BZ_despawnPenalty
  local entity = event.entity

  if penaltyData.entityCount[event.entity.name] and penaltyData.entityCount[event.entity.name] > 0 then
    -- find the index of this entityData
    for penaltyIndex, penaltyEntity in pairs(penaltyData.entities[entity.name]) do
      if entity == penaltyEntity then
        -- swap out this entity with last entity to keep all entities correctly
        penaltyData.entities[entity.name][penaltyIndex] = penaltyData.entities[entity.name][penaltyData.entityCount[entity.name]]
        penaltyData.entities[entity.name][penaltyData.entityCount[entity.name]] = nil
        penaltyData.entityCount[entity.name] = penaltyData.entityCount[entity.name] - 1

        -- Safe data
        global.BZ_despawnPenalty = penaltyData

        -- no need to look further, we found the entity already
        break
      end
    end
  end
end



function DespawnPenalty:CreateNewPenalty(entityData)
  local penaltyData = global.BZ_despawnPenalty

  if self.penalties[entityData.name] then
    local penaltyName = self.penalties[entityData.name]

    -- increment index
    local penaltyIndex = penaltyData.entityCount[penaltyName] + 1
    penaltyData.entityCount[penaltyName] = penaltyIndex

    -- create penalty entity
    penaltyData.entities[penaltyName][penaltyIndex] = entityData.surface.create_entity{
      name = penaltyName,
      position = entityData.position,
      force = entityData.force,
    }
  end

  -- save new data
  global.BZ_despawnPenalty = penaltyData
end



function DespawnPenalty:InitGlobalData()
  local penaltyData = {
    -- meta data
    Name = 'BZ_despawnPenalty',
    Version = '2',

    entities = {
      ["pile-of-poop"] = {},
      ["deadly-mine"] = {},
    },
    entityCount = {
      ["pile-of-poop"] = 0,
      ["deadly-mine"] = 0,
    },

    fartUpdateRate = 60 * (5 - 2),
  }

  return DeepCopy(penaltyData)
end
