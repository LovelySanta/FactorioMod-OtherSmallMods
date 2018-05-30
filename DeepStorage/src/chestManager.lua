require 'src/settings'
require 'src/chestData'

ChestManager = {}

function ChestManager:onInit()
  ChestData:onInit()
end



function ChestManager:onChestCreated(chestEntity)
  -- Create the monitor
  local monitorEntity = chestEntity.surface.create_entity{
    name = Settings.storageMonitorName,
    position = chestEntity.position,
    force = chestEntity.force,
  }

  -- Add data
  ChestData:addNewChestData(chestEntity, monitorEntity)
end



function ChestManager:onTick()
  if game.tick % 60 == 0 then
    ChestData:updateNextChest()
  end
end
