require 'lib/utilities/util'


ChestDatastructure = {}


function ChestDatastructure:onInit()
  if not self.chestData then
    self.chestData = {
      ["version"] = 1,
      ["firstChest"] = nil, -- reference to the list
      ["nextChest"] = nil,  -- reference to next chest that needs to be updated
    }
  end
end



function ChestDatastructure:addNewChestData(inventoryEntity, monitorEntity)
  -- reference to the place where this entity is located
  local surfaceIndex = inventoryEntity.surface.index
  local surfacePosX = inventoryEntity.position.x
  local surfacePosY = inventoryEntity.position.y

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
    ["inventoryEntity"] = inventoryEntity,
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



function ChestDatastructure:removeChestData(surfaceIndex, surfacePosX, surfacePosY)
  -- Check if firstChest is the chest we want to delete, if so, move firstChest over to the next container
  local firstChest = deepcopy(self.chestData["firstChest"])
  if firstChest["surfaceIndex"] == surfaceIndex
    and firstChest["surfacePosY"] == surfacePosY
    and firstChest["surfacePosX"] == surfacePosX then

    self.chestData["firstChest"] = deepcopy(self.chestData[surfaceIndex][surfacePosY][surfacePosX]["nextChest"])
  end

  -- Check if nextChest is the chest we want to delete, if so, move nextChest over to the next container
  local nextChest = deepcopy(self.chestData["nextChest"])
  if nextChest["surfaceIndex"] == surfaceIndex
    and nextChest["surfacePosY"] == surfacePosY
    and nextChest["surfacePosX"] == surfacePosX then

    self.chestData["nextChest"] = deepcopy(self.chestData[surfaceIndex][surfacePosY][surfacePosX]["nextChest"])
  end

  -- Exclude this container from the loop structure
  local prevChest = deepcopy(self.chestData[surfaceIndex][surfacePosY][surfacePosX]["prevChest"])
  local nextChest = deepcopy(self.chestData[surfaceIndex][surfacePosY][surfacePosX]["nextChest"])

  if not tablesAreEqual(nextChest, {["surfaceIndex"] = surfaceIndex, ["surfacePosX"] = surfacePosX, ["surfacePosY"] = surfacePosY,}) then

    --      prev                       removed                      next
    --   -----------                 -----------                 -----------
    --   |         |                 |         |     step 2      |         |
    --   |    P    |   <----------------  O  -----------------   |    N    |
    --   |    R    |                 |    L    |                 |    E    |
    --   |    E    |                 |    D    |                 |    X    |
    --   |    V    |   -----------------     ---------------->   |    T    |
    --   |         |     step 1      |         |                 |         |
    --   -----------                 -----------                 -----------

    -- STEP 1: add prev his 'next reference' (reference to next from the removed one)
    self.chestData[prevChest["surfaceIndex"]][prevChest["surfacePosY"]][prevChest["surfacePosX"]]["nextChest"] = deepcopy(nextChest)

    -- STEP 2: add next his 'prev reference' (reference to prev from the removed one)
    self.chestData[nextChest["surfaceIndex"]][nextChest["surfacePosY"]][nextChest["surfacePosX"]]["prevChest"] = deepcopy(prevChest)

  else
    -- this was the last chest standing, we need to reset the loop references
    self.chestData["nextChest"] = nil
    self.chestData["firstChest"] = nil
  end

  -- Remove references to removed one (and clean up empty tables)
  self.chestData[surfaceIndex][surfacePosY][surfacePosX] = nil
  if tableIsEmpty(self.chestData[surfaceIndex][surfacePosY]) then
    self.chestData[surfaceIndex][surfacePosY] = nil
    if tableIsEmpty(self.chestData[surfaceIndex]) then
      self.chestData[surfaceIndex] = nil
    end
  end

end



function ChestDatastructure:updateNextChest()
  if self.chestData["nextChest"] then
    -- Get reference of the chest
    local chestToUpdate = deepcopy(self.chestData["nextChest"])
    self.chestData["nextChest"] = deepcopy(self.chestData[chestToUpdate["surfaceIndex"]][chestToUpdate["surfacePosY"]][chestToUpdate["surfacePosX"]]["nextChest"])

    local surfaceIndex = chestToUpdate["surfaceIndex"]
    local surfacePosX  = chestToUpdate["surfacePosX"]
    local surfacePosY  = chestToUpdate["surfacePosY"]


    chestToUpdate = deepcopy(self.chestData["nextChest"])
    chestToUpdate = self.chestData[chestToUpdate["surfaceIndex"]][chestToUpdate["surfacePosY"]][chestToUpdate["surfacePosX"]]["prevChest"]
    game.print("Updating chest on surface " .. surfaceIndex .. " located at (" .. surfacePosX .. "," .. surfacePosY .. ").")

  end
end



function ChestDatastructure:getInventoryEntity(surfaceIndex, surfacePosX, surfacePosY)
  if self.chestData[surfaceIndex]
    and self.chestData[surfaceIndex][surfacePosY]
    and self.chestData[surfaceIndex][surfacePosY][surfacePosX] then

    return self.chestData[surfaceIndex][surfacePosY][surfacePosX]["inventoryEntity"]
  else
    return nil
  end
end



function ChestDatastructure:getMonitorEntity(surfaceIndex, surfacePosX, surfacePosY)
  if self.chestData[surfaceIndex]
    and self.chestData[surfaceIndex][surfacePosY]
    and self.chestData[surfaceIndex][surfacePosY][surfacePosX] then

    return self.chestData[surfaceIndex][surfacePosY][surfacePosX]["monitorEntity"]
  else
    return nil
  end
end
