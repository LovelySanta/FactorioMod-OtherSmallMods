require "util"

-- science pack subgroup
data.raw["item-subgroup"]["science-pack"].group = "science"

-- science bottling subgroup
local scienceRawMaterial = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceRawMaterial.name = "science-raw-material"
scienceRawMaterial.order = scienceRawMaterial.order .. "-a-a"

-- science bottling subgroup
local scienceBottling = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceBottling.name = "science-bottling"
scienceBottling.order = scienceBottling.order .. "-a-b"

-- science fluid subgroup
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

-- infused science pack subgroup
local infusedSciencePack = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
infusedSciencePack.name = "infused-science-pack"
infusedSciencePack.order = infusedSciencePack.order .. "-c-b"

-- science pack subgroup
data.raw["item-subgroup"]["science-pack"].order = data.raw["item-subgroup"]["science-pack"].order .. "-c-a"

data:extend({
  scienceRawMaterial,
  scienceBottling,
  scienceFluid,
  scienceBarrelFill,
  scienceBarrelEmpty,
  infusedSciencePack,
})
