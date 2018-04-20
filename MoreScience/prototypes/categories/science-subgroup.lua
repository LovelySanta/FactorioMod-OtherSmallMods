require "util"


-- science fluid subgroup
scienceFluid = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceFluid.name = "science-fluid"
scienceFluid.order = scienceFluid.order .. "-a"
data:extend({
  scienceFluid
})

-- infused science pack subgroup
infusedSciencePack = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
infusedSciencePack.name = "infused-science-pack"
infusedSciencePack.order = infusedSciencePack.order .. "-b-b"
data:extend({
  infusedSciencePack
})

-- science pack subgroup
data.raw["item-subgroup"]["science-pack"].order = data.raw["item-subgroup"]["science-pack"].order .. "-b-a"
