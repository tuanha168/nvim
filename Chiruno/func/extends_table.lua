Chiruno = Chiruno or {}

function Chiruno.extends_table(t1, t2) return vim.tbl_deep_extend("force", t1, t2) end

return Chiruno.extends_table
