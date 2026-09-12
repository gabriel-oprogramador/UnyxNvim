--local M = {}
--
--function M.load(name)
--    local config = require("themes." .. name)
--
--    require("gruvbox").setup(config)
--    vim.cmd.colorscheme("gruvbox")
--end
--
--vim.api.nvim_create_user_command("Theme", function(opts)
--    M.load(opts.args)
--end, {
--    nargs = 1,
--})
--
--return M

local M = {}
function M.load(name)
    local config = require("themes." .. name)
    require("gruvbox").setup(config)
    vim.cmd.colorscheme("gruvbox")
end

function M.watch(name)
    local theme_file = vim.fn.stdpath("config") .. "/lua/themes/" .. name .. ".lua"
    local stat = vim.uv.fs_stat(theme_file)
    local last_mtime = stat and stat.mtime.sec or 0
    local timer = vim.uv.new_timer()
    timer:start(1000, 1000, vim.schedule_wrap(function()
        local stat = vim.uv.fs_stat(theme_file)
        if stat and stat.mtime.sec ~= last_mtime then
            last_mtime = stat.mtime.sec
            package.loaded["themes." .. name] = nil
            M.load(name)
            vim.notify("Theme recarregado!", vim.log.levels.INFO)
        end
    end))
    vim.api.nvim_create_autocmd("VimLeavePre", { callback = function()
        timer:stop()
        timer:close()
    end, })
end

vim.api.nvim_create_user_command("Theme", function(opts)
    M.load(opts.args)
end, { nargs = 1, })
return M
