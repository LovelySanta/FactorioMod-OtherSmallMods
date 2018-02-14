require 'util'


ConfigChanges = {}

ConfigChanges.currentVersion = 1.1



function ConfigChanges:onConfigurationChanged()
  log("Updating ForceFields to the new version, thanks for using this mod.")
  if global.forcefields and global.forcefields.version then
    if global.forcefields.version == 1.0 then
      log("Updating ForceFields from version 1.0 to version 1.1")
      self:updateToVersion_1_1()
    end
    if global.forcefields.version == 1.1 then
      log("Updating ForceFields from version 1.1 to version 1.2")
      self:updateToVersion_1_2()
    end
  end
  log("ForceFields are updated! Have a nice gaming session!")
end



function ConfigChanges:updateToVersion_1_1()
  -- this is just for a test
  global.forcefields.version = 1.1
end



function ConfigChanges:updateToVersion_1_2()
  -- close all gui's
  if global.forcefields.emitterConfigGuis ~= nil then
    for playerIndex,  player in pairs(game.players) do
      local guiCenter = player.gui.center
      if global.forcefields.emitterConfigGuis["I" .. playerIndex] ~= nil then
        guiCenter["emitterConfig"].destroy()
        global.forcefields.emitterConfigGuis["I" .. playerIndex] = nil
        if tableIsEmpty(global.forcefields.emitterConfigGuis) then
          global.forcefields.emitterConfigGuis = nil
          break
        end
      end
    end
  end

  -- add config to all emitter tables (emitterConfig)
  -- update types of emitters (updateEmitterType)
  local emitterConfig = {}
  for i=-32, 32 do
    emitterConfig[i] = "-forcefield"
  end
  local updateEmitterType = {
    ["blue-forcefield"] = "blue",
    ["blue"] = "blue",
    ["green-forcefield"] = "green",
    ["green"] = "green",
    ["purple-forcefield"] = "purple",
    ["purple"] = "purple",
    ["red-forcefield"] = "red",
    ["red"] = "red",
  }
  if global.forcefields.killedEmitters ~= nil then
    local killedEmitters = global.forcefields.killedEmitters
    for k,_ in pairs(killedEmitters) do
      killedEmitters[k]["config"] = util.table.deepcopy(emitterConfig)
      killedEmitters[k]["type"] = updateEmitterType[killedEmitters[k]["type"]]
    end
    global.forcefields.killedEmitters = killedEmitters
  end
  if global.forcefields.emitters ~= nil then
    local emitters = global.forcefields.emitters
    for k,_ in pairs(emitters) do
      emitters[k]["config"] = util.table.deepcopy(emitterConfig)
      emitters[k]["type"] = updateEmitterType[emitters[k]["type"]]
    end
    global.forcefields.emitters = emitters
  end
  if global.forcefields.activeEmitters ~= nil then
    local activeEmitters = global.forcefields.activeEmitters
    for k,_ in pairs(activeEmitters) do
      activeEmitters[k]["config"] = util.table.deepcopy(emitterConfig)
      activeEmitters[k]["type"] = updateEmitterType[activeEmitters[k]["type"]]
    end
    global.forcefields.activeEmitters = activeEmitters
  end

  -- change forcefield entity to emitter
  if global.forcefields.degradingFields ~= nil then
    local degradingFields = global.forcefields.degradingFields
    for k,v in pairs(degradingFields) do
      if v["entity"] ~= nil then
        if v["fieldEntity"] == nil then
          v["fieldEntity"] = util.table.deepcopy(v["entity"])
        end
        v["entity"] = nil
      end
    end
  end

  -- now we are up to date to this version
  global.forcefields.version = 1.2
end
