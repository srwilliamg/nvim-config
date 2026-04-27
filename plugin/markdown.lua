vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    require("lazyload").on_vim_enter(function()
      vim.pack.add({
        { src = Utils.github("OXY2DEV/markview.nvim"), name = "markview" },
        { src = Utils.github("brianhuster/live-preview.nvim"), name = "live-preview" },
        Utils.github("folke/snacks.nvim"),
        Utils.github("saghen/blink.cmp"),
      })
      require("markview").setup()
      require("markview").setup()
      vim.keymap.set("n", "<leader>mls", function()
        vim.cmd("LivePreview start")
      end, { desc = "Live preview Start" })
      vim.keymap.set("n", "<leader>mlc", function()
        vim.cmd("LivePreview close")
      end, { desc = "Live preview Close" })
      vim.keymap.set("n", "<leader>mlp", function()
        vim.cmd("LivePreview pick")
      end, { desc = "Live preview Pick" })
      vim.keymap.set("n", "<leader>mst", function()
        vim.cmd("Marview splitToggle")
      end, { desc = "split toggle" })
      vim.keymap.set("n", "<leader>mht", function()
        vim.cmd("Marview hybridToggle")
      end, { desc = "hybrid toggle" })
      vim.keymap.set("n", "<leader>mt", function()
        vim.cmd("Marview Toggle")
      end, { desc = "Toggle" })
    end)
  end,
})
