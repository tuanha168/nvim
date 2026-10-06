require("which-key").add {
  {
    "<Leader>cc",
    function() require("config.opencode_ensure").send() end,
    mode = { "n", "x" },
    desc = "Send line/range to agent pane",
  },
}
