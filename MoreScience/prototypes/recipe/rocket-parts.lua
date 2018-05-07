local hullComponent =
{
  type = "recipe",
  name = "hull-component",
  energy_required = 40,
  enabled = false,
  ingredients =
  {
    {"low-density-structure", 25},
    {"rocket-control-unit", 1},
  },
  result = "hull-component"
}

local ionThruster =
{
  type = "recipe",
  name = "ion-thruster",
  energy_required = hullComponent.energy_required * 3,
  enabled = false,
  ingredients =
  {
    {"low-density-structure", 10},
    {"rocket-fuel", 75},
    {"rocket-control-unit", 60},
  },
  result = "ion-thruster"
}

local ionBooster =
{
  type = "recipe",
  name = "ion-booster",
  energy_required = ionThruster.energy_required * (5 + 5),
  enabled = false,
  ingredients =
  {
    {"low-density-structure", 30},
    {"ion-thruster", 5},
    {"rocket-fuel", 150}, -- 1000 - (5+5)*75 - 100
    {"rocket-control-unit", 40},
  },
  result = "ion-booster"
}

local fusionReactor =
{
  type = "recipe",
  name = "fusion-reactor",
  energy_required = ionBooster.energy_required / 2,
  enabled = false,
  ingredients =
  {
    {"fusion-reactor-equipment", 1},
    {"rocket-control-unit", 15},
    {"nuclear-fuel", 50},
  },
  result = "fusion-reactor"
}

local shieldArray =
{
  type = "recipe",
  name = "shield-array",
  energy_required = ionBooster.energy_required / 3,
  enabled = false,
  ingredients =
  {
    {"low-density-structure", 20},
    {"rocket-control-unit", 50},
    {"energy-shield-mk2-equipment", 5},
    {"radar", 10},
  },
  result = "shield-array"
}

local laserArray =
{
  type = "recipe",
  name = "laser-array",
  energy_required = shieldArray.energy_required,
  enabled = false,
  ingredients =
  {
    {"low-density-structure", 20},
    {"rocket-control-unit", 50},
    {"discharge-defense-equipment", 5},
    {"radar", 10},
  },
  result = "laser-array"
}

-- Rocket MK1 calculation:
data:extend({    --      amount:   lds    rcu    rf
  hullComponent, --      30        25     1      0

  ionThruster,   --      5 (+5)    10     60     75
  ionBooster,    --      1         30     40     150

  fusionReactor, --      2         0      15     (50)

  shieldArray,   --      3         20     50     0
  laserArray,    --      3         20     50     0
                 --               ----    ----   ----
                 --     total:    1000    1000   1000
})
