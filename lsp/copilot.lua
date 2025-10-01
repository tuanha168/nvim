return {
  root_markers = { ".git" },
  cmd = { "copilot-language-server", "--stdio" },
  settings = {
    github = {
      copilot = {
        selectedCompletionModel = "claude-sonnet-4",
      },
    },
  },
}
