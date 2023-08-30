--- Check if a file or directory exists in this path
function Chiruno.file_exist(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end
  return ok, err
end

return Chiruno.file_exist
