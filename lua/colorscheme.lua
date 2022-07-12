local colorscheme = "nightfox"

local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status then
	vim.notify("colorscheme" .. colorscheme .. "not found!")
	return
end

local sts, _ = pcall(vim.cmd, "hi Normal guibg=NONE ctermbg=NONE")
if not sts then
  return
end
