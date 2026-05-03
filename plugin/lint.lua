require("lazyload").on_vim_enter(function()
  vim.pack.add({
    Utils.github("mfussenegger/nvim-lint"),
  })

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = lint_augroup,
    -- pattern = { "*.lua", "*.json", "*.go", "*.js", "*.ts" },
    callback = function()
      require("lint").linters_by_ft = {
        markdown = { "vale" },
        go = { "golangcilint" },
      }
      require("lint").try_lint()
    end,
  })
end)
