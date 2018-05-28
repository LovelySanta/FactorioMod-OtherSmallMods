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
