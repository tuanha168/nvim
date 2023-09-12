return function(_, opts)
  Chiruno.print "test"
  opts.filetypes = {
    "typescript",
    -- "html",
    "scss",
  }
  return opts
end
