local desc = Utils.plugin_keymap_desc("Markdown")
return {
  {
    enabled = false,
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "saghen/blink.cmp" },
    keys = {
      {
        "<leader>mst",
        function()
          vim.cmd("Marview splitToggle")
        end,
        desc = desc("split toggle"),
      },
      {
        "<leader>mht",
        function()
          vim.cmd("Marview hybridToggle")
        end,
        desc = desc("hybrid toggle"),
      },
      {
        "<leader>mt",
        function()
          vim.cmd("Marview Toggle")
        end,
        desc = desc("Toggle"),
      },
    },
  },
  {
    "brianhuster/live-preview.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    keys = {
      {
        "<leader>mls",
        function()
          vim.cmd("LivePreview start")
        end,
        desc = desc("Live preview Start"),
      },
      {
        "<leader>mlc",
        function()
          vim.cmd("LivePreview close")
        end,
        desc = desc("Live preview Close"),
      },
      {
        "<leader>mlp",
        function()
          vim.cmd("LivePreview pick")
        end,
        desc = desc("Live preview Pick"),
      },
    },
  },
}
