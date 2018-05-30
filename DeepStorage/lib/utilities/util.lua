function stringSplit(inputstring, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    local i = 1
    for str in string.gmatch(inputstring, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function deepcopy(original)
  local original_type = type(original)
  local copy
  if original_type == 'table' then
    copy = {}
    for original_key, original_value in next, original, nil do
      copy[deepcopy(original_key)] = deepcopy(original_value)
    end
  else -- number, string, boolean, etc
    copy = original
  end
  return copy
end
