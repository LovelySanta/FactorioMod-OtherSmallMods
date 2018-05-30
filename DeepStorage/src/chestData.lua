require 'lib/utilities/util'


ChestData = {}


function ChestData:onInit()
  if not self.chestData then
    self.chestData = {
      ["version"] = 1,
      ["firstChest"] = nil, -- reference to the list
      ["nextChest"] = nil,  -- reference to next chest that needs to be updated
    }
  end
end



function ChestData:addNewChestData(chestEntity, monitorEntity)
  -- reference to the place where this entity is located
  local surfaceIndex = chestEntity.surface.index
  local surfacePosX = chestEntity.position.x
  local surfacePosY = chestEntity.position.y

  -- Make sure we can index this new position
  if not self.chestData[surfaceIndex] then
    self.chestData[surfaceIndex] = {}
  end
  if not self.chestData[surfaceIndex][surfacePosY] then
    self.chestData[surfaceIndex][surfacePosY] = {}
  end
  if not self.chestData[surfaceIndex][surfacePosY][surfacePosX] then
    self.chestData[surfaceIndex][surfacePosY][surfacePosX] = {}
  end

  -- add the new chest to the data container
  self.chestData[surfaceIndex][surfacePosY][surfacePosX] =
  {
    ["chestEntity"] = chestEntity,
    ["monitorEntity"] = monitorEntity,
  }

  -- add container to the loop
  if not self.chestData["firstChest"] then
    -- loop didn't exist, we create one
    self.chestData["firstChest"] =
    {
      ["surfaceIndex"] = surfaceIndex,
      ["surfacePosX"]  = surfacePosX,
      ["surfacePosY"]  = surfacePosY,
    }
    self.chestData[surfaceIndex][surfacePosY][surfacePosX]["prevChest"] = deepcopy(self.chestData["firstChest"])
    self.chestData[surfaceIndex][surfacePosY][surfacePosX]["nextChest"] = deepcopy(self.chestData["firstChest"])
    self.chestData["nextChest"] = deepcopy(self.chestData["firstChest"])

  else
    -- add container afther the last one (AKA before the first one, coz its a loop)
    local nextChest = deepcopy(self.chestData["firstChest"])
    local prevChest = deepcopy(self.chestData[nextChest["surfaceIndex"]][nextChest["surfacePosY"]][nextChest["surfacePosX"]]["prevChest"])

    --      last                     newly placed                   first
    --   -----------                 -----------                 -----------
    --   |         |     step 2      |         |     step 4      |         |
    --   |    P    |   <----------   |    N    |   <----------   |    N    |
    --   |    R    |                 |    E    |                 |    E    |
    --   |    E    |                 |    W    |                 |    X    |
    --   |    V    |   ---------->   |         |   ---------->   |    T    |
    --   |         |     step 3      |         |     step 1      |         |
    --   -----------                 -----------                 -----------

    -- STEP 1: add own 'next reference' (reference to the first one)
    self.chestData[surfaceIndex][surfacePosY][surfacePosX]["nextChest"] = deepcopy(nextChest)

    -- STEP 2: add own 'prev reference' (reference to the last one)
    self.chestData[surfaceIndex][surfacePosY][surfacePosX]["prevChest"] = deepcopy(prevChest)

    -- STEP 3: add prev his 'next reference' (reference to self from the last one)
    self.chestData[prevChest["surfaceIndex"]][prevChest["surfacePosY"]][prevChest["surfacePosX"]]["nextChest"] =
    {
      ["surfaceIndex"] = surfaceIndex,
      ["surfacePosX"]  = surfacePosX,
      ["surfacePosY"]  = surfacePosY,
    }

    -- STEP 4: add next his 'prev reference' (reference to self from the first one)
    self.chestData[nextChest["surfaceIndex"]][nextChest["surfacePosY"]][nextChest["surfacePosX"]]["prevChest"] =
    {
      ["surfaceIndex"] = surfaceIndex,
      ["surfacePosX"]  = surfacePosX,
      ["surfacePosY"]  = surfacePosY,
    }

  end
end



function ChestData:updateNextChest()
  if self.chestData["nextChest"] then
    -- Get reference of the chest
    local chestToUpdate = deepcopy(self.chestData["nextChest"])
    self.chestData["nextChest"] = deepcopy(self.chestData[chestToUpdate["surfaceIndex"]][chestToUpdate["surfacePosY"]][chestToUpdate["surfacePosX"]]["nextChest"])

    local surfaceIndex = chestToUpdate["surfaceIndex"]
    local surfacePosX  = chestToUpdate["surfacePosX"]
    local surfacePosY  = chestToUpdate["surfacePosY"]

    game.print("Updating chest on surface " .. surfaceIndex .. " located at (" .. surfacePosX .. "," .. surfacePosY .. ").")

  end
end
