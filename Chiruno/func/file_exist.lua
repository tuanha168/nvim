Chiruno = Chiruno or {}

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

Chiruno.file_exists = file_exists

return Chiruno.file_exists
