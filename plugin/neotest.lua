require("lazyload").on_vim_enter(function()
  vim.pack.add({
    Utils.github("nvim-neotest/neotest"),
    Utils.github("nvim-neotest/nvim-nio"),
    Utils.github("nvim-lua/plenary.nvim"),
    Utils.github("antoinemadec/FixCursorHold.nvim"),
    Utils.github("nvim-treesitter/nvim-treesitter"),
    Utils.github("nvim-neotest/neotest-plenary"),
    Utils.github("nvim-neotest/neotest-vim-test"),
    Utils.github("fredrikaverpil/neotest-golang"),
    Utils.github("leoluz/nvim-dap-go"),
  })

  local adapters = {}

  adapters["neotest-golang"] = {
    go_test_args = {
      "-v",
      "-race",
      "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
    },
  }

  -- vim.api.nvim_create_autocmd("LspAttach", {
  --   callback = function()
  for name, config in pairs(adapters or {}) do
    if type(name) == "number" then
      if type(config) == "string" then
        config = require(config)
      end
      adapters[#adapters + 1] = config
    elseif config ~= false then
      local adapter = require(name)
      if type(config) == "table" and not vim.tbl_isempty(config) then
        local meta = getmetatable(adapter)
        if adapter.setup then
          adapter.setup(config)
        elseif adapter.adapter then
          adapter.adapter(config)
          adapter = adapter.adapter
        elseif meta and meta.__call then
          adapter(config)
        else
          error("Adapter " .. name .. " does not support setup")
        end
      end
      adapters[#adapters + 1] = adapter
    end
  end

  local opts = {}
  opts.adapters = adapters
  require("neotest").setup(opts)
  -- end,

  --   once = true,
  -- })

  local function map(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { desc = desc })
  end

-- stylua: ignore
map("<leader>ta", function() require("neotest").run.attach() end, "[t]est [a]ttach")
  map("<leader>tf", function()
    require("neotest").summary.open()
    require("neotest").run.run(vim.fn.expand("%"))
  end, "[t]est run [f]ile")
  map("<leader>tA", function()
    require("neotest").run.run(vim.uv.cwd())
  end, "[t]est [A]ll files")
  map("<leader>tS", function()
    require("neotest").run.run({ suite = true })
  end, "[t]est [S]uite")
  map("<leader>tn", function()
    require("neotest").run.run()
  end, "[t]est [n]earest")
  map("<leader>tl", function()
    require("neotest").run.run_last()
  end, "[t]est [l]ast")
  map("<leader>ts", function()
    require("neotest").summary.toggle()
  end, "[t]est [s]ummary")
  map("<leader>to", function()
    require("neotest").output.open({ enter = true, auto_close = true })
  end, "[t]est [o]utput")
  map("<leader>tO", function()
    require("neotest").summary.open()
    require("neotest").output_panel.open()
  end, "[t]est [O]pen")
  map("<leader>tt", function()
    require("neotest").summary.close()
    require("neotest").run.stop()
  end, "[t]est [t]erminate")
  map("<leader>tc", function()
    require("neotest").run.stop()
    require("neotest").summary.close()
    require("neotest").output_panel.close()
  end, "[t]est [c]lose")
  map("<leader>td", function()
    require("neotest").summary.close()
    require("neotest").run.run({ suite = false, strategy = "dap" })
  end, "Debug nearest test")
  map("<leader>tD", function()
    require("neotest").summary.close()
    require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
  end, "Debug current file")
end)
