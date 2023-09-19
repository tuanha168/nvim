Chiruno = Chiruno or {}

function Chiruno.extends_table(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
  end
  return t1
end

return Chiruno.extends_table
