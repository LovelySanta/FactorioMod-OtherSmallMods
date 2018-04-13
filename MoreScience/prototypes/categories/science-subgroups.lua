require "util"


-- science fluid subgroup
scienceFluid = util.table.deepcopy(data.raw["item-subgroup"]["science-pack"])
scienceFluid.name = "science-fluid"
scienceFluid.order = scienceFluid.order .. "-a"
data:extend({
  scienceFluid
})

-- science pack subgroup
data.raw["item-subgroup"]["science-pack"].order = data.raw["item-subgroup"]["science-pack"].order .. "-b"
