require("lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = Utils.github("mfussenegger/nvim-lint"), name = "lint" },
  })

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = lint_augroup,
    callback = function()
      if vim.bo.modifiable then
        require("lint").try_lint(nil, { ignore_errors = true })
      end

      -- require("lint").linters_by_ft = {
      --   markdown = { "vale" },
      --   go = { "golangcilint" },
      -- }
      -- -- try_lint without arguments runs the linters defined in `linters_by_ft`
      -- -- for the current filetype
      -- require("lint").try_lint()
    end,
  })
end)
