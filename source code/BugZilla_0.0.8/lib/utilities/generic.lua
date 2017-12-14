require 'lib/utilities/math'

function MessageAll(s)
  game.print(s)

  -- If mod ChatToFile is in the modlist, we can print this out too
  if remote.interfaces.ChatToFile and remote.interfaces.ChatToFile.chat then
    remote.call("ChatToFile", "chat", s)
  end
end

function DeepCopy(original)
  local original_type = type(original)
  local copy
  if original_type == 'table' then
    copy = {}
    for original_key, original_value in next, original, nil do
      copy[DeepCopy(original_key)] = DeepCopy(original_value)
    end
  else -- number, string, boolean, etc
    copy = original
  end
  return copy
end

function TableHasValue(table, value)
  for _,val in pairs(table) do
    if value == val then
      return true
    end
  end

  return false
end
