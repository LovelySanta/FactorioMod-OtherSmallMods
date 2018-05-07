
--------------------------------------------------------------------------------
----- Rocket-MK1                                                           -----
--------------------------------------------------------------------------------

data.raw["recipe"]["rocket-part"].energy_required = data.raw["recipe"]["rocket-part"].energy_required * 100
data.raw["recipe"]["rocket-part"].hidden = nil
data.raw["recipe"]["rocket-part"].ingredients =
{
  {"hull-component", 30},
  {"ion-thruster", 5},
  {"ion-booster", 1},
  {"fusion-reactor", 2},
  {"shield-array", 3},
  {"laser-array", 3},
}
