local function edit_or_open()
  -- open as vsplit on current node
  local action = "edit"
  local node = require("nvim-tree.lib").get_node_at_cursor()

  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
    require("nvim-tree.view").close() -- Close the tree if file was opened
  elseif node.nodes ~= nil then
    require("nvim-tree.lib").expand_or_collapse(node)
  else
    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
    require("nvim-tree.view").close() -- Close the tree if file was opened
  end
end

local M = {
  git = {
    enable = true,
    ignore = false,
  },
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = "<Tab>", action = "edit", action_cb = edit_or_open },
      },
    },
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = "name",

    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
