require("config.plugins")
require("config.lsp")
require("config.options")
require("config.keymaps")
require("config.autocmds")

local theme_name = "visual_assist"
require("themes").load(theme_name)
--require("themes").watch(theme_name)