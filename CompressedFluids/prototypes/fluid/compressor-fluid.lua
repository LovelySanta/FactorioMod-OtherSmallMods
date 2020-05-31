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