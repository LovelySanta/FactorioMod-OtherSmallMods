require "util"

-- science pack subgroup
data.raw["item-subgroup"]["science-pack"].group = "science"

-- science bottling
local scienceRawMaterial = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceRawMaterial.name = "science-raw-material"
scienceRawMaterial.order = scienceRawMaterial.order .. "-a-a"

-- science bottling
local scienceBottling = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceBottling.name = "science-bottling"
scienceBottling.order = scienceBottling.order .. "-a-b"

-- science fluid
local scienceFluid = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceFluid.name = "science-fluid"
scienceFluid.order = scienceFluid.order .. "-b-a"

-- science fluid barreling
local scienceBarrelFill = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceBarrelFill.name = "science-barrel-fill"
scienceBarrelFill.order = scienceBarrelFill.order .. "-b-b"

-- science fluid barreling
local scienceBarrelEmpty = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceBarrelEmpty.name = "science-barrel-empty"
scienceBarrelEmpty.order = scienceBarrelEmpty.order .. "-b-c"

-- infused science pack
local infusedSciencePack = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
infusedSciencePack.name = "infused-science-pack"
infusedSciencePack.order = infusedSciencePack.order .. "-c-b"

-- rocket parts
local rocketParts = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
rocketParts.name = "rocket-parts"
rocketParts.order = rocketParts.order .. "-d-a"

-- rocket assembly
local rocketAssembly = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
rocketAssembly.name = "rocket-assembly"
rocketAssembly.order = rocketAssembly.order .. "-d-b"

-- science pack subgroup
data.raw["item-subgroup"]["science-pack"].order = data.raw["item-subgroup"]["science-pack"].order .. "-c-a"



data:extend({
  scienceRawMaterial,
  scienceBottling,

  scienceFluid,
  scienceBarrelFill,
  scienceBarrelEmpty,

  -- sciencePack, -- vanilla
  infusedSciencePack,

  rocketParts,
  rocketAssembly,
})
