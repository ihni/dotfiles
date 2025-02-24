key = vim.keymap

-- for oil / file explorer
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
key.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" }) -- open parent dir
