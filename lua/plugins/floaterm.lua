local g = vim.g

g.floaterm_width = 120
if vim.uv.os_uname().sysname == "Windows_NT" then
    if vim.fn.executable("pwsh") == 1 then
        g.floaterm_shell = "pwsh"
    else
        g.floaterm_shell = "powershell"
    end
end

g.floaterm_keymap_new = '<space>ft'
g.floaterm_keymap_prev = '<space>fp'
g.floaterm_keymap_next = '<space>fn'
g.floaterm_keymap_kill = '<space>fk'
g.floaterm_keymap_toggle = '<C-t>'
g.floaterm_wintype = 'float'
g.floaterm_titleposition = 'center'
g.floaterm_position = 'right'

vim.keymap.set("t", "<Esc>", "<C-\\><C-n><cmd>FloatermToggle<CR>")