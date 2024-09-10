return function(_, opts)
  opts.init_options = opts.init_options or {}
  opts.init_options.vue = opts.init_options.vue or {}
  opts.init_options.vue.hybridMode = false

  require("lspconfig").volar.setup(opts)
end
