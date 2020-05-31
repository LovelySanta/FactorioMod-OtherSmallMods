require("__LSlib__/LSlib")

compressedFluids = compressedFluids or {}
compressedFluids.remote = compressedFluids.remote or {}
compressedFluids.remoteData = compressedFluids.remoteData or {}

compressedFluids.remote.forceCompressingFluid = function(fluidName)
  -- Guarantees a fluid can be pressurized
  compressedFluids.remoteData.forcedCompressedFluids =
    compressedFluids.remoteData.forcedCompressedFluids or {}

  compressedFluids.remoteData.forcedCompressedFluids[fluidName] = true
end

compressedFluids.remote.addTemperatureToFluid = function(fluidName, temperatureToAdd)
  -- Makes sure the fluid maintains these temperatures. If another temperature is
  -- inserted, the temperature will be rounded down.
  -- Adding temperatures to fluids does not mean that they are pressurizable!
  -- Use compressedFluids.remote.forceCompressingFluid(fluidName) function for that.
  compressedFluids.remoteData.fluidTemperatures =
    compressedFluids.remoteData.fluidTemperatures or {}
  compressedFluids.remoteData.fluidTemperatures[fluidName] = 
    compressedFluids.remoteData.fluidTemperatures[fluidName] or {}

  local temperaturePresent = false
  for _,temp in pairs(compressedFluids.remoteData.fluidTemperatures[fluidName]) do
    if temp == temperatureToAdd then
      temperaturePresent = true
      break
    end
  end
  if not temperaturePresent then
    table.insert(compressedFluids.remoteData.fluidTemperatures[fluidName], temperatureToAdd)
  end
end

compressedFluids.remote.removeTemperatureFromFluid = function(fluidName, temperatureToRemove)
  compressedFluids.remoteData.fluidTemperatures =
    compressedFluids.remoteData.fluidTemperatures or {}
  if not compressedFluids.remoteData.fluidTemperatures[fluidName] then return end

  local tableEmpty = true
  local tempTable = util.table.deepcopy(compressedFluids.remoteData.fluidTemperatures[fluidName])
  for tempIndex, temp in pairs(tempTable) do
    if temp == temperatureToRemove then
      compressedFluids.remoteData.fluidTemperatures[fluidName][tempIndex] = nil
    else
      tableEmpty = false
    end
  end

  if tableEmpty then
    compressedFluids.remoteData.fluidTemperatures[fluidName] = nil
  end
end
