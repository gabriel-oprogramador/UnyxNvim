local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        'ryanoasis/vim-devicons',
        'nvim-tree/nvim-web-devicons',
        init = function()
            require("plugins.devicons")
        end,
    },
    {
        "voldikss/vim-floaterm",
        init = function()
            require("plugins.floaterm")
        end,
    },
    {
        'vim-airline/vim-airline',
        dependencies = {
            'vim-airline/vim-airline-themes',
        },
        init = function()
            require("plugins.airline")
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup()
        end,
    },
    {
        'preservim/nerdcommenter',
        init = function()
            require("plugins.NerdCommenter")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function()
            require("plugins.Telescope")
        end,
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
    },
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "onsails/lspkind.nvim",
    "tpope/vim-fugitive",
})