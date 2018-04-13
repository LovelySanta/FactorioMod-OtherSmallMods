
local function createScienceFluid(fluidName, order, fluidNumber, baseColor, flowColor)
  local function numberToString(number)
    if number >= 10 then return "" .. number else return "0" .. number end
  end

  data:extend({
    {
      type = "fluid",
      name = fluidName,
      icon = "__MoreScience__/graphics/fluids/fluid-" .. numberToString(fluidNumber) .. ".png",
      icon_size = 32,

      base_color = baseColor,
      flow_color = flowColor,

      default_temperature = 0,
      max_temperature = 0,
      heat_capacity = "0.1KJ",

      pressure_to_speed_ratio = 0.4,
      flow_to_energy_ratio = 0.59,
      -- fuel_value = "8MJ",
      order = "z-MoreScience-" .. order .. "[" .. fluidName .. "]"
    },
  })
end

-- purified water
createScienceFluid("purified-water", "a", 0, {r=191./255, g=19./255, b=19./255}, {r=0.5, g=0.5, b=0.5})

-- automation science fluid
createScienceFluid("basic-automation-science-fluid", "e", 15, {r=191./255, g=19./255, b=19./255}, {r=0.5, g=0.5, b=0.5})

-- automation science fluid
createScienceFluid("basic-logistics-science-fluid", "e", 13, {r=191./255, g=19./255, b=19./255}, {r=0.5, g=0.5, b=0.5})
