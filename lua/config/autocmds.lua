
vim.cmd([[
    hi Floaterm guibg=NONE
    hi FloatermBorder guibg=#202020 guifg=white
]])

vim.api.nvim_create_autocmd("InsertCharPre", {
    pattern = "*",
    callback = function()
        local char = vim.v.char
        if char == ":" then
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            -- verifica se o caractere anterior também é :
            if col > 0 and line:sub(col, col) == ":" then
                vim.schedule(function()
                    require("cmp").complete()
                end)
            end
        end
    end,
})

vim.cmd([[
    function! AirlineClock()
        return strftime("%H:%M")
    endfunction

    let g:airline_section_z = airline#section#create_right([
        \ '%l/%L:%c, %p%%',
        \ '%{AirlineClock()}'
        \ ])
]])

if vim.fn.has("timers") == 1 then
    vim.fn.timer_start(1000, function()
        vim.cmd("redrawstatus")
    end, { ["repeat"] = -1 })
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
            if client:supports_method("textDocument/formatting") then
                vim.lsp.buf.format({
                    bufnr = bufnr,
                    async = false,
                })
                break
            end
        end
    end,
})

vim.api.nvim_create_augroup("RestoreCursorPositionWhenOpeningFile", {
    clear = true,
})
vim.api.nvim_create_autocmd("BufReadPost", {
    group = "RestoreCursorPositionWhenOpeningFile",
    callback = function()
        local last_pos = vim.fn.line([['"]])
        local last_line = vim.fn.line("$")

        if last_pos > 1 and last_pos <= last_line then
            vim.cmd([[normal! g`"]])
        end
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
        vim.cmd("wincmd =")
    end,
})