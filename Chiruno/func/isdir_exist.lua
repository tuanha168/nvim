Chiruno = Chiruno or {}

--- Check if a directory exists in this path
local function isdir_exist(path)
  -- "/" works on both Unix and Windows
  return Chiruno.file_exist(path .. "/")
end

Chiruno.isdir_exist = isdir_exist

return Chiruno.isdir_exist
