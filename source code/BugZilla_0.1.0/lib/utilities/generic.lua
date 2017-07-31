require 'Libs/Utility/math'

function MessageAll(s) --luacheck: allow defined top
  game.print(s)
  if remote.interfaces.ChatToFile and remote.interfaces.ChatToFile.chat then --luacheck: ignore
        remote.call("ChatToFile", "chat", s)
    end
end

function DeepCopy(original) --luacheck: allow defined top
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
