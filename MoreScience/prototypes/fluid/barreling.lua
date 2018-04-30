require "lib/utilities/prototyping"

--------------------------------------------------------------------------------
----- ¨Purified water                                                       -----
--------------------------------------------------------------------------------
if data.raw["recipe"]["fill-purified-water-barrel"] then
  data.raw["recipe"]["fill-purified-water-barrel"].subgroup = "science-raw-material"
  data.raw["recipe"]["fill-purified-water-barrel"].order = data.raw["fluid"]["purified-water"].order

  removeRecipeUnlock("fluid-handling", "fill-purified-water-barrel")
  addRecipeUnlock("fluid-handling-3", "fill-purified-water-barrel")
end

if data.raw["recipe"]["empty-purified-water-barrel"] then
  data.raw["recipe"]["empty-purified-water-barrel"].subgroup = "science-raw-material"
  data.raw["recipe"]["empty-purified-water-barrel"].order = data.raw["fluid"]["purified-water"].order

  removeRecipeUnlock("fluid-handling", "empty-purified-water-barrel")
  addRecipeUnlock("fluid-handling-3", "empty-purified-water-barrel")
end

--------------------------------------------------------------------------------
----- Science fluids                                                       -----
--------------------------------------------------------------------------------
for _,scienceFluid in pairs({
  "basic-science-fluid-1",
  "basic-science-fluid-2",
  "basic-science-fluid-3",
  "advanced-science-fluid-1",
  "advanced-science-fluid-2",
  "extreme-science-fluid",
  "basic-military-science-fluid",
  "basic-automation-science-fluid",
  "basic-power-science-fluid",
  "basic-logistics-science-fluid",
}) do
  -- Filling barrel recipe
  if data.raw["recipe"]["fill-"..scienceFluid.."-barrel"] then
    data.raw["recipe"]["fill-"..scienceFluid.."-barrel"].subgroup = "science-barrel-fill"
    data.raw["recipe"]["fill-"..scienceFluid.."-barrel"].order = data.raw["fluid"][scienceFluid].order

    removeRecipeUnlock("fluid-handling", "fill-"..scienceFluid.."-barrel")
    addRecipeUnlock("fluid-handling-3", "fill-"..scienceFluid.."-barrel")
  end

  -- Empty barrel recipe
  if data.raw["recipe"]["empty-"..scienceFluid.."-barrel"] then
    data.raw["recipe"]["empty-"..scienceFluid.."-barrel"].subgroup = "science-barrel-empty"
    data.raw["recipe"]["empty-"..scienceFluid.."-barrel"].order = data.raw["fluid"][scienceFluid].order

    removeRecipeUnlock("fluid-handling", "empty-"..scienceFluid.."-barrel")
    addRecipeUnlock("fluid-handling-3", "empty-"..scienceFluid.."-barrel")
  end
end
