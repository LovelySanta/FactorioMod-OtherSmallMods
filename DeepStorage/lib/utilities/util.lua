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

function tableIsEmpty(t)
  return not next(t)
end

function tablesAreEqual(t1, t2)
  if type(t1) ~= 'table' or type(t2) ~= 'table' then
    return t1 == t2
  end
  for k,v in pairs(t1) do
    if not tablesAreEqual(v, t2[k]) then
      return false
    end
  end
  for k,v in pairs(t2) do
    if not tablesAreEqual(v, t1[k]) then
      return false
    end
  end
  return true
end
