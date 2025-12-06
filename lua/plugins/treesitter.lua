return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = not vim.g.vscode,
    -- enabled = false,
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      folds = { enable = true },
      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
      ensure_installed = {
        "vim",
        "vimdoc",
        "c",
        "lua",
        "javascript",
        "query",
        "markdown",
        "markdown_inline",
        "bash",
        "html",
        "json",
        "lua",
        "go",
        "gomod",
        "markdown",
        "markdown_inline",
        "query",
        "typescript",
        "vim",
        "yaml",
        "comment",
        "diff",
        "todotxt",
        "xml",
      },
      sync_install = true,
      auto_install = true,
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- {
  --   -- config not working yet
  --   enable = false,
  --   "nvim-treesitter/nvim-treesitter",
  --   branch = "main",
  --   build = ":TSUpdate",
  --   dependencies = {
  --     {
  --       "nvim-treesitter/nvim-treesitter-textobjects",
  --       branch = "main",
  --     },
  --   },
  --   opts = {
  --     indent = { enable = true },
  --     highlight = { enable = true },
  --     folds = { enable = true },
  --     -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  --     ensure_installed = {
  --       "c",
  --       "lua",
  --       "vim",
  --       "vimdoc",
  --       "query",
  --       "markdown",
  --       "markdown_inline",
  --       "bash",
  --       "html",
  --       "javascript",
  --       "json",
  --       "lua",
  --       "go",
  --       "gomod",
  --       "markdown",
  --       "markdown_inline",
  --       "query",
  --       "typescript",
  --       "vim",
  --       "yaml",
  --       "comment",
  --       "diff",
  --       "todotxt",
  --       "vhdl",
  --       "xml",
  --     },
  --     sync_install = true,
  --     auto_install = true,
  --   },
  --   config = function(_, opts)
  --     require("nvim-treesitter").install(opts.ensure_installed)
  --     require("nvim-treesitter-textobjects").setup({
  --       select = {
  --         lookahead = true,
  --       },
  --     })
  --     local function map(lhs, obj)
  --       vim.keymap.set({ "x", "o" }, lhs, function()
  --         require("nvim-treesitter-textobjects.select").select_textobject(obj, "textobjects")
  --       end)
  --     end
  --
  --     map("af", "@function.outer")
  --     map("if", "@function.inner")
  --     map("ac", "@class.inner")
  --     map("ic", "@class.inner")
  --     map("ar", "@parameter.inner")
  --     map("ir", "@parameter.inner")
  --     map("ak", "@block.inner")
  --     map("ik", "@block.inner")
  --     -- Register the todotxt parser to be used for text filetypes
  --     vim.treesitter.language.register("todotxt", "text")
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       callback = function(ev)
  --         if pcall(vim.treesitter.start) then
  --           -- Set indentexpr for queries that have an indents.scm, check in
  --           -- ~/.local/share/nvim/site/queries/QUERY/
  --           -- Hopefully this will happen automatically in the future
  --           if
  --             ({
  --               go = true,
  --               gomod = true,
  --               typescript = true,
  --               c = true,
  --               lua = true,
  --               markdown = true,
  --               query = true,
  --               xml = true,
  --             })[ev.match]
  --           then
  --             vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  --           end
  --
  --           -- vim.treesitter.start()
  --           -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  --           -- vim.wo.foldmethod = "expr"
  --         end
  --       end,
  --     })
  --   end,
  -- },
}
