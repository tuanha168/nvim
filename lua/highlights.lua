---@type table<string, vim.api.keyset.highlight>
return {
  Visual = { bg = "#576b8a", fg = "none" },
  DiffAdd = { bg = "#085c24", fg = "none" },
  DiffText = { bg = "#085c24", fg = "none" },
  diffRemoved = { bg = "#7a1431", fg = "none" },
  -- DiffChange = { bg = "#576b8a", fg = "none" },
  DiffDelete = { bg = "#7a1431", fg = "none" },
  ComplHint = { fg = "#b6dee3" },
  TrailingWhitespace = { bg = "red" },
  MatchParen = { bg = "#576b8a", fg = "none" },
}
