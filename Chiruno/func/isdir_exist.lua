--- Check if a directory exists in this path
function Chiruno.isdir_exist(path)
  -- "/" works on both Unix and Windows
  return Chiruno.func.file_exist(path .. "/")
end

return Chiruno.isdir_exist
