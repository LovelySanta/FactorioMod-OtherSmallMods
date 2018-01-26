

ConfigChanges = {}

ConfigChanges.currentVersion = 1.1



function ConfigChanges:onConfigurationChanged()
  if global.forcefields and global.forcefields.version then
    if global.forcefields.version == 1.0 then
      log("Updating ForceFields from version 1.0 to version 1.1")
      self:updateToVersion_1_1()
    end
  end
end



function ConfigChanges:updateToVersion_1_1()
  -- this is just for a test
  global.forcefields.version = 1.1
end
