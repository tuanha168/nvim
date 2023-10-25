Chiruno = {
  autocmd = {},
  func = {},
  motions = {},
  textobjs = {},
}

require "user.Chiruno.env"

local paths = vim.split(vim.fn.glob(string.gsub(debug.getinfo(1).source, "^@(.*)init.lua$", "%1") .. "**/*.lua"), "\n")

for _, path in ipairs(paths) do
  local path_split = string.gsub(string.gsub(path, "/", "."), ".*" .. ..., "")
  local file = string.gsub(path_split, "%.lua?$", "") -- trim off .lua\n

  if file ~= ".init" and file ~= ".env" then require(... .. file) end
end

return Chiruno
