-- [[
-- harpoon
-- Getting you where you want with the fewest keystrokes.
-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
-- ]]

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  lazy = false,
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Add File to Harpoon list" })
    vim.keymap.set("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle Harpoon Quick Menu" })

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
      vim.keymap.set("n", string.format("<leader>%d", idx), function()
        harpoon:list():select(idx)
      end, { desc = "Harpoon to File " .. idx })
    end
  end,
}
