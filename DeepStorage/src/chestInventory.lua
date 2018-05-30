require 'src/settings'

ChestInventory = {}

function ChestInventory:onInit()
  self.chestData = {
    ["version"] = 1,
  }
end



function ChestInventory:addNewChestData(chestEntity, monitorEntity)
  local surfaceIndex = chestEntity.surface.index
  local surfacePosX = chestEntity.position.x
  local surfacePosY = chestEntity.position.y

  if not self.chestData[surfaceIndex] then
    self.chestData[surfaceIndex] = {}
  end
  if not self.chestData[surfaceIndex][surfacePosY] then
    self.chestData[surfaceIndex][surfacePosY] = {}
  end
  if not self.chestData[surfaceIndex][surfacePosY][surfacePosX] then
    self.chestData[surfaceIndex][surfacePosY][surfacePosX] = {}
  end

  self.chestData[surfaceIndex][surfacePosY][surfacePosX] =
  {
    ["chestEntity"] = chestEntity,
    ["monitorEntity"] = monitorEntity,
  }
end


function ChestInventory:onChestCreated(chestEntity)
  -- Create the monitor
  local monitorEntity = chestEntity.surface.create_entity{
    name = Settings.storageMonitorName,
    position = chestEntity.position,
    force = chestEntity.force,
  }

  -- Add data

end
