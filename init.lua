vim.opt.title = true
vim.opt.titlestring = '%( %M%)%( (%{expand("%:~:h")})%)%a'

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.neovide_scale_factor = 1

-- nvim tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim.opts
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.opt.nu = true
vim.opt.relativenumber = true
-- indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
-- appearance
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- vim.pack.add({gh("rafamadriz/friendly-snippets")},
--     {gh("nvim-tree/nvim-web-devicons")},
--     -- "giuxtaposition/blink-cmp-copilot",
--     {
--         src = gh("L3MON4D3/LuaSnip"),
--         version = vim.version.range("2.x") -- or vim.version.range('*') for latest
--     }, {
--         src = gh("saghen/blink.cmp"),
--         version = vim.version.range("1.x") -- or vim.version.range('*') for latest
--     },
--     {gh("rebelot/kanagawa.nvim")},
--     {gh("mason-org/mason.nvim")},
--     {gh("neovim/nvim-lspconfig")},
--     {gh("mason-org/mason-lspconfig.nvim")},
--     {gh("folke/snacks.nvim")},
--     {gh("nvim-treesitter/nvim-treesitter")})

vim.diagnostic.config({
  signs = {
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
    },
    text = {
      [vim.diagnostic.severity.ERROR] = "X",
      [vim.diagnostic.severity.HINT] = "?",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.WARN] = "!",
    },
  },
  update_in_insert = true,
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
})

vim.lsp.inlay_hint.enable(true)
_G.Utils = require("autocmds.initial")
_G.Utils = require("utils")

-- config Lazy

-- vim.cmd("colorscheme kanagawa-dragon")
require("config.keymaps")

if vim.g.vscode then
  require("config.keymaps-vscode")
else
  require("config.keymaps-nvim")
end
