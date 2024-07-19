return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  opts = function()
    local workspaces = {}
    if vim.has("win32") == 1 then
      workspaces = {
        {
          name = "personal",
          path = "C:\\Users\\johannes.kirchner\\iCloudDrive\\iCloud~md~obsidian\\Obsidian",
        },
      }
    end
    return {
      workspaces = workspaces,
    }
  end,
}
