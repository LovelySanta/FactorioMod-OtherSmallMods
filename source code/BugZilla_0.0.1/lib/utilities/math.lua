Math = {} --luacheck: allow defined top

function Math.Lerp(startVal, endVal, t)
	return (startVal + ((endVal - startVal) * t))
end

function Math.Clamp(val, minVal, maxVal)
	if val <= minVal then
		return minVal
	elseif val >= maxVal then
		return maxVal
  else
    return val
	end
end
