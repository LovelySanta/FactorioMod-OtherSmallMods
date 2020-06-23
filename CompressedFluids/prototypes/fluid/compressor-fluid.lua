require "modding-interface"

if true then -- base game
  compressedFluids.remote.forceCompressingFluid("steam")
  compressedFluids.remote.addTemperatureToFluid("steam", 165) -- boiler
  compressedFluids.remote.addTemperatureToFluid("steam", 500) -- heat exchanger
end

if mods["bobrevamp"] then
  compressedFluids.remote.forceCompressingFluid("ammonia")
  compressedFluids.remote.forceCompressingFluid("carbon-dioxide")
  compressedFluids.remote.forceCompressingFluid("nitric-oxide")
  compressedFluids.remote.forceCompressingFluid("sour-gas")
end

if mods["bobplates"] then
  compressedFluids.remote.forceCompressingFluid("chlorine")
  compressedFluids.remote.forceCompressingFluid("deuterium")
  compressedFluids.remote.forceCompressingFluid("hydrogen")
  compressedFluids.remote.forceCompressingFluid("hydrogen-chloride")
  compressedFluids.remote.forceCompressingFluid("hydrogen-sulfide")
  compressedFluids.remote.forceCompressingFluid("nitrogen")
  compressedFluids.remote.forceCompressingFluid("nitrogen-dioxide")
  compressedFluids.remote.forceCompressingFluid("oxygen")
  compressedFluids.remote.forceCompressingFluid("sulfur-dioxide")
end

if mods["bobpower"] then
  if settings.startup["bobmods-power-steam"].value == true then
    -- Steam
    compressedFluids.remote.addTemperatureToFluid("steam", 165) -- Boiler 1
    compressedFluids.remote.addTemperatureToFluid("steam", 315) -- Boiler 2
    compressedFluids.remote.addTemperatureToFluid("steam", 465) -- Boiler 3, Heat Exchanger 1
    compressedFluids.remote.addTemperatureToFluid("steam", 615) -- Boiler 4, Heat Exchanger 2
    compressedFluids.remote.addTemperatureToFluid("steam", 765) -- Boiler 5, Heat Exchanger 3
    compressedFluids.remote.removeTemperatureFromFluid("steam", 500)
  end
end

if mods["Advanced_Electric"] then
    compressedFluids.remote.forceCompressingFluid("steam")
    compressedFluids.remote.addTemperatureToFluid("steam", 165) -- Boiler 1
    compressedFluids.remote.addTemperatureToFluid("steam", 215) -- Boiler 2
    compressedFluids.remote.addTemperatureToFluid("steam", 265) -- Boiler 3
    compressedFluids.remote.addTemperatureToFluid("steam", 315) -- Boiler 4
end
