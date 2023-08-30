Chiruno = Chiruno or {}

function Chiruno.buf_vtext()
  local a_orig = vim.fn.getreg "a"
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" then vim.cmd [[normal! gv]] end
  vim.cmd [[normal! "aygv]]
  local text = vim.fn.getreg "a"
  vim.fn.setreg("a", a_orig)
  return text
end

return Chiruno.buf_vtext
