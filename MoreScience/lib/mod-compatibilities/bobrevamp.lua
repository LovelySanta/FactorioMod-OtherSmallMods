require "lib/utilities/prototyping"

if mods["bobrevamp"] then
  log("Mod compatibility with bobrevamp update")
  -- Remove chemical plant recipe unlock
  removeRecipeUnlock("chemical-plant", "chemical-plant")
  --addPrerequisiteTechnology("chemical-plant", "basic-science-research-1")
end
