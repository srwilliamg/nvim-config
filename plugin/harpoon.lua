local desc = Utils.plugin_keymap_desc("harpoon")

require("lazyload").on_vim_enter(function()
  vim.pack.add({
    Utils.github("nvim-lua/plenary.nvim"),
    { src = Utils.github("ThePrimeagen/harpoon"), branch = "harpoon2" },
  })

  local harpoon = require("harpoon")
  harpoon:setup({ settings = { save_on_toggle = true, sync_on_ui_close = true } })

  harpoon:extend({
    UI_CREATE = function(cx)
      vim.keymap.set("n", "<C-v>", function()
        harpoon.ui:select_menu_item({ vsplit = true })
      end, { desc = desc("Open as vertical split"), buffer = cx.bufnr })
      vim.keymap.set("n", "<C-x>", function()
        harpoon.ui:select_menu_item({ split = true })
      end, { desc = desc("Open as split"), buffer = cx.bufnr })
    end,
  })

  vim.keymap.set("n", "<leader>hh", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = desc("Open menu") })
  vim.keymap.set("n", "<leader>ha", function()
    harpoon:list():add()
  end, { desc = desc("Add to list") })
  vim.keymap.set("n", "<S-h>", function()
    harpoon:list():prev()
  end, { desc = desc("Previous file") })
  vim.keymap.set("n", "<S-l>", function()
    harpoon:list():next()
  end, { desc = desc("Next file") })

  for i = 1, 9 do
    vim.keymap.set("n", "<leader>h" .. i, function()
      harpoon:list():select(i)
    end, { desc = desc("Select file " .. i) })
  end
end)
