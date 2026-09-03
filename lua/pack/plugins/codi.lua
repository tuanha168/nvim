local lazy = require "pack.lazy-load"

local plugin = "https://github.com/metakirby5/codi.vim"

local scratch_node_modules = os.getenv "HOME" .. "/.config/nvim/scratch/node_modules"

local function ts_interpreter_bin()
  local script = table.concat {
    "const ts=require('typescript');",
    "const vm=require('vm');",
    "require('repl').start({",
    "ignoreUndefined:true,useGlobal:true,",
    "eval(cmd,context,filename,cb){",
    "let out;",
    "try{out=ts.transpileModule(cmd,{compilerOptions:{module:ts.ModuleKind.CommonJS,target:ts.ScriptTarget.ESNext}}).outputText;}",
    "catch(e){return cb(e);}",
    "try{cb(null,vm.runInThisContext(out,{filename:filename}));}",
    "catch(e){cb(e);}",
    "},",
    "});",
  }
  return { "env", "NODE_PATH=" .. scratch_node_modules, "node", "-e", script }
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "codi.vim" and (ev.data.kind == "install" or ev.data.kind == "update") then
      vim.system { "sh", "-c", "composer g require psy/psysh:@stable" }
    end
  end,
})

lazy.on_command(plugin, "Codi", function()
  vim.g["codi#interpreters"] = { typescript = { bin = ts_interpreter_bin() } }
end)
