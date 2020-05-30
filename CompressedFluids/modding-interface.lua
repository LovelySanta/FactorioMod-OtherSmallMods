require("__LSlib__/LSlib")

compressedFluids = compressedFluids or {}
compressedFluids.remote = compressedFluids.remote or {}
compressedFluids.remoteData = compressedFluids.remoteData or {}

compressedFluids.remote.forceCompressingFluid = function(fluidName)
    compressedFluids.remoteData.forcedCompressedFluids =
    compressedFluids.remoteData.forcedCompressedFluids or {}

    compressedFluids.remoteData.forcedCompressedFluids[fluidName] = true
end