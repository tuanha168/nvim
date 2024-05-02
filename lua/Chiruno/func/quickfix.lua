function Chiruno.func.get_quickfix_by_title(title)
  for i = 1, 10 do
    local qflist = vim.fn.getqflist { nr = i, id = 0, title = true }

    Chiruno.func.print(qflist)

    if qflist.title == title then return qflist.id end
  end
  vim.fn.setqflist({}, " ", { nr = "$", title = title })
  return Chiruno.func.get_quickfix_by_title(title)
end

-- Add without removing existing items
function Chiruno.func.add_quickfix_items(id, items, title)
  vim.fn.setqflist({}, "a", { id = id, items = items, title = title })
end

-- Replace existing items
function Chiruno.func.set_quickfix_items(id, items, title)
  vim.fn.setqflist({}, "r", { id = id, items = items, title = title })
end

function Chiruno.func.open_quickfix(title)
  require("telescope.builtin").quickfix { id = Chiruno.func.get_quickfix_by_title(title) }
end
