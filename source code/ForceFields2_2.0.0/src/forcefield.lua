require 'src/settings'
require 'src/utilities'


Forcefield = {}  -- TODO


function Forcefield:onForcefieldDamaged(surface, pos)
  local index = surface.index

  pos.x = math.floor(pos.x)
  pos.y = math.floor(pos.y)
  if global.forcefields.searchDamagedPos == nil then
    global.forcefields.searchDamagedPos = {}
  end
  if global.forcefields.searchDamagedPos[index] == nil then
    global.forcefields.searchDamagedPos[index] = {}
  end
  if global.forcefields.searchDamagedPos[index][pos.x] == nil then
    global.forcefields.searchDamagedPos[index][pos.x] = {}
  end
  global.forcefields.searchDamagedPos[index][pos.x][pos.y] = 1
  Emitter:activateTicker()
end



function Forcefield:onForcefieldDied(field)
  local pos = field.position
  local surface = field.surface
  local index = surface.index

  if global.forcefields.fields ~= nil and global.forcefields.fields[index] ~= nil and global.forcefields.fields[index][pos.x] ~= nil and global.forcefields.fields[index][pos.x][pos.y] ~= nil then
    local emitterID = global.forcefields.fields[index][pos.x][pos.y]
    self:removeForceFieldID(index, pos.x, pos.y)
    if global.forcefields.emitters ~= nil and global.forcefields.emitters[emitterID] ~= nil then
      Emitter:setActive(global.forcefields.emitters[emitterID], true)
    end
    if Settings.forcefieldTypes[field.name]["deathEntity"] ~= nil then
      surface.create_entity({name = Settings.forcefieldTypes[field.name]["deathEntity"], position = pos, force = field.force})
    end
  end
end



function Forcefield:onForcefieldMined(field, playerIndex)
  if playerIndex ~= nil then
    local player = game.players[playerIndex]
    if player.character ~= nil then
      player.character.damage(Settings.forcefieldTypes[field.name]["damageWhenMined"], player.force)
    end
  end

  if global.forcefields.fields ~= nil then
    local pos = field.position
    local index = field.surface.index
    if global.forcefields.fields[index] ~= nil and global.forcefields.fields[index][pos.x] ~= nil and global.forcefields.fields[index][pos.x][pos.y] ~= nil then
      local emitterTable = global.forcefields.emitters[global.forcefields.fields[index][pos.x][pos.y]]
      if emitterTable then
        Emitter:setActive(emitterTable, true)
      end
      self:removeForceFieldID(index, pos.x, pos.y)
    end
  end
end



function Forcefield:scanAndBuildFields(emitterTable)
  local buildField

  if emitterTable["build-tick"] == 0 then
    local energyBefore = emitterTable["entity"].energy
    -- Check to make sure there is enough energy
    if emitterTable["entity"].energy >= (Settings.tickRate * Settings.forcefieldTypes[emitterTable["type"]]["energyPerRespawn"] + Settings.tickRate * Settings.forcefieldTypes[emitterTable["type"]]["energyPerCharge"]) then
      local pos, xInc, yInc, incTimes = self:getFieldsArea(emitterTable)
      local blockingFields = 0
      local blockingFieldsBefore = 0
      local direction
      local force = emitterTable["entity"].force
      local surface = emitterTable["entity"].surface
      local index = surface.index

      -- Check the direction of the wall
      if emitterTable["direction"] == defines.direction.north or emitterTable["direction"] == defines.direction.south then
        direction = defines.direction.east
      else
        direction = defines.direction.north
      end

      -- Check if table for that surface exist, if not, make it
      if global.forcefields.fields == nil then
        global.forcefields.fields = {}
      end
      if global.forcefields.fields[index] == nil then
        global.forcefields.fields[index] = {}
      end

      for n=1,incTimes do
        -- If another emitter (or even this one previously) has built a field at this location, skip trying to build there
        if global.forcefields.fields[index][pos.x] == nil or global.forcefields.fields[index][pos.x][pos.y] == nil then
          -- If that spot has no field, try and build one
          if surface.can_place_entity({name = emitterTable["type"], position = pos, direction = direction}) then
            local newField = surface.create_entity({name = emitterTable["type"], position = pos, force = force, direction = direction})

            -- This new entity will have 0 health on creation + one load of recharge this tick
            newField.health = Settings.forcefieldTypes[emitterTable["type"]]["chargeRate"]
            if emitterTable["generating-fields"] == nil then
              emitterTable["generating-fields"] = {}
            end
            table.insert(emitterTable["generating-fields"], newField)

            if global.forcefields.fields[index][pos.x] == nil then
              global.forcefields.fields[index][pos.x] = {}
            end
            global.forcefields.fields[index][pos.x][pos.y] = emitterTable["emitter-NEI"]

            -- We have build a new field, congratz
            buildField = true
            -- Remove the power consumption for this tick
            emitterTable["entity"].energy = emitterTable["entity"].energy -  (Settings.tickRate * Settings.forcefieldTypes[emitterTable["type"]]["energyPerRespawn"])
            -- If we can't get to the end, we need to degrade as we have no power to maintain the full field
            if n ~= incTimes and emitterTable["entity"].energy == 0 then
              emitterTable["build-tick"] = forcefieldTypes[emitterTable["type"]]["respawnRate"] * 10
              self:degradeLinkedFields(emitterTable)
              break
            end
            blockingFields = blockingFields + 1
          else -- If we can't place the field
            local blockingField = self:findForcefieldsRadius(surface, pos, 0.4, true)
            if blockingField ~= nil then
              if global.forcefields.degradingFields ~= nil then
                -- Prevents the emitter from going into extended sleep from "can't build" due to degrading fields (happens most when switching field types)
                local fpos = blockingField[1].position
                for _,field in pairs(global.forcefields.degradingFields) do
                  if field["entity"].position.x == pos.x and field["entity"].position.y == pos.y then
                    builtField = true
                    break
                  end
                end
              end
            else
              -- Some other entity (other than a force field) is standing in the way, so we need to destroy it
              surface.create_entity({name = "forcefield-build-damage", position = pos, force = force})
            end
          end
        else -- There is already some field here, by this or an previous field
          blockingFields = blockingFields + 1
        end

        -- onto the next field section of this field
        pos.x = pos.x + xInc
        pos.y = pos.y + yInc
      end

      -- full field is build
      if global.forcefields.fields then
        if tableIsEmpty(global.forcefields.fields[index]) then
          global.forcefields.fields[index] = nil
        end

        if tableIsEmpty(global.forcefields.fields) then
          global.forcefields.fields = nil
        end
      end

      -- check if the whole field is blocked
      if blockingFields == incTimes then
        emitterTable["build-scan"] = nil
        return false
      else
        -- if the field is partialy blocked, we need to keep building it
        if not builtField then
          emitterTable["build-tick"] = Settings.forcefieldTypes[emitterTable["type"]]["respawnRate"] * 3 + math.random(Settings.forcefieldTypes[emitterTable["type"]]["respawnRate"])
        else
          emitterTable["build-tick"] = Settings.forcefieldTypes[emitterTable["type"]]["respawnRate"]
        end
      end
    else -- If there is not enough energy, time to degrade
      emitterTable["build-tick"] = Settings.forcefieldTypes[emitterTable["type"]]["respawnRate"] * 5
      self:degradeLinkedFields(emitterTable)
    end

  else -- If its not time to build yet, decriment
    emitterTable["build-tick"] = emitterTable["build-tick"] - 1
  end

  return true
end



function Forcefield:generateFields(emitterTable)
  local availableEnergy = emitterTable["entity"].energy

  -- Generate each field
  for k,field in pairs(emitterTable["generating-fields"]) do
    if field.valid then
      -- Generate field if enough energy
      if availableEnergy >= (Settings.forcefieldTypes[field.name]["energyPerCharge"] * Settings.tickRate) then
        field.health = field.health + (Settings.forcefieldTypes[field.name]["chargeRate"] * Settings.tickRate)
        availableEnergy = availableEnergy - (Settings.forcefieldTypes[field.name]["energyPerCharge"] * Settings.tickRate)
        -- If field is fully generated, remove out of the table
        if field.health >= Settings.forcefieldTypes[field.name]["maxHealth"] then
          table.remove(emitterTable["generating-fields"], k)
        end
      else -- If not enough energy
        self:degradeLinkedFields(emitterTable)
        emitterTable["generating-fields"] = {}
        emitterTable["build-tick"] = Settings.forcefieldTypes[emitterTable["type"]]["respawnRate"] * 10
        Emitter:setActive(emitterTable, true, true)
      end
    else -- If invalid for some reason, delete it
      table.remove(emitterTable["generating-fields"], k)
    end
  end

  -- update energy of emitter
  emitterTable["entity"].energy = availableEnergy

  if #emitterTable["generating-fields"] == 0 then
    emitterTable["generating-fields"] = nil
  else
    return true
  end
end



function Forcefield:regenerateFields(emitterTable)
  local availableEnergy = emitterTable["entity"].energy
  local neededEnergy

  for k,field in pairs(emitterTable["damaged-fields"]) do
    if field.valid then
      neededEnergy = Settings.forcefieldTypes[field.name]["energyPerHealthLost"] * (Settings.forcefieldTypes[field.name]["maxHealth"] - field.health)
      -- If enough energy, we repair
      if availableEnergy >= neededEnergy then
        field.health = Settings.forcefieldTypes[field.name]["maxHealth"]
        availableEnergy = availableEnergy - neededEnergy
        table.remove(emitterTable["damaged-fields"], k)
      else -- Not enough energy, degrade the wall
        self:degradeLinkedFields(emitterTable)
        emitterTable["damaged-fields"] = {}
        emitterTable["build-tick"] = Settings.forcefieldTypes[emitterTable["type"]]["respawnRate"] * 10
        Emitter:setActive(emitterTable, true, true)
      end
    else -- Remove if invalid
      table.remove(emitterTable["damaged-fields"], k)
    end
  end

  emitterTable["entity"].energy = availableEnergy
  if #emitterTable["damaged-fields"] == 0 then
    emitterTable["damaged-fields"] = nil
  else
    return true
  end
end



function Forcefield:handleDamagedFields(forceFields)
  local pos
  local surface
  local index
  local fieldShouldBeAdded
  local addedFields
  local fieldID

  if global.forcefields.fields ~= nil and global.forcefields.emitters ~= nil then
    -- For each possibly damaged forcefield found
    for k,field in pairs(forceFields) do
      pos = field.position
      surface = field.surface
      index = surface.index
      fieldShouldBeAdded = true

      -- If the field is known to the mod
      if global.forcefields.fields[index] ~= nil and global.forcefields.fields[index][pos.x] ~= nil and global.forcefields.fields[index][pos.x][pos.y] ~= nil then
        fieldID = global.forcefields.fields[index][pos.x][pos.y]
        -- If the field has a valid linked emitter
        if global.forcefields.emitters[fieldID] ~= nil then
          if global.forcefields.emitters[fieldID]["generating-fields"] ~= nil then
            for _,generatingField in pairs(global.forcefields.emitters[fieldID]["generating-fields"]) do
              if generatingField == field then
                fieldShouldBeAdded = false
                break
              end
            end
          end

          -- Add the damaged field to the emitter damaged field table if it isn't already in it
          if fieldShouldBeAdded then
            if global.forcefields.emitters[fieldID]["damaged-fields"] == nil then
              global.forcefields.emitters[fieldID]["damaged-fields"] = {}
            end
            table.insert(global.forcefields.emitters[fieldID]["damaged-fields"], field)
            Emitter:setActive(global.forcefields.emitters[fieldID])
            addedFields = true
          end
        end
      end
    end
  end
end



function Forcefield:getFieldsArea(emitterTable)
  local scanDirection = emitterTable["direction"]
  local pos = {}
  local xInc = 0
  local yInc = 0

  if scanDirection == defines.direction.north then
    pos.x = emitterTable["entity"].position.x - (emitterTable["width"] - 1) / 2
    pos.y = emitterTable["entity"].position.y - emitterTable["distance"]
    xInc = 1
  elseif scanDirection == defines.direction.east then
    pos.x = emitterTable["entity"].position.x + emitterTable["distance"]
    pos.y = emitterTable["entity"].position.y - (emitterTable["width"] - 1) / 2
    yInc = 1
  elseif scanDirection == defines.direction.south then
    pos.x = emitterTable["entity"].position.x + (emitterTable["width"] - 1) / 2
    pos.y = emitterTable["entity"].position.y + emitterTable["distance"]
    xInc = -1
  else
    pos.x = emitterTable["entity"].position.x - emitterTable["distance"]
    pos.y = emitterTable["entity"].position.y + (emitterTable["width"] - 1) / 2
    yInc = -1
  end

  return pos, xInc, yInc, emitterTable["width"]
end



function Forcefield:findForcefieldsArea(surface, area, includeFullHealth)
  local walls = surface.find_entities_filtered({area = area, type = "wall"})
  local gates = surface.find_entities_filtered({area = area, type = "gate"})
  local foundFields = {}

  if #walls ~= 0 then
    for i,wall in pairs(walls) do
      if Settings.forcefieldTypes[wall.name] ~= nil and (includeFullHealth or wall.health ~= Settings.forcefieldTypes[wall.name]["maxHealth"]) then
        table.insert(foundFields, wall)
      end
    end
  end
  if #gates ~= 0 then
    for i,gate in pairs(gates) do
      if Settings.forcefieldTypes[gate.name] ~= nil and (includeFullHealth or gate.health ~= Settings.forcefieldTypes[gate.name]["maxHealth"]) then
        table.insert(foundFields, gate)
      end
    end
  end

  if #foundFields ~= 0 then
    return foundFields
  end
end



function Forcefield:findForcefieldsRadius(surface, position, radius, includeFullHealth)
  local walls = surface.find_entities_filtered({area = {{x = position.x - radius, y = position.y - radius}, {x = position.x + radius, y = position.y + radius}}, type = "wall"})
  local gates = surface.find_entities_filtered({area = {{x = position.x - radius, y = position.y - radius}, {x = position.x + radius, y = position.y + radius}}, type = "gate"})
  local foundFields = {}

  if #walls ~= 0 then
    for i,wall in pairs(walls) do
      if Settings.forcefieldTypes[wall.name] ~= nil and (includeFullHealth or wall.health ~= Settings.forcefieldTypes[wall.name]["maxHealth"]) then
        table.insert(foundFields, wall)
      end
    end
  end

  if #gates ~= 0 then
    for i,gate in pairs(gates) do
      if Settings.forcefieldTypes[gate.name] ~= nil and (includeFullHealth or gate.health ~= Settings.forcefieldTypes[gate.name]["maxHealth"]) then
        table.insert(foundFields, gate)
      end
    end
  end

  if #foundFields ~= 0 then
    return foundFields
  end
end



function Forcefield:degradeLinkedFields(emitterTable)
  if global.forcefields.fields ~= nil then
    local pos1, xInc, yInc, incTimes = self:getFieldsArea(emitterTable)
    local pos2 = {x = pos1.x + (xInc * incTimes), y = pos1.y + (yInc * incTimes)}
    local surface = emitterTable["entity"].surface
    local fields
    if xInc == -1 or yInc == -1 then
      fields = self:findForcefieldsArea(surface, {pos2, pos1}, true)
    else
      fields = self:findForcefieldsArea(surface, {pos1, pos2}, true)
    end

    if fields then
      if global.forcefields.degradingFields == nil then
        global.forcefields.degradingFields = {}
      end
      local index = surface.index
      for k,field in pairs(fields) do
        pos = field.position
        if global.forcefields.fields[index] ~= nil and global.forcefields.fields[index][pos.x] ~= nil and global.forcefields.fields[index][pos.x][pos.y] == emitterTable["emitter-NEI"] then
          table.insert(global.forcefields.degradingFields, {["entity"] = field, ["position"] = field.position, ["surface"] = surface})
          self:removeForcefield(field)

          if global.forcefields.fields == nil then
            break
          end
        end
      end

      if #global.forcefields.degradingFields == 0 then
        global.forcefields.degradingFields = nil
      else
        Emitter:activateTicker()
      end
    end
  end
end



function Forcefield:removeDegradingFieldID(fieldID)
  -- Returns true if the global.forcefields.degradingFields table isn't empty
  if global.forcefields.degradingFields ~= nil then
    local pos = global.forcefields.degradingFields[fieldID]["position"]
    local surface = global.forcefields.degradingFields[fieldID]["surface"]
    table.remove(global.forcefields.degradingFields, fieldID)
    local emitters = surface.find_entities_filtered({area = {{x = pos.x - Settings.maxFieldDistance, y = pos.y - Settings.maxFieldDistance}, {x = pos.x + Settings.maxFieldDistance, y = pos.y + Settings.maxFieldDistance}}, name = emitterName})
    local emitterTable
    for _,emitter in pairs(emitters) do
      emitterTable = Emitter:findEmitter(emitter)
      if emitterTable then
        Emitter:setActive(emitterTable, true)
      end
    end
    if #global.forcefields.degradingFields == 0 then
      global.forcefields.degradingFields = nil
    else
      return true
    end
  end
end



function Forcefield:removeForcefield(field)
  if global.forcefields.fields ~= nil then
    local pos = field.position
    local index = field.surface.index
    if global.forcefields.fields[index] ~= nil and global.forcefields.fields[index][pos.x] ~= nil and global.forcefields.fields[index][pos.x][pos.y] ~= nil then
      self:removeForceFieldID(index, pos.x, pos.y)
    end
  end
end



function Forcefield:removeForceFieldID(index, x, y)
  -- Does no checking, make sure its a valid table index
  global.forcefields.fields[index][x][y] = nil
  if tableIsEmpty(global.forcefields.fields[index][x]) then
    global.forcefields.fields[index][x] = nil
    if tableIsEmpty(global.forcefields.fields[index]) then
      global.forcefields.fields[index] = nil
    end
    if tableIsEmpty(global.forcefields.fields) then
      global.forcefields.fields = nil
    end
  end
end
