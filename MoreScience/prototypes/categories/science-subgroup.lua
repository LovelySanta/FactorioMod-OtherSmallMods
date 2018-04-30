require "util"

-- science pack subgroup
data.raw["item-subgroup"]["science-pack"].group = "science"

-- science bottling subgroup
scienceFluid = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceFluid.name = "science-bottling"
scienceFluid.order = scienceFluid.order .. "-a-a"
data:extend({
  scienceFluid
})

-- science fluid subgroup
scienceFluid = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceFluid.name = "science-fluid"
scienceFluid.order = scienceFluid.order .. "-b-a"
data:extend({
  scienceFluid
})

-- infused science pack subgroup
infusedSciencePack = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
infusedSciencePack.name = "infused-science-pack"
infusedSciencePack.order = infusedSciencePack.order .. "-c-b"
data:extend({
  infusedSciencePack
})

-- science pack subgroup
data.raw["item-subgroup"]["science-pack"].order = data.raw["item-subgroup"]["science-pack"].order .. "-c-a"
