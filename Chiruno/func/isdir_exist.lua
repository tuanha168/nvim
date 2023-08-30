Chiruno = Chiruno or {}

--- Check if a directory exists in this path
function Chiruno.isdir_exist(path)
  -- "/" works on both Unix and Windows
  return Chiruno.file_exist(path .. "/")
end

return Chiruno.isdir_exist
