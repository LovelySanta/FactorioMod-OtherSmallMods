
--------------------------------------------------------------------------------
----- Rocket-silo                                                          -----
--------------------------------------------------------------------------------
data.raw["rocket-silo"]["rocket-silo"].fixed_recipe = nil
data.raw["rocket-silo"]["rocket-silo"].rocket_parts_required = 1
if data.raw["rocket-silo"]["rocket-silo"].ingredient_count < 6 then
  data.raw["rocket-silo"]["rocket-silo"].ingredient_count = 6
end
