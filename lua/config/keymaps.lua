local g = vim.g
local Set = vim.api.nvim_set_keymap
local Noremap = { noremap = true, silent = true }

function OpenDebugger()
  vim.fn.system('code .')
end
Set("n", "<F5>", ":DebugProject<CR>", Noremap)
vim.api.nvim_create_user_command('DebugProject', OpenDebugger, {})

Set("v", "Y", "\"+y", Noremap)
Set("v", "P", "\"_dP", Noremap)
Set("n", "<space>p", "viwP", Noremap)
Set("n", "JJ", "mzJ'z", Noremap)
Set("n", "<C-p>", "<C-i>", Noremap)
Set("n", "<space><tab>", "za", Noremap)

Set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", Noremap)

-- Create Lines
Set("n", "op", "o<Esc>k<CR>", Noremap)
Set("n", "oi", "O<Esc>j", Noremap)
Set("n", "oo", "A<CR>", Noremap)

-- Navegate Splites
Set("n", "<C-h>", "<C-w>h", Noremap)
Set("n", "<C-j>", "<C-w>j", Noremap)
Set("n", "<C-k>", "<C-w>k", Noremap)
Set("n", "<C-l>", "<C-w>l", Noremap)
Set("n", "<tab>", "<C-w>r", Noremap)

-- Add " in Word / Line
Set('n', '<space>w"', 'viw<ESC>a"<esc>bi"<esc>', Noremap)
Set("n", "<space>w'", "viw<ESC>a'<esc>bi'<esc>", Noremap)

-- Add ' in Word / Line
Set('n', '<space>l"', 'V<ESC>A"<esc>I"<esc>', Noremap)
Set("n", "<space>l'", "V<ESC>A'<esc>I'<esc>", Noremap)

-- LSP Diagnostic
Set('n', '<Esc>', ":lclose<CR>", Noremap)