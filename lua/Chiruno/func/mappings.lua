Chiruno = Chiruno or {}

local function set_mappings(map_table, base)
  -- iterate over the first keys for each mode
  base = base or {}
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base
        if type(options) == "table" then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
          keymap_opts[1] = nil
        end
        vim.keymap.set(mode, keymap, cmd, keymap_opts)
      end
    end
  end
end

Chiruno.set_mappings = set_mappings

return Chiruno.set_mappings
