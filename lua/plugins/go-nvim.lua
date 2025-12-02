local desc = Utils.plugin_keymap_desc("go.nvim")

return {
  "ray-x/go.nvim",
  enabled = not vim.g.vscode,
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    -- lsp_keymaps = false,
    -- other options
  },
  config = function(lp, opts)
    require("go").setup(opts)
    local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        require("go.format").goimports()
      end,
      group = format_sync_grp,
    })

    vim.keymap.set("n", "<leader>tc", ":GoTest -vn<CR>", { desc = desc("Run closest test") })
    vim.keymap.set("n", "<leader>tf", ":GoTestFile -v<CR>", { desc = desc("Run tests in current file") })
    vim.keymap.set("n", "<leader>ts", ":GoTestFunc -sv<CR>", { desc = desc("Select one test to run") })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
