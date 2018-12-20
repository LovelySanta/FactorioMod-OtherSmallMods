
local folder = "stream-data/"

local function writeTime(event)
  local second = 60
  local minute = 60 * second
  local hour = 60 * minute

  local timeHours = math.floor(event.tick / (hour))
  local timeMinutes = math.floor((event.tick - timeHours * hour) / minute)

  local time = ""

  -- Add the hours to the time
  if (timeHours < 10) then
    if (timeHours > 0) then
      time = time .. "0" .. timeHours
    else
      time = time .. "00"
    end
  else
    time = time .. timeHours
  end

  time = time .. ":"

  -- Add the minutes to the time
  if (timeMinutes < 10) then
    if (timeMinutes > 0) then
      time = time .. "0" .. timeMinutes
    else
      time = time .. "00"
    end
  else
    time = time .. timeMinutes
  end

  -- Write time to file
  game.write_file(folder .. "MapInfoToFile-time.txt", time, false)
  --log(time)
end



local function writeEvolution(_)
  local evolution = game.forces["enemy"].evolution_factor * 100
  local precision = 4

  local beforeDecimalPoint = math.floor(evolution)
  local afterDecimalPoint = math.floor((evolution - beforeDecimalPoint) * (10 ^ precision))

  local evoFactor = "" .. beforeDecimalPoint .. "." .. string.format("%0"..precision.."d", afterDecimalPoint) .. " %"

  game.write_file(folder .. "MapInfoToFile-evolution.txt", evoFactor, false)

end



script.on_nth_tick(60*60,function(event)
  writeTime(event)

  writeEvolution(event)
end)
