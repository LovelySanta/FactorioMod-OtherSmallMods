require "modding-interface"

if true then -- base game
  compressedFluids.remote.forceCompressingFluid("steam")
  compressedFluids.remote.addTemperatureToFluid("steam", 165) -- boiler
  compressedFluids.remote.addTemperatureToFluid("steam", 500) -- heat exchanger
end

if mods["pycoalprocessing"] then
    compressedFluids.remote.forceCompressingFluid("combustion-mixture1")
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 500) -- CoalGas, Heavy Oil
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 520)
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 525) -- CoalSlurry
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 550) -- SynGas, Light Oil
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 600) -- Diborane, PetGas
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 650) -- Methanol
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 670) -- Acetylene
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 700) -- RefSynGas
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 750) -- Olefin
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 800) -- Diesel
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 850) -- Gasoline
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 900) -- Supercritical Coal
    compressedFluids.remote.addTemperatureToFluid("combustion-mixture1", 1000) -- Ultracritical Coal
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
    compressedFluids.remote.addTemperatureToFluid("steam", 500) -- Boiler 5, Heat Exchanger 1
    compressedFluids.remote.addTemperatureToFluid("steam", 750) -- Boiler 6, Heat Exchanger 2
end

if mods["Krastorio2"] then
    compressedFluids.remote.forceCompressingFluid("steam")
    compressedFluids.remote.addTemperatureToFluid("steam", 415) -- Rescalled Heat exchanger
    compressedFluids.remote.addTemperatureToFluid("steam", 975) -- Fusion reactor
end

if mods["space-exploration"] then
    compressedFluids.remote.forceCompressingFluid("steam")
    compressedFluids.remote.addTemperatureToFluid("steam", 5000) -- High temperature heat exchanger
    if mods["Krastorio2"] then
        compressedFluids.remote.addTemperatureToFluid("steam", 99) -- Electric boiler
    end
  
    compressedFluids.remote.forceCompressingFluid("se-space-coolant-hot")
    compressedFluids.remote.forceCompressingFluid("se-space-coolant-warm")
    compressedFluids.remote.addTemperatureToFluid("se-space-coolant-warm", -10)
    compressedFluids.remote.forceCompressingFluid("se-space-coolant-cold")
    compressedFluids.remote.addTemperatureToFluid("se-space-coolant-cold", -100)
    compressedFluids.remote.forceCompressingFluid("se-space-coolant-supercooled")
    compressedFluids.remote.addTemperatureToFluid("se-space-coolant-supercooled", -273)

    compressedFluids.remote.forceCompressingFluid("se-antimatter-stream")
    compressedFluids.remote.addTemperatureToFluid("se-antimatter-stream", 10000)
    compressedFluids.remote.forceCompressingFluid("se-plasma-stream")
    compressedFluids.remote.addTemperatureToFluid("se-plasma-stream", 5000)
    compressedFluids.remote.forceCompressingFluid("se-ion-stream")
    compressedFluids.remote.addTemperatureToFluid("se-ion-stream", 5000)
    compressedFluids.remote.forceCompressingFluid("se-particle-stream")
    compressedFluids.remote.addTemperatureToFluid("se-particle-stream", 5000)
    compressedFluids.remote.forceCompressingFluid("se-proton-stream")
    compressedFluids.remote.addTemperatureToFluid("se-proton-stream", 5000)

    compressedFluids.remote.forceCompressingFluid("se-secomppressing-steam")
    compressedFluids.remote.addTemperatureToFluid("se-secomppressing-steam", 15)
end

if mods["Geothermal-Vents"] then
  compressedFluids.remote.forceCompressingFluid("steam")
  compressedFluids.remote.addTemperatureToFluid("steam", settings.startup["geothermal-vents-steam-temp"].value)
end
