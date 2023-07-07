Chiruno.get_quickfix_by_title = function(title)
  for i = 1, 10 do
    local qflist = vim.fn.getqflist({ nr = i, id = 0, title = true })

    Chiruno.print(qflist)

    if qflist.title == title then
      return qflist.id
    end
  end
  vim.fn.setqflist({}, " ", { nr = "$", title = title })
  return Chiruno.get_quickfix_by_title(title)
end

-- Add without removing existing items
Chiruno.add_quickfix_items = function(id, items, title)
  vim.fn.setqflist({}, "a", { id = id, items = items, title = title })
end

-- Replace existing items
Chiruno.set_quickfix_items = function(id, items, title)
  vim.fn.setqflist({}, "r", { id = id, items = items, title = title })
end

Chiruno.open_quickfix = function(title)
  require('telescope.builtin').quickfix({ id = Chiruno.get_quickfix_by_title(title) })
end
