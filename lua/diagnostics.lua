return function(signs)
  return {
    update_in_insert = false,
    inlay_hints = {
      enabled = true,
    },
    virtual_text = true,
    signs = { active = signs },
    underline = true,
    severity_sort = true,
    float = {
      focused = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }
end
