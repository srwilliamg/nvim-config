vim.opt.title = true
vim.opt.titlestring = '%( %M%)%( (%{expand("%:~:h")})%)%a'

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.neovide_scale_factor = 1

-- vim.opts
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
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

vim.api.nvim_create_autocmd("TermLeave", {
  desc = "Reload buffers when leaving terminal",
  pattern = "*",
  callback = function()
    vim.cmd.checktime()
  end,
})

-- highlight_yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  desc = "highlight selection on yank",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end,
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end
  end,
})

-- No auto highlight continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.api.nvim_create_user_command("InstallAllLocal", function()
  vim.cmd(
    "MasonInstall bash-language-server bashls delve docker-language-server docker_language_server eslint eslint-lsp go-debug-adapter gofumpt goimports golangci-lint gopls gotests harper_ls iferr json-lsp jsonls lua-language-server lua_ls markdownlint marksman prettier prettierd sqlfluff sqlls stylua ts_ls typescript-language-server yaml-language-server yamlls"
  )
  vim.cmd("TSInstallAll")
end, {})

-- format and organize imports in go
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})

_G.Utils = require("utils")

-- config Lazy
require("config.lazy")
require("config.keymaps")

if vim.g.vscode then
  require("config.keymaps-vscode")
else
  require("config.keymaps-nvim")
end
