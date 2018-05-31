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
    ["contents"] = nil, -- empty
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
    -- Get reference of the chest and make next reference ready
    local chestToUpdate = deepcopy(self.chestData["nextChest"])
    self.chestData["nextChest"] = deepcopy(self.chestData[chestToUpdate["surfaceIndex"]][chestToUpdate["surfacePosY"]][chestToUpdate["surfacePosX"]]["nextChest"])

    -- Update chest
    game.print("Updating chest on surface " .. chestToUpdate["surfaceIndex"] .. " located at (" .. chestToUpdate["surfacePosX"] .. "," .. chestToUpdate["surfacePosY"] .. ").")

    self:updateChest(chestToUpdate["surfaceIndex"], chestToUpdate["surfacePosX"], chestToUpdate["surfacePosY"])

    if self.chestData[chestToUpdate["surfaceIndex"]][chestToUpdate["surfacePosY"]][chestToUpdate["surfacePosX"]]["contents"] then
      game.print("Now contains " .. self.chestData[chestToUpdate["surfaceIndex"]][chestToUpdate["surfacePosY"]][chestToUpdate["surfacePosX"]]["contents"].count ..
        "x " .. self.chestData[chestToUpdate["surfaceIndex"]][chestToUpdate["surfacePosY"]][chestToUpdate["surfacePosX"]]["contents"].name)
    end
  end
end



function ChestDatastructure:updateChest(surfaceIndex, surfacePosX, surfacePosY)

  local function getSingleItemInfo(inventory)
    local contents = inventory.get_contents()
    if tableIsEmpty(contents) then
      return {["name"] = nil, ["count"] = 0}
    end

    local contentsCount = -1
    local contentsName = nil
    for itemName, itemCount in pairs(contents) do
      if itemCount > contentsCount then
        if contentsName then
          -- we found another item with a bigger amount, we need to delete the previous item
          inventory.remove{name = contentsName, count = containsCount}
        end
        contentsCount = itemCount
        contentsName = itemName
      else
        -- we found another item with a lesser amount, we need to delete this item
        inventory.remove{name = itemName, count = itemCount}
      end
    end

    return {["name"] = contentsName, ["count"] = contentsCount}
  end

  local chestData = self.chestData[surfaceIndex][surfacePosY][surfacePosX]
  local chestInventory = chestData["inventoryEntity"].get_inventory(defines.inventory.car_trunk)
  local chestBehaviour = chestData["monitorEntity"].get_or_create_control_behavior()

  local chestContents = getSingleItemInfo(chestInventory) --

  -- Check content
  if not chestData["contents"] then
    -- there was no previous content registered
    if chestContents.name and chestContents.count > 0 then
      -- now there is contents
      chestData["contents"] = deepcopy(chestContents)
      chestData["contents"]["stacksize"] = game.item_prototypes[chestData["contents"].name].stack_size

      -- set the filters
      for inventoryIndex = 1, #chestInventory, 1 do
        chestInventory.set_filter(inventoryIndex, chestContents.name)
      end

      -- if there is more items then 1 stack we need to remove them
      if chestContents.count > chestData["contents"].stacksize then
        chestInventory.remove{name = chestData.name, count = chestData["contents"].count - chestData["contents"].stacksize}
      end

      -- output signal on the monitor
      chestBehaviour.parameters = {parameters = {{index = 1, signal = {type = "item", name = chestData["contents"].name}, count = chestData["contents"].count}}}
    end

  else -- there was content registered

    if not chestContents.name then
      if chestData["contents"].count <= chestData["contents"].stacksize then
        -- chest is realy empty
        chestData["contents"] = nil

        -- remove the filters
        for inventoryIndex = 1, #chestInventory, 1 do
          chestInventory.set_filter(inventoryIndex, chestContents.name)
        end

        -- remove signal on the monitor
        chestBehaviour.parameters = nil

      else -- stack was fully outserted, but has still items in its buffer, time to fill it back up

        -- update contents
        chestData["contents"].count = chestData["contents"].count - chestData["contents"].stacksize

        -- add items to the inventory
        chestInventory.insert{name = chestData["contents"].name, count = min(chestData["contents"].count, chestData["contents"].stack_size)}

        -- update the signal on the monitor
        chestBehaviour.parameters = {parameters = {{index = 1, signal = {type = "item", name = chestData["contents"].name}, count = chestData["contents"].count}}}
      end

    else
      -- there was still some content in there
      if chestContents.count > chestData["contents"].stacksize then -- more than a stack in the chest

        -- update contents
        chestData["contents"].count = chestData["contents"].count + (chestContents.count - chestData["contents"].stacksize)

        -- remove excess items from the inventory
        chestInventory.remove{name = chestData["contents"].name, count = chestContents.count - chestData["contents"].stacksize}

      elseif chestContents.count < chestData["contents"].stacksize then -- less than a stack in the chest
        if chestData["contents"].count >= chestData["contents"].stacksize then -- has more available items, insert more

          -- update contents
          chestData["contents"].count = chestData["contents"].count - (chestData["contents"].stacksize - chestContents.count)

          -- add items to the invenory
          chestInventory.insert{name = chestData["contents"].name, count = chestData["contents"].stacksize - chestContents.count}

        else -- chest has less then a stack of content, nothing to insert

          -- update contents
          chestData["contents"].count = chestContents.count

        end

      else -- exactly a stack in the chest
        if chestData["contents"].count == (chestData["contents"].stacksize - 1) then

          -- update contents
          chestData["contents"].count = chestContents.count

        end
      end

      -- update the signal on the monitor
      chestBehaviour.parameters = {parameters = {{index = 1, signal = {type = "item", name = chestData["contents"].name}, count = chestData["contents"].count}}}

    end
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
