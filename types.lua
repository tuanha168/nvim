---@class AutocmdCallbackEvent
---@field id number autocommand id
---@field event string name of the triggered event `autocmd-events`
---@field group number|nil autocommand group id, if any
---@field match string expanded value of `<amatch>`
---@field buf number expanded value of `<abuf>`
---@field file string expanded value of `<afile>`
---@field data any arbitrary data passed from `nvim_exec_autocmds()`

---@alias NullWindowOptionKeys "left" | "right"

---@alias NullWindowOptions table<NullWindowOptionKeys, boolean>
