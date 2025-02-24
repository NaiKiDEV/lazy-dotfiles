-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Custom Config
local bind = vim.keymap.set

-- Convenience aliases
local NORMAL_MODE = "n"
local VISUAL_MODE = "v"
local TERMINAL_MODE = "x"
local INSERT_MODE = "i"

local function get_visual_selection()
  local original_register = vim.fn.getreg('"')
  local original_register_type = vim.fn.getregtype('"')

  vim.cmd("normal! y")

  local selection = vim.fn.getreg('"')

  vim.fn.setreg('"', original_register, original_register_type)

  return selection
end

bind(NORMAL_MODE, "<leader>o", "<cmd>Oil<cr>", { desc = "Open Oil file explorer" })

local common_excludes = {
  "node_modules/*",
  "build/*",
  "dist/*",
  "*/package-lock.json",
  "*/yarn.lock",
  "*/pnpm.lock",
}

bind(NORMAL_MODE, "<c-p>", function()
  Snacks.picker.files({
    exclude = common_excludes,
  })
end, { desc = "Find in files" })

bind(NORMAL_MODE, "<c-f>", function()
  Snacks.picker.grep({
    exclude = common_excludes,
  })
end, { desc = "Find in files" })

-- Prefill text from current selection to grep search
bind(VISUAL_MODE, "<c-f>", function()
  local current_selection = get_visual_selection()
  Snacks.picker.grep({
    search = current_selection,
    exclude = common_excludes,
  })
end, { desc = "Find in files (pre-filled)" })
