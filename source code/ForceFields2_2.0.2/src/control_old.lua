
local loaded
local tickRate = 20
local toolName = "forcefield-tool"
local toolRadius = 0.1
local fieldSuffix = "-forcefield"
local fieldgateSuffix = "-forcefield-gate"
local fieldDamagedTriggerName = "forcefield-damaged"
local emitterName = "forcefield-emitter"
local maxRangeUpgrades = 23
local maxWidthUpgrades = 10
local widthUpgradeMultiplier = 4
local emitterDefaultDistance = 10
local emitterDefaultWidth = 25
local emitterMaxDistance = emitterDefaultDistance + maxRangeUpgrades
local emitterMaxWidth = emitterDefaultWidth + (maxWidthUpgrades * widthUpgradeMultiplier)
local defaultFieldType = "blue-forcefield"
local maxFieldDistance = math.max(emitterMaxDistance, emitterMaxWidth)

--[[
  chargeRate: tickRate * chargeRate = new field health generation per tick
  degradeRate: tickRate * degradeRate = health loss per tick when degrading
  respawnRate: tickRate * respawnRate = ticks between field respawn
  energyPerCharge: tickRate * energyPerCharge = energy used per initial health generation
  energyPerRespawn: tickRate * energyPerRespawn = energy per field respawn
  energyPerHealthLost: the amount of energy per health lost to regenerate the field per health lost once the field is fully generated
  damageWhenMined: damage dealt to the player mining a field
--]]

local forcefieldTypes =
{
  ["blue" .. fieldSuffix] =
  {
    chargeRate = 0.2036111111111111,
    degradeRate = 2.777777777777778,
    respawnRate = 15,
    energyPerCharge = 4200,
    energyPerRespawn = 5000,
    energyPerHealthLost = 17000,
    damageWhenMined = 20,
    maxHealth = 300
  },
  ["green" .. fieldSuffix] =
  {
    chargeRate = 0.175,
    degradeRate = 2,
    respawnRate = 50,
    energyPerCharge = 4000,
    energyPerRespawn = 20000,
    energyPerHealthLost = 16000,
    damageWhenMined = 30,
    maxHealth = 700
  },
  ["purple" .. fieldSuffix] =
  {
    chargeRate = 0.2083333333333334,
    degradeRate = 3.333333333333333,
    respawnRate = 100,
    energyPerCharge = 7000,
    energyPerRespawn = 10000,
    energyPerHealthLost = 25000,
    damageWhenMined = 15,
    deathEntity = "forcefield-death-damage",
    maxHealth = 150
  },
  ["red" .. fieldSuffix] =
  {
    chargeRate = 0.175,
    degradeRate = 4.333333333333333,
    respawnRate = 30,
    energyPerCharge = 10000,
    energyPerRespawn = 50000,
    energyPerHealthLost = 40000,
    damageWhenMined = 99,
    maxHealth = 300
  }
}



remote.add_interface("forcefields", {
  test = function()
    for _,player in pairs(game.players) do
      transferToPlayer(player, {name = "forcefield-emitter", count = 50})
      transferToPlayer(player, {name = "forcefield-tool", count = 2})
      transferToPlayer(player, {name = "processing-unit", count = 50})
      transferToPlayer(player, {name = "advanced-circuit", count = 50})
    end
  end,
  reset = function()
    global.emitters = nil
    global.fields = nil
    global.searchDamagedPos = nil
    global.activeEmitters = nil
    global.degradingFields = nil
    global.ticking = nil
    global.emitterConfigGUIs = nil
    script.on_event(defines.events.on_tick, nil)
    
    for k,surface in pairs(game.surfaces) do
      local minx = 0
      local miny = 0
      local maxx = 0
      local maxy = 0
      for coord in surface.get_chunks() do
        if coord.x < minx then
          minx = coord.x
        end
        if coord.x > maxx then
          maxx = coord.x
        end
        if coord.y < miny then
          miny = coord.y
        end
        if coord.y > maxy then
          maxy = coord.y
        end
      end
      minx = minx * 32
      maxx = maxx * 32
      miny = miny * 32
      maxy = maxy * 32
    
      for name in pairs(forcefieldTypes) do
        for _,v in pairs(surface.find_entities_filtered({area = {{minx, miny}, {maxx, maxy}}, name = name})) do
          v.destroy()
        end
      end
      for _,v in pairs(surface.find_entities_filtered({area = {{minx, miny}, {maxx, maxy}}, name = emitterName})) do
        v.destroy()
      end
    end
    for _,player in pairs(game.players) do
      if player.gui.center.emitterConfig ~= nil then
        player.gui.center.emitterConfig.destroy()
      end
    end
  end
})

function throwError(what)
  for _,player in pairs(game.players) do
    player.print(what)
  end
end

function verifySettings()
  if tickRate < 0 then
    tickRate = 0
    throwError("Tick rate must be >= 0.")
  end
  
  if toolRadius < 0 then
    toolRadius = 0
    throwError("Tool radius must be >= 0.")
  end
  
  if emitterDefaultDistance < 1 then
    emitterDefaultDistance = 1
    emitterMaxDistance = emitterDefaultDistance + maxRangeUpgrades
    maxFieldDistance = math.max(emitterMaxDistance, emitterMaxWidth)
    throwError("Emitter default distance must be >= 1.")
  end
  
  if emitterDefaultWidth < 1 then
    emitterDefaultWidth = 1
    throwError("Emitter default width must be >= 1.")
    emitterMaxWidth = emitterDefaultWidth + (maxWidthUpgrades * widthUpgradeMultiplier)
    maxFieldDistance = math.max(emitterMaxDistance, emitterMaxWidth)
  elseif (math.floor((emitterDefaultWidth - 1) / 2) * 2) + 1 ~= emitterDefaultWidth then
    emitterDefaultWidth = 25
    throwError("Emitter default width must be an odd number (or one).")
    emitterMaxWidth = emitterDefaultWidth + (maxWidthUpgrades * widthUpgradeMultiplier)
    maxFieldDistance = math.max(emitterMaxDistance, emitterMaxWidth)
  end
  
  if not forcefieldTypes[defaultFieldType] then
    defaultFieldType = "blue" .. fieldSuffix
    throwError("Emitter default field type isn't known.")
  end
end

script.on_configuration_changed(function(data)
  verifySettings()
  global.version = 1.0
end)

script.on_load(function(event)
  if global.ticking then
    script.on_event(defines.events.on_tick, ticker)
  end
end)

script.on_init(function(event)
  verifySettings()
  global.version = 1.0
end)

script.on_event(defines.events.on_preplayer_mined_item, function(event)
  if forcefieldTypes[event.entity.name] ~= nil then
    onForcefieldMined(event.entity, event.player_index)
  elseif event.entity.name == emitterName then
    onEmitterMined(event.entity, event.player_index)
  end
end)

script.on_event(defines.events.on_robot_pre_mined, function(event)
  if event.entity.name == emitterName then
    onEmitterMined(event.entity)
  end
end)

script.on_event(defines.events.on_entity_died, function(event)
  if forcefieldTypes[event.entity.name] ~= nil then
    onForcefieldDied(event.entity)
  elseif event.entity.name == emitterName then
    onEmitterDied(event.entity)
  end
end)

script.on_event(defines.events.on_marked_for_deconstruction, function(event)
  if event.entity.name == emitterName then
    local emitterTable = findEmitter(event.entity)
    if emitterTable ~= nil then
      emitterTable["disabled"] = true
      degradeLinkedFields(emitterTable)
    end
  end
end)

script.on_event(defines.events.on_canceled_deconstruction, function(event)
  if event.entity.name == emitterName then
    local emitterTable = findEmitter(event.entity)
    if emitterTable ~= nil then
      emitterTable["disabled"] = false
      setActive(emitterTable, true)
    end
  end
end)

function transferToPlayer(player, dropStack)
  local countBefore = player.get_item_count(dropStack.name)
  local countAfter
  
  player.insert(dropStack)
  countAfter = player.get_item_count(dropStack.name)
  if countAfter < (countBefore + dropStack.count) then
    dropOnGround(player.surface, player.position, {name = dropStack.name, count = (countBefore + dropStack.count) - countAfter})
  end
end

function dropOnGround(surface, position, dropStack, markForDeconstruction, force)
  local dropPos
  local entity
  for n=1,dropStack.count do
    dropPos = surface.find_non_colliding_position("item-on-ground", position, 50, 0.5)
    if dropPos then
      entity = surface.create_entity({name = "item-on-ground", position = dropPos, stack = {name = dropStack.name, count = 1}})
      if entity.valid and markForDeconstruction then
        entity.order_deconstruction(force)
      end
    end
  end
end

function onEmitterDied(emitter)
  local emitterTable = findEmitter(emitter)
  if emitterTable ~= nil then
    removeEmitterID(emitterTable["emitter-NEI"])
    storeKilledEmitter(emitterTable)
  end
end

function onEmitterMined(emitter, playerIndex)
  local emitterTable = findEmitter(emitter)
  local player
  
  if emitterTable ~= nil then
    removeEmitterID(emitterTable["emitter-NEI"])
  end
  if playerIndex then
    player = game.players[playerIndex]
  end
  
  if emitterTable["width-upgrades"] ~= 0 then
    if player then
      transferToPlayer(player, {name = "advanced-circuit", count = emitterTable["width-upgrades"]})
    else
      dropOnGround(emitterTable["entity"].surface, emitterTable["entity"].position, {name = "advanced-circuit", count = emitterTable["width-upgrades"]}, true, emitterTable["entity"].force)
    end
  end
  if emitterTable["distance-upgrades"] ~= 0 then
    if player then
      transferToPlayer(player, {name = "processing-unit", count = emitterTable["distance-upgrades"]})
    else
      dropOnGround(emitterTable["entity"].surface, emitterTable["entity"].position, {name = "processing-unit", count = emitterTable["distance-upgrades"]}, true, emitterTable["entity"].force)
    end
  end
end

function onForcefieldMined(field, player_index)
  if player_index ~= nil then
    local player = game.players[player_index]
    if player.character ~= nil then
      player.character.damage(forcefieldTypes[field.name]["damageWhenMined"], player.force)
    end
  end
  
  if global.fields ~= nil then
    local pos = field.position
    local index = field.surface.index
    if global.fields[index] ~= nil and global.fields[index][pos.x] ~= nil and global.fields[index][pos.x][pos.y] ~= nil then
      local emitterTable = global.emitters[global.fields[index][pos.x][pos.y]]
      if emitterTable then
        setActive(emitterTable, true)
      end
      removeForceFieldID(index, pos.x, pos.y)
    end
  end
end

function tableIsEmpty(t)
  if t then
    for k in pairs(t) do
      return false
    end
  end
  return true
end

function directionToString(direction)
  if direction == defines.direction.north then
    return "north"
  end
  if direction == defines.direction.south then
    return "south"
  end
  if direction == defines.direction.east then
    return "east"
  end
  if direction == defines.direction.west then
    return "west"
  end
end

function findEmitter(emitter)
  if global.emitters ~= nil then
    for k,v in pairs(global.emitters) do
      if v["entity"] == emitter then
        return v
      end
    end
  end
end

function removeEmitter(emitter)
  local emitterTable = findEmitter(emitter)
  if emitterTable ~= nil then
    removeEmitterID(emitterTable["emitter-NEI"])
  end
end

function removeEmitterID(emitterID)
  if global.emitters ~= nil then
    if global.emitters[emitterID] ~= nil then
      degradeLinkedFields(global.emitters[emitterID])
      global.emitters[emitterID] = nil
      if tableIsEmpty(global.emitters) then
        global.emitters = nil
        global.emitterNEI = nil
      else
        return true
      end
    end
  end
end

function removeActiveEmitterID(activeEmitterID)
  -- Returns true if the global.activeEmitters table isn't empty
  if global.activeEmitters ~= nil then
    table.remove(global.activeEmitters, activeEmitterID)
    if #global.activeEmitters == 0 then
      global.activeEmitters = nil
    else
      return true
    end
  end
end

function removeForcefield(field)
  if global.fields ~= nil then
    local pos = field.position
    local index = field.surface.index
    if global.fields[index] ~= nil and global.fields[index][pos.x] ~= nil and global.fields[index][pos.x][pos.y] ~= nil then
      removeForceFieldID(index, pos.x, pos.y)
    end
  end
end

function removeForceFieldID(index, x, y)
  -- Does no checking

  global.fields[index][x][y] = nil
  if tableIsEmpty(global.fields[index][x]) then
    global.fields[index][x] = nil
    if tableIsEmpty(global.fields[index]) then
      global.fields[index] = nil
    end
    if tableIsEmpty(global.fields) then
      global.fields = nil
    end
  end
end

function removeDegradingFieldID(fieldID)
  -- Returns true if the global.degradingFields table isn't empty
  if global.degradingFields ~= nil then
    local pos = global.degradingFields[fieldID]["position"]
    local surface = global.degradingFields[fieldID]["surface"]
    table.remove(global.degradingFields, fieldID)
    local emitters = surface.find_entities_filtered({area = {{x = pos.x - maxFieldDistance, y = pos.y - maxFieldDistance}, {x = pos.x + maxFieldDistance, y = pos.y + maxFieldDistance}}, name = emitterName})
    local emitterTable
    for _,emitter in pairs(emitters) do
      emitterTable = findEmitter(emitter)
      if emitterTable then
        setActive(emitterTable, true)
      end
    end
    if #global.degradingFields == 0 then
      global.degradingFields = nil
    else
      return true
    end
  end
end

function degradeLinkedFields(emitterTable)
  if global.fields ~= nil then
    local pos1, xInc, yInc, incTimes = getFieldsArea(emitterTable)
    local pos2 = {x = pos1.x + (xInc * incTimes), y = pos1.y + (yInc * incTimes)}
    local surface = emitterTable["entity"].surface
    local fields
    if xInc == -1 or yInc == -1 then
      fields = findForcefieldsArea(surface, {pos2, pos1}, true)
    else
      fields = findForcefieldsArea(surface, {pos1, pos2}, true)
    end
    
    if fields then
      if global.degradingFields == nil then
        global.degradingFields = {}
      end
      local index = surface.index
      for k,field in pairs(fields) do
        pos = field.position
        if global.fields[index] ~= nil and global.fields[index][pos.x] ~= nil and global.fields[index][pos.x][pos.y] == emitterTable["emitter-NEI"] then
          table.insert(global.degradingFields, {["entity"] = field, ["position"] = field.position, ["surface"] = surface})
          removeForcefield(field)
          
          if global.fields == nil then
            break
          end
        end
      end
      
      if #global.degradingFields == 0 then
        global.degradingFields = nil
      else
        activateTicker()
      end
    end
  end
end

function entityBuilt(event)
  if event.created_entity.name == toolName then
    local position = event.created_entity.position
    local surface = event.created_entity.surface
    if event.player_index ~= nil then
      game.players[event.player_index].insert({name = toolName, count = 1})
    else
      surface.create_entity({name = "item-on-ground", position = position, stack = {name = toolName, count = 1}})
    end
    event.created_entity.destroy()
    useTool(surface, position, event.player_index)
  elseif event.created_entity.name == emitterName then
    onEmitterBuilt(event.created_entity)
  end
end

script.on_event(defines.events.on_built_entity, entityBuilt)
script.on_event(defines.events.on_robot_built_entity, entityBuilt)

script.on_event(defines.events.on_trigger_created_entity, function(event)
  if event.entity.name == fieldDamagedTriggerName then
    local position = event.entity.position
    local surface = event.entity.surface
    event.entity.destroy()
    onForcefieldDamaged(surface, position)
  end
end)

function ticker()
  if global.ticking == 0 then
    global.ticking = tickRate - 1
    tick()
  else
    global.ticking = global.ticking - 1
  end
end

function tick()
  local shouldKeepTicking
  -- Active emitters tick
  if global.activeEmitters ~= nil then
    local shouldRemainActive
    local emitterTable
    shouldKeepTicking = true
    
    -- For each active emitter check if they have fields to repair or fields to build
    for k,emitterTable in pairs(global.activeEmitters) do
      if emitterTable["entity"].valid then
        shouldRemainActive = false
        if emitterTable["disabled"] == false then
          if emitterTable["build-scan"] ~= nil then
            -- The function will toggle index 4 if it finishes building fields.
            if scanAndBuildFields(emitterTable) then
              shouldRemainActive = true
            end
          end
        end
        if emitterTable["generating-fields"] then
          -- The function will toggle index 11 if it finishes generating fields.
          if generateFields(emitterTable) then
            shouldRemainActive = true
          end
        end
        
        if emitterTable["damaged-fields"] then
          -- The function will toggle index 3 if it finishes repairing fields.
          if regenerateFields(emitterTable) then
            shouldRemainActive = true
          end
        end
        
        if not shouldRemainActive then
          -- Index 2 is the active state of the emitter
          emitterTable["active"] = false
          if not removeActiveEmitterID(k) then
            break
          end
        end
      else
        removeEmitterID(emitterTable["emitter-NEI"])
        if not removeActiveEmitterID(k) then
          break
        end
      end
    end
  end
  
  -- Degrading force fields tick - happens when a emitter dies or is mined.
  if global.degradingFields ~= nil then
    shouldKeepTicking = true
    for k,v in pairs(global.degradingFields) do
      if v["entity"].valid then
        v["entity"].health = v["entity"].health - (forcefieldTypes[v["entity"].name]["degradeRate"] * tickRate)
        if v["entity"].health == 0 then
          v["entity"].destroy()
          if not removeDegradingFieldID(k) then
            break
          end
        end
      else
        if not removeDegradingFieldID(k) then
          break
        end
      end
    end
  end
  
  if global.searchDamagedPos ~= nil then
    shouldKeepTicking = true
    for index,xs in pairs (global.searchDamagedPos) do
      local surface = game.surfaces[index]
      for sx,ys in pairs(xs) do
        for sy in pairs(ys) do
          local foundFields = findForcefieldsRadius(surface, {x = sx + 0.5, y = sy + 0.5}, 1)
          if foundFields ~= nil then
            handleDamagedFields(foundFields)
          end
          table.remove(ys, sy)
        end
        table.remove(global.searchDamagedPos, sx)
      end
      table.remove(global.searchDamagedPos, index)
    end
    
    if #global.searchDamagedPos == 0 then
      global.searchDamagedPos = nil
    end
  end
  
  if not shouldKeepTicking then
    global.ticking = nil
    script.on_event(defines.events.on_tick, nil)
  end
end

function useTool(surface, pos, playerIndex)
  local emitter = surface.find_entities_filtered({area = {{x = pos.x - toolRadius, y = pos.y - toolRadius}, {x = pos.x + toolRadius, y = pos.y + toolRadius}}, name = emitterName})
  if #emitter ~= 0 then
    local emitterTable = findEmitter(emitter[1])
    if emitterTable ~= nil then
      showEmitterGui(emitterTable, playerIndex)
    end
  end
end

function storeKilledEmitter(emitterTable)
  local newKilledEmitter = {}
  if global.killedEmitters == nil then
    global.killedEmitters = {}
  end
  newKilledEmitter["surface"] = emitterTable["entity"].surface
  newKilledEmitter["position"] = emitterTable["entity"].position
  newKilledEmitter["width"] = emitterTable["width"]
  newKilledEmitter["distance"] = emitterTable["distance"]
  newKilledEmitter["type"] = emitterTable["type"]
  newKilledEmitter["direction"] = emitterTable["direction"]
  table.insert(global.killedEmitters, newKilledEmitter)
end

function removeKilledEmitter(index)
  table.remove(global.killedEmitters, index)
  if #global.killedEmitters == 0 then
    global.killedEmitters = nil
  end
end

function onEmitterBuilt(entity)
  local newEmitter = {}
  local surface = entity.surface
  if global.emitters == nil then
    global.emitters = {}
    global.emitterNEI = 1
  end
  
  newEmitter["entity"] = entity
  newEmitter["active"] = false
  newEmitter["damaged-fields"] = nil
  newEmitter["build-scan"] = true
  newEmitter["emitter-NEI"] = "I" .. global.emitterNEI
  newEmitter["width"] = emitterDefaultWidth
  newEmitter["distance"] = emitterDefaultDistance
  newEmitter["build-tick"] = 0
  newEmitter["type"] = defaultFieldType
  newEmitter["direction"] = defines.direction.north
  newEmitter["generating-fields"] = nil
  newEmitter["width-upgrades"] = 0
  newEmitter["distance-upgrades"] = 0
  newEmitter["disabled"] = false
  
  -- Simulates reviving killed emitters
  if global.killedEmitters ~= nil then
    for k,killedEmitter in pairs(global.killedEmitters) do
      if killedEmitter["surface"] == surface and killedEmitter["position"].x == entity.position.x and killedEmitter["position"].y == entity.position.y then
        newEmitter["width"] = killedEmitter["width"]
        newEmitter["distance"] = killedEmitter["distance"]
        newEmitter["type"] = killedEmitter["type"]
        newEmitter["direction"] = killedEmitter["direction"]
        removeKilledEmitter(k)
        break
      end
    end
  end
  
  global.emitters["I" .. global.emitterNEI] = newEmitter
  global.emitterNEI = global.emitterNEI + 1
  
  setActive(newEmitter, true, true)
end

function getFieldsArea(emitterTable)
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

function scanAndBuildFields(emitterTable)
  local builtField
  
  if emitterTable["build-tick"] == 0 then
    local energyBefore = emitterTable["entity"].energy
    if emitterTable["entity"].energy >= (tickRate * forcefieldTypes[emitterTable["type"]]["energyPerRespawn"] + tickRate * forcefieldTypes[emitterTable["type"]]["energyPerCharge"]) then
      local pos, xInc, yInc, incTimes = getFieldsArea(emitterTable)
      local blockingFields = 0
      local blockingFieldsBefore = 0
      local direction
      local force = emitterTable["entity"].force
      local surface = emitterTable["entity"].surface
      local index = surface.index
      
      if emitterTable["direction"] == defines.direction.north or emitterTable["direction"] == defines.direction.south then
        direction = defines.direction.east
      else
        direction = defines.direction.north
      end
      
      if global.fields == nil then
        global.fields = {}
      end
      if global.fields[index] == nil then
        global.fields[index] = {}
      end
      
      for n=1,incTimes do
        -- If another emitter (or even this one previously) has built a field at this location, skip trying to build there
        if global.fields[index][pos.x] == nil or global.fields[index][pos.x][pos.y] == nil then
          if surface.can_place_entity({name = emitterTable["type"], position = pos, direction = direction}) then
            local newField = surface.create_entity({name = emitterTable["type"], position = pos, force = force, direction = direction})
            
            newField.health = forcefieldTypes[emitterTable["type"]]["chargeRate"]
            if emitterTable["generating-fields"] == nil then
              emitterTable["generating-fields"] = {}
            end
            table.insert(emitterTable["generating-fields"], newField)
            
            if global.fields[index][pos.x] == nil then
              global.fields[index][pos.x] = {}
            end
            global.fields[index][pos.x][pos.y] = emitterTable["emitter-NEI"]
            
            builtField = true
            emitterTable["entity"].energy = emitterTable["entity"].energy -  (tickRate * forcefieldTypes[emitterTable["type"]]["energyPerRespawn"])
            if n ~= incTimes and emitterTable["entity"].energy == 0 then
              emitterTable["build-tick"] = forcefieldTypes[emitterTable["type"]]["respawnRate"] * 10
              degradeLinkedFields(emitterTable)
              break
            end
            blockingFields = blockingFields + 1
          else
            local blockingField = findForcefieldsRadius(surface, pos, 0.4, true)
            if blockingField ~= nil then
              if global.degradingFields ~= nil then
                -- Prevents the emitter from going into extended sleep from "can't build" due to degrading fields (happens most when switching field types)
                local fpos = blockingField[1].position
                for _,field in pairs(global.degradingFields) do
                  if field["entity"].position.x == pos.x and field["entity"].position.y == pos.y then
                    builtField = true
                    break
                  end
                end
              end
            else
              surface.create_entity({name = "forcefield-build-damage", position = pos, force = force})
            end
          end
        else
          blockingFields = blockingFields + 1
        end
        pos.x = pos.x + xInc
        pos.y = pos.y + yInc
      end
      
      if global.fields then
        if tableIsEmpty(global.fields[index]) then
          global.fields[index] = nil
        end
        
        if tableIsEmpty(global.fields) then
          global.fields = nil
        end
      end
      
      if blockingFields == incTimes then
        emitterTable["build-scan"] = nil
        return false
      else
        if not builtField then
          emitterTable["build-tick"] = forcefieldTypes[emitterTable["type"]]["respawnRate"] * 3 + math.random(forcefieldTypes[emitterTable["type"]]["respawnRate"])
        else
          emitterTable["build-tick"] = forcefieldTypes[emitterTable["type"]]["respawnRate"]
        end
      end
    else
      emitterTable["build-tick"] = forcefieldTypes[emitterTable["type"]]["respawnRate"] * 5
      degradeLinkedFields(emitterTable)
    end
  else
    emitterTable["build-tick"] = emitterTable["build-tick"] - 1
  end
  
  return true
end

function regenerateFields(emitterTable)
  local availableEnergy = emitterTable["entity"].energy
  local neededEnergy
  
  for k,field in pairs(emitterTable["damaged-fields"]) do
    if field.valid then
      neededEnergy = forcefieldTypes[field.name]["energyPerHealthLost"] * (forcefieldTypes[field.name]["maxHealth"] - field.health)
      if availableEnergy >= neededEnergy then
        field.health = forcefieldTypes[field.name]["maxHealth"]
        availableEnergy = availableEnergy - neededEnergy
        table.remove(emitterTable["damaged-fields"], k)
      else
        degradeLinkedFields(emitterTable)
        emitterTable["damaged-fields"] = {}
        emitterTable["build-tick"] = forcefieldTypes[emitterTable["type"]]["respawnRate"] * 10
        setActive(emitterTable, true, true)
      end
    else
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

function generateFields(emitterTable)
  local availableEnergy = emitterTable["entity"].energy
  
  for k,field in pairs(emitterTable["generating-fields"]) do
    if field.valid then
      if availableEnergy >= (forcefieldTypes[field.name]["energyPerCharge"] * tickRate) then
        field.health = field.health + (forcefieldTypes[field.name]["chargeRate"] * tickRate)
        availableEnergy = availableEnergy - (forcefieldTypes[field.name]["energyPerCharge"] * tickRate)
        if field.health >= forcefieldTypes[field.name]["maxHealth"] then
          table.remove(emitterTable["generating-fields"], k)
        end
      else
        degradeLinkedFields(emitterTable)
        emitterTable["generating-fields"] = {}
        emitterTable["build-tick"] = forcefieldTypes[emitterTable["type"]]["respawnRate"] * 10
        setActive(emitterTable, true, true)
      end
    else
      table.remove(emitterTable["generating-fields"], k)
    end
  end
  
  emitterTable["entity"].energy = availableEnergy
  if #emitterTable["generating-fields"] == 0 then
    emitterTable["generating-fields"] = nil
  else
    return true
  end
end

function findForcefieldsRadius(surface, position, radius, includeFullHealth)
  local walls = surface.find_entities_filtered({area = {{x = position.x - radius, y = position.y - radius}, {x = position.x + radius, y = position.y + radius}}, type = "wall"})
  local gates = surface.find_entities_filtered({area = {{x = position.x - radius, y = position.y - radius}, {x = position.x + radius, y = position.y + radius}}, type = "gate"})
  local foundFields = {}
  
  if #walls ~= 0 then
    for i,wall in pairs(walls) do
      if forcefieldTypes[wall.name] ~= nil and (includeFullHealth or wall.health ~= forcefieldTypes[wall.name]["maxHealth"]) then
        table.insert(foundFields, wall)
      end
    end
  end
  if #gates ~= 0 then
    for i,gate in pairs(gates) do
      if forcefieldTypes[gate.name] ~= nil and (includeFullHealth or gate.health ~= forcefieldTypes[gate.name]["maxHealth"]) then
        table.insert(foundFields, gate)
      end
    end
  end
  if #foundFields ~= 0 then
    return foundFields
  end
end

function findForcefieldsArea(surface, area, includeFullHealth)
  local walls = surface.find_entities_filtered({area = area, type = "wall"})
  local gates = surface.find_entities_filtered({area = area, type = "gate"})
  local foundFields = {}
  
  if #walls ~= 0 then
    for i,wall in pairs(walls) do
      if forcefieldTypes[wall.name] ~= nil and (includeFullHealth or wall.health ~= forcefieldTypes[wall.name]["maxHealth"]) then
        table.insert(foundFields, wall)
      end
    end
  end
  if #gates ~= 0 then
    for i,gate in pairs(gates) do
      if forcefieldTypes[gate.name] ~= nil and (includeFullHealth or gate.health ~= forcefieldTypes[gate.name]["maxHealth"]) then
        table.insert(foundFields, gate)
      end
    end
  end
  if #foundFields ~= 0 then
    return foundFields
  end
end

function findGhostForcefields(surface, position, radius)
  local ghosts = surface.find_entities_filtered({area = {{x = position.x - radius, y = position.y - radius}, {x = position.x + radius, y = position.y + radius}}, type = "ghost"})
  if #ghosts ~= 0 then
    local foundGhosts = {}
    for i,ghost in pairs(ghosts) do
      if forcefieldTypes[ghost.ghost_name] ~= nil then
        table.insert(foundGhosts, ghost)
      end
    end
    return foundGhosts
  end
end

function onForcefieldDamaged(surface, pos)
  local index = surface.index
  
  pos.x = math.floor(pos.x)
  pos.y = math.floor(pos.y)
  if global.searchDamagedPos == nil then
    global.searchDamagedPos = {}
  end
  if global.searchDamagedPos[index] == nil then
    global.searchDamagedPos[index] = {}
  end
  if global.searchDamagedPos[index][pos.x] == nil then
    global.searchDamagedPos[index][pos.x] = {}
  end
  global.searchDamagedPos[index][pos.x][pos.y] = 1
  activateTicker()
end

function handleDamagedFields(forceFields)
  local pos
  local surface
  local index
  local fieldShouldBeAdded
  local addedFields
  local fieldID
  
  if global.fields ~= nil and global.emitters ~= nil then
    -- For each possibly damaged forcefield found
    for k,field in pairs(forceFields) do
      pos = field.position
      surface = field.surface
      index = surface.index
      fieldShouldBeAdded = true
      
      -- If the field is known to the mod
      if global.fields[index] ~= nil and global.fields[index][pos.x] ~= nil and global.fields[index][pos.x][pos.y] ~= nil then
        fieldID = global.fields[index][pos.x][pos.y]
        -- If the field has a valid linked emitter
        if global.emitters[fieldID] ~= nil then
          if global.emitters[fieldID]["generating-fields"] ~= nil then
            for _,generatingField in pairs(global.emitters[fieldID]["generating-fields"]) do
              if generatingField == field then
                fieldShouldBeAdded = false
                break
              end
            end
          end
          
          -- Add the damaged field to the emitter damaged field table if it isn't already in it
          if fieldShouldBeAdded then
            if global.emitters[fieldID]["damaged-fields"] == nil then
              global.emitters[fieldID]["damaged-fields"] = {}
            end
            table.insert(global.emitters[fieldID]["damaged-fields"], field)
            setActive(global.emitters[fieldID])
            addedFields = true
          end
        end
      end
    end
  end
end

function onForcefieldDied(field)
  local pos = field.position
  local surface = field.surface
  local index = surface.index
  
  if global.fields ~= nil and global.fields[index] ~= nil and global.fields[index][pos.x] ~= nil and global.fields[index][pos.x][pos.y] ~= nil then
    local emitterID = global.fields[index][pos.x][pos.y]
    removeForceFieldID(index, pos.x, pos.y)
    if global.emitters ~= nil and global.emitters[emitterID] ~= nil then
      setActive(global.emitters[emitterID], true)
    end
    if forcefieldTypes[field.name]["deathEntity"] ~= nil then
      surface.create_entity({name = forcefieldTypes[field.name]["deathEntity"], position = pos, force = field.force})
    end
  end
end

function setActive(emitterTable, enableCheckBuildingFields, skipResetTimer)
  if emitterTable["disabled"] == true then
    return
  end
  
  if enableCheckBuildingFields then
    emitterTable["build-scan"] = true
    if not skipResetTimer and emitterTable["build-tick"] > forcefieldTypes[emitterTable["type"]]["respawnRate"] or not emitterTable["active"] then
      emitterTable["build-tick"] = forcefieldTypes[emitterTable["type"]]["respawnRate"]
    end
  end
  
  if not emitterTable["active"] then
    emitterTable["active"] = true
    if global.activeEmitters == nil then
      global.activeEmitters = {}
    end
    table.insert(global.activeEmitters, emitterTable)
    activateTicker()
  end
end

function activateTicker()
  if not global.ticking then
    global.ticking = tickRate
    script.on_event(defines.events.on_tick, ticker)
  end
end

function getEmitterBonusWidth(emitterTable)
  return emitterTable["distance-upgrades"] * widthUpgradeMultiplier
end

function getEmitterBonusDistance(emitterTable)
  return emitterTable["width-upgrades"]
end

function handleGUIDirectionButtons(event)
  local player = game.players[event.player_index]
  local frame = player.gui.center.emitterConfig
  local nameToDirection = {["directionN"] = defines.direction.north, ["directionS"] = defines.direction.south, ["directionE"] = defines.direction.east, ["directionW"] = defines.direction.west}
  
  if frame ~= nil then
    local directions = frame.emitterConfigTable.directions
    global.emitterConfigGUIs["I" .. event.element.player_index][2] = nameToDirection[event.element.name]
    
    directions.directionN.style = "selectbuttons"
    directions.directionS.style = "selectbuttons"
    directions.directionE.style = "selectbuttons"
    directions.directionW.style = "selectbuttons"
    directions[event.element.name].style = "selectbuttonsselected"
  end
end

function handleGUIFieldTypeButtons(event)
  local player = game.players[event.player_index]
  local force = player.force
  local frame = player.gui.center.emitterConfig
  local nameToFieldName = {["fieldB"] = "blue" .. fieldSuffix, ["fieldG"] = "green" .. fieldSuffix, ["fieldR"] = "red" .. fieldSuffix, ["fieldP"] = "purple" .. fieldSuffix}
  if frame ~= nil then
    local fields = frame.emitterConfigTable.fields
    local shouldSwitch = true
    local selectedButtonName = event.element.name
    if selectedButtonName == "fieldG" then
      shouldSwitch = force.technologies["green-fields"].researched
    elseif selectedButtonName == "fieldR" then
      shouldSwitch = force.technologies["red-fields"].researched
    elseif selectedButtonName == "fieldP" then
      shouldSwitch = force.technologies["purple-fields"].researched
    end
    
    if shouldSwitch then
      global.emitterConfigGUIs["I" .. event.element.player_index][3] = nameToFieldName[event.element.name]
      fields.fieldB.style = "selectbuttons"
      fields.fieldG.style = "selectbuttons"
      fields.fieldR.style = "selectbuttons"
      fields.fieldP.style = "selectbuttons"
      fields[event.element.name].style = "selectbuttonsselected"
    else
      player.print("You need to complete research before this field type can be used.")
    end
  end
end

function handleGUIUpgradeButtons(event)
  local player = game.players[event.element.player_index]
  local frame = player.gui.center.emitterConfig
  local nameToStyle = {["distanceUpgrades"] = "advanced-circuit", ["widthUpgrades"] = "processing-unit"}
  local styleToName = {["advanced-circuit"] = "distanceUpgrades", ["processing-unit"] = "widthUpgrades"}
  local nameToUpgradeLimit = {["distanceUpgrades"] = maxRangeUpgrades, ["widthUpgrades"] = maxWidthUpgrades}
  
  if frame ~= nil then
    local upgrades = frame.emitterConfigTable.upgrades
    local upgradeButton
    local count
    local stack = player.cursor_stack
    
    if stack.valid_for_read then
      if styleToName[stack.name] ~= nil then
        upgradeButton = upgrades[styleToName[stack.name]]
        if upgradeButton.caption ~= " " then
          count = tonumber(string.sub(upgradeButton.caption, 2)) + 1
        else
          count = 1
        end
        
        if count <= nameToUpgradeLimit[upgradeButton.name] then
          upgradeButton.caption = "x" .. tostring(count)
          updateMaxLabel(frame, upgradeButton)
          
          if count == 1 then
            upgradeButton.style = nameToStyle[upgradeButton.name]
          end
          
          stack.count = stack.count - 1
        else
          game.players[event.element.player_index].print("Maximum upgrades of this type already installed.")
        end
      end
    else
      upgradeButton = upgrades[event.element.name]
      
      if upgradeButton.caption ~= " " then
        count = tonumber(string.sub(upgradeButton.caption, 2)) - 1
        if count == 0 then
          upgradeButton.style = "noitem"
          upgradeButton.caption = " "
        else
          upgradeButton.caption = "x" .. tostring(count)
        end
        
        updateMaxLabel(frame, upgradeButton)
        transferToPlayer(player, {name = nameToStyle[upgradeButton.name], count = 1})
      end
    end
  end
end

function removeAllUpgrades(event)
  local frame = game.players[event.element.player_index].gui.center.emitterConfig

  if frame then -- This shouldn't ever be required but won't hurt to check
    if global.emitterConfigGUIs ~= nil
      and global.emitterConfigGUIs["I" .. event.element.player_index] ~= nil
      and global.emitterConfigGUIs["I" .. event.element.player_index][1]["entity"].valid then
      
      local upgrades = frame.emitterConfigTable.upgrades
      local count
      local buttonName
      for itemName,button in pairs({["advanced-circuit"] = upgrades.distanceUpgrades, ["processing-unit"] = upgrades.widthUpgrades}) do
        if button.caption ~= " " then
          count = tonumber(string.sub(button.caption, 2))
          button.caption = " "
          button.style = "noitem"
          
          updateMaxLabel(frame, button)
          transferToPlayer(game.players[event.element.player_index], {name = itemName, count = count})
        end
      end
    else
      if global.emitterConfigGUIs ~= nil and global.emitterConfigGUIs["I" .. event.element.player_index] ~= nil then
        global.emitterConfigGUIs["I" .. event.element.player_index] = nil
        if tableIsEmpty(global.emitterConfigGUIs) then
          global.emitterConfigGUIs = nil
        end
      end
      frame.destroy()
    end
  end
end

function handleGUIMenuButtons(event)
  local player = game.players[event.element.player_index]
  local frame = player.gui.center.emitterConfig
  if frame ~= nil then
    if event.element.name == "applyButton" then
      if verifyAndSetFromGUI(event) then
        global.emitterConfigGUIs["I" .. event.element.player_index] = nil
        if tableIsEmpty(global.emitterConfigGUIs) then
          global.emitterConfigGUIs = nil
        end
        frame.destroy()
      end
    elseif event.element.name == "emitterHelpButton" then
      printGUIHelp(player)
    elseif event.element.name == "removeAllButton" then
      removeAllUpgrades(event)
    end
  end
end

function printGUIHelp(player)
  player.print("Direction: the direction the emitter projects the forcefields in.")
  player.print("Field type: the type of forcefield the emitter projects:")
  player.print("    [B]lue: normal health, normal re-spawn, normal power usage.")
  player.print("    [G]reen: higher health, very slow re-spawn, below-normal power usage.")
  player.print("    [R]ed: normal health, slow re-spawn, very high power usage. Damages living things that directly attack them.")
  player.print("    [P]urple: low health, very slow re-spawn, high power usage. On death, heavily damages living things near-by.")
  player.print("Emitter distance: the distance from the emitter in the configured direction the fields are constructed.")
  player.print("Emitter width: the width of the field constructed by the emitter.")
  player.print("Upgrades applied: the distance (advanced circuit) and width (processing unit) upgrades applied to the emitter.")
  player.print("Help button: displays this information.")
  player.print("Remove all upgrades: removes all upgrades from the emitter.")
  player.print("Apply: saves and applies the settings to the emitter.")
end

function updateMaxLabel(frame, upgradeButton)
  local count
  if upgradeButton.caption == " " then
    count = 0
  else
    count = tonumber(string.sub(upgradeButton.caption, 2))
  end
  if upgradeButton.name == "distanceUpgrades" then
    frame.emitterConfigTable.distance.emitterMaxDistance.caption = "Max: " .. tostring(emitterDefaultDistance + count)
  else
    frame.emitterConfigTable.width.emitterMaxWidth.caption = "Max: " .. tostring(emitterDefaultWidth + (count * 4))
  end
end

local guiNames =
{
  ["directionN"] = handleGUIDirectionButtons,
  ["directionS"] = handleGUIDirectionButtons,
  ["directionE"] = handleGUIDirectionButtons,
  ["directionW"] = handleGUIDirectionButtons,

  ["fieldB"] = handleGUIFieldTypeButtons,
  ["fieldG"] = handleGUIFieldTypeButtons,
  ["fieldR"] = handleGUIFieldTypeButtons,
  ["fieldP"] = handleGUIFieldTypeButtons,

  ["distanceUpgrades"] = handleGUIUpgradeButtons,
  ["widthUpgrades"] = handleGUIUpgradeButtons,

  ["emitterHelpButton"] = handleGUIMenuButtons,
  ["removeAllButton"] = handleGUIMenuButtons,
  ["applyButton"] = handleGUIMenuButtons
}

script.on_event(defines.events.on_gui_click, function(event)
  if guiNames[event.element.name] then
    guiNames[event.element.name](event)
  end
end)

function verifyAndSetFromGUI(event)
  local newDirection
  local newFieldType
  local newDistance
  local newWidth
  local maxDistance
  local maxWidth
  local newWidthUpgrades
  local newDistanceUpgrades
  local selectedButtonStyle = "selectbuttonsselected"
  local player = game.players[event.element.player_index]
  local settingsAreGood = true
  local settingsChanged = false
  local frame = player.gui.center.emitterConfig
  local emitterConfigTable = frame.emitterConfigTable 
  local upgrades = emitterConfigTable.upgrades
  
  if global.emitterConfigGUIs ~= nil
    and global.emitterConfigGUIs["I" .. event.element.player_index] ~= nil
    and global.emitterConfigGUIs["I" .. event.element.player_index][1]["entity"].valid then
    
    local emitterTable = global.emitterConfigGUIs["I" .. event.element.player_index][1]
    
    if global.emitterConfigGUIs["I" .. event.element.player_index][2] ~= nil then
      newDirection = global.emitterConfigGUIs["I" .. event.element.player_index][2]
    else
      newDirection = emitterTable["direction"]
    end
    
    if global.emitterConfigGUIs["I" .. event.element.player_index][3] ~= nil then
      newFieldType = global.emitterConfigGUIs["I" .. event.element.player_index][3]
    else
      newFieldType = emitterTable["type"]
    end
    
    newDistance = tonumber(emitterConfigTable.distance.emitterDistance.text)
    newWidth = tonumber(emitterConfigTable.width.emitterWidth.text)
    maxDistance = tonumber(string.sub(emitterConfigTable.distance.emitterMaxDistance.caption, 6))
    maxWidth = tonumber(string.sub(emitterConfigTable.width.emitterMaxWidth.caption, 6))
    if upgrades.distanceUpgrades.caption ~= " " then
      newDistanceUpgrades = tonumber(string.sub(upgrades.distanceUpgrades.caption, 2))
    else
      newDistanceUpgrades = 0
    end
    if upgrades.widthUpgrades.caption ~= " " then
      newWidthUpgrades = tonumber(string.sub(upgrades.widthUpgrades.caption, 2))
    else
      newWidthUpgrades = 0
    end
    
    
    if not newDistance then
      player.print("New Distance is not a valid number.")
      settingsAreGood = false
    elseif newDistance > maxDistance then
      player.print("New Distance is larger than the allowed maximum.")
      settingsAreGood = false
    elseif newDistance < 1 then
      player.print("New Distance is smaller than the allowed minimum (1).")
      settingsAreGood = false
    elseif math.floor(newDistance) ~= newDistance then
      player.print("New Distance is not a valid number (can't have decimals).")
      settingsAreGood = false
    end
    if not newWidth then
      player.print("New Width is not a valid number.")
      settingsAreGood = false
    elseif newWidth > maxWidth then
      player.print("New Width is larger than the allowed maximum.")
      settingsAreGood = false
    elseif newWidth < 1 then
      player.print("New Width is smaller than the allowed minimum (1).")
      settingsAreGood = false
    elseif math.floor(newWidth) ~= newWidth then
      player.print("New Width is not a valid number (can't have decimals).")
      settingsAreGood = false
    elseif (math.floor((newWidth - 1) / 2) * 2) + 1 ~= newWidth then
      player.print("New Width has to be an odd number.")
      emitterConfigTable.width.emitterWidth.text = tostring((math.floor((newWidth - 1) / 2) * 2) + 1)
      settingsAreGood = false
    end
    
    if settingsAreGood then
      if emitterTable["width"] ~= newWidth
        or emitterTable["distance"] ~= newDistance
        or emitterTable["type"] ~= newFieldType
        or emitterTable["direction"] ~= newDirection then
        
        degradeLinkedFields(emitterTable)
        emitterTable["damaged-fields"] = nil
        emitterTable["width"] = newWidth
        emitterTable["distance"] = newDistance
        emitterTable["type"] = newFieldType
        emitterTable["direction"] = newDirection
        emitterTable["generating-fields"] = nil
        setActive(emitterTable, true)
      end
      
      emitterTable["width-upgrades"] = newDistanceUpgrades
      emitterTable["distance-upgrades"] = newWidthUpgrades
      return true
    end
  else
    return true
  end
end

function showEmitterGui(emitterTable, playerIndex)
  local GUICenter = game.players[playerIndex].gui.center
  local canOpenGUI = true
  if global.emitterConfigGUIs ~= nil then
    for index,player in pairs(game.players) do
      --if index ~= playerIndex then
        if global.emitterConfigGUIs["I" .. index] ~= nil and global.emitterConfigGUIs["I" .. index][1] == emitterTable then
          if index ~= playerIndex then
            game.players[playerIndex].print(player.name .. " (player " .. index .. ") has the GUI for this emitter open right now.")
          end
          canOpenGUI = false
        end
      --end
    end
  end
  
  if canOpenGUI and GUICenter and GUICenter.emitterConfig == nil then
    local frame = GUICenter.add({type = "frame", name = "emitterConfig", caption = game.entity_prototypes[emitterName].localised_name, direction = "vertical", style = frame_caption_label_style})
    local configTable = frame.add({type ="table", name = "emitterConfigTable", colspan = 2})
    configTable.add({type = "label", name = "directionLabel", caption = "Direction:                       "})
    local directions = configTable.add({type = "table", name = "directions", colspan = 4})
    
    local d1 = directions.add({type = "button", name = "directionN", caption = "N", style = "selectbuttons"})
    local d2 = directions.add({type = "button", name = "directionS", caption = "S", style = "selectbuttons"})
    local d3 = directions.add({type = "button", name = "directionE", caption = "E", style = "selectbuttons"})
    local d4 = directions.add({type = "button", name = "directionW", caption = "W", style = "selectbuttons"})
    
    if emitterTable["direction"] == defines.direction.north then
      d1.style = "selectbuttonsselected"
    elseif emitterTable["direction"] == defines.direction.south then
      d2.style = "selectbuttonsselected"
    elseif emitterTable["direction"] == defines.direction.east then
      d3.style = "selectbuttonsselected"
    elseif emitterTable["direction"] == defines.direction.south then
      d4.style = "selectbuttonsselected"
    end
    
    configTable.add({type = "label", name = "fieldTypeLabel", caption = "Field type:"})
    local fields = configTable.add({type = "table", name = "fields", colspan = 4})
    local f1 = fields.add({type = "button", name = "fieldB", caption = "B", style = "selectbuttons"})
    local f2 = fields.add({type = "button", name = "fieldG", caption = "G", style = "selectbuttons"})
    local f3 = fields.add({type = "button", name = "fieldR", caption = "R", style = "selectbuttons"})
    local f4 = fields.add({type = "button", name = "fieldP", caption = "P", style = "selectbuttons"})
    
    if emitterTable["type"] == "blue" .. fieldSuffix then
      f1.style = "selectbuttonsselected"
    elseif emitterTable["type"] == "green" .. fieldSuffix then
      f2.style = "selectbuttonsselected"
    elseif emitterTable["type"] == "red" .. fieldSuffix then
      f3.style = "selectbuttonsselected"
    elseif emitterTable["type"] == "purple" .. fieldSuffix then
      f4.style = "selectbuttonsselected"
    end
    
    configTable.add({type = "label", name = "distanceLabel", caption = "Emitter distance:"})
    local distance = configTable.add({type = "table", name = "distance", colspan = 2})
    distance.add({type = "textfield", name = "emitterDistance", style = "distancetext"}).text = emitterTable["distance"]
    distance.add({type = "label", name = "emitterMaxDistance", caption = "Max: " .. tostring(emitterDefaultDistance + getEmitterBonusDistance(emitterTable)), style = "description_title_label_style"})
    configTable.add({type = "label", name = "currentWidthLabel", caption = "Emitter width:"})
    local width = configTable.add({type = "table", name = "width", colspan = 2})
    width.add({type = "textfield", name = "emitterWidth", style = "distancetext"}).text = emitterTable["width"]
    width.add({type = "label", name = "emitterMaxWidth", caption = "Max: " .. tostring(emitterDefaultWidth + getEmitterBonusWidth(emitterTable)), style = "description_title_label_style"})
    configTable.add({type = "label", name = "upgradesLabel", caption = "Upgrades applied:"})
    
    local upgrades = configTable.add({type = "table", name = "upgrades", colspan = 2})
    if emitterTable["width-upgrades"] ~= 0 then
      upgrades.add({type = "button", name = "distanceUpgrades", caption = "x" .. tostring(emitterTable["width-upgrades"]), style = "advanced-circuit"})
    else
      upgrades.add({type = "button", name = "distanceUpgrades", caption = " ", style = "noitem"})
    end
    if emitterTable["distance-upgrades"] ~= 0 then
      upgrades.add({type = "button", name = "widthUpgrades", caption = "x" .. tostring(emitterTable["distance-upgrades"]), style = "processing-unit"})
    else
      upgrades.add({type = "button", name = "widthUpgrades", caption = " ", style = "noitem"})
    end
    
    local buttonFlow = frame.add({type = "flow", name = "buttonsFlow", direction = "horizontal"})
    buttonFlow.add({type = "button", name = "emitterHelpButton", caption = "?"})
    buttonFlow.add({type = "button", name = "removeAllButton", caption = "Remove all upgrades"})
    buttonFlow.add({type = "button", name = "applyButton", caption = "Apply"})
    
    if global.emitterConfigGUIs == nil then
      global.emitterConfigGUIs = {}
    end
    
    global.emitterConfigGUIs["I" .. playerIndex] = {}
    global.emitterConfigGUIs["I" .. playerIndex][1] = emitterTable
  end
end