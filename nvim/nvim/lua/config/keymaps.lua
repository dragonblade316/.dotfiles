-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "\\", function()
  Snacks.explorer({ cwd = LazyVim.root() })
end, { desc = "Toggle File Explorer" })

vim.keymap.set("n", "<leader>t", "<cmd>Trouble diagnostics open<cr>", { desc = "Trouble Diagnostics" })
vim.keymap.set({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, { desc = "Code Action" })
