return {
  on_new_config = function(new_config)
    new_config.init_options = {
      ["language_server_completion.trim_leading_dollar"] = false,
      -- ["completion_worse.completor.class.limit"] = 100,
      -- ["worse_reflection.enable_cache"] = true,
      -- ["worse_reflection.cache_dir"] = "%cache%/worse-reflection",
      -- ["worse_reflection.stub_dir"] = "%application_root%/_ide_helper.php",
    }
  end,
}
