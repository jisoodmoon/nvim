-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.cmd("set number relativenumber")

vim.o.cursorline = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.cmd("set noswapfile")

if vim.g.neovide then
  vim.g.neovide_scale_factor = 0.75
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_window_blurred = true
  vim.g.neovide_cursor_vfx_mode = "torpedo"

  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1/1.25)
  end)
end

-- Addresses issue where tab in insert mode 
-- jumps to a snippet that's not yet left.
-- This leaves snipped when going back to normal
-- mode.
function leave_snippet()
  if
    ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
    and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
    and not require('luasnip').session.jump_active
  then
    require('luasnip').unlink_current()
  end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_command([[
  autocmd ModeChanged * lua leave_snippet()
]])
