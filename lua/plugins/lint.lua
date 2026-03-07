return {
  "mfussenegger/nvim-lint",
  config = function()
    local nvimlint = require("lint")
    nvimlint.linters_by_ft = {
      markdown = { "vale" },
      go = { "golangcilint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      pattern = "*.go",
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        nvimlint.try_lint()

        -- You can call `try_lint` with a linter name or a list of names to always
        -- run specific linters, independent of the `linters_by_ft` configuration
        -- require("lint").try_lint("golangcilint")
      end,
    })
  end,
}
