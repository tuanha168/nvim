return {
  settings = {
    intelephense = {
      diagnostics = {
        undefinedTypes = false,
        undefinedFunctions = false,
        undefinedConstants = false,
        undefinedClassConstants = false,
        undefinedMethods = false,
        undefinedProperties = false,
        undefinedVariables = false,
      },
      environment = {
        includePaths = { "{workspace}/fuel/core", "./fuel/vendor" },
      },
    },
  },
}
