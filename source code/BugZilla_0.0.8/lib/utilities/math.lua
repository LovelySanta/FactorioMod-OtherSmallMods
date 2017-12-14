Math = {} --luacheck: allow defined top

function Math.Init(self)
	local seed_gen = game.create_random_generator() -- uses map string to seed_gen

	-- get seed_gen ready
	local seed_iter = self:Round(seed_gen(1,100))
	while seed_iter > 0 do
		seed_gen()
		seed_iter = seed_iter - 1
	end

	-- seed the generator
  math.randomseed(self:Round(seed_gen(1,math.pow(2,32))))
	while seed_iter < 100 do
		local temp = math.random()
		seed_iter = seed_iter + 1
	end
end



function Math.Lerp(self, startVal, endVal, t)
  return (startVal + ((endVal - startVal) * t))
end



function Math.Clamp(self, val, minVal, maxVal)
  if val <= minVal then
    return minVal
  elseif val >= maxVal then
    return maxVal
  else
    return val
  end
end



function Math.Round(self, number)
  if number >= 0 then
    return math.floor(number + .5)
  else
    return (-1) * math.floor(math.abs(number) + .5)
  end
end
