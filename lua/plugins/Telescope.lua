require('telescope').setup {
    sorting_strategy = "ascending",
    layout_config = {},
    defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.90,
            height = 0.85,
            prompt_position = "top",
            preview_width = 0.50,
        },
        file_ignore_patterns = {
            "%.git",
            "%.cache",
            "%.png",
            "%.jpg",
            "%.jpeg",
            "%.exe",
            "%.o",
            "%.d",
        },
    },
}

vim.keymap.set("n", "<space>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<space>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<space>fb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<space>fh", "<cmd>Telescope help_tags<CR>")