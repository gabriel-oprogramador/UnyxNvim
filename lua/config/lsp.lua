require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "lua_ls",
        "glsl_analyzer",
    },
})

local lsp = vim.lsp

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
})

local orig_open_floating_preview = lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    opts.focusable = opts.focusable or false
    return orig_open_floating_preview(contents, syntax, opts, ...)
end


--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)

    local opts = {
        buffer = bufnr,
        remap = false,
    }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.hover, opts)
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)

    vim.keymap.set("n", "<space>w", function()
        vim.diagnostic.jump({
            count = -1,
            float = true,
        })
    end, opts)

    vim.keymap.set("n", "<space>s", function()
        vim.diagnostic.jump({
            count = 1,
            float = true,
        })
    end, opts)

    vim.keymap.set("n", "<space>l", vim.diagnostic.setloclist, opts)

    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({
            async = true,
        })
    end, opts)

end

local lspkind = require("lspkind")
local cmp = require("cmp")
cmp.setup({
    completion = {
        autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
        },
        keyword_length = 1,
        completeopt = "menu,menuone,noinsert,noselect",
    },

    performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 500,
        max_view_entries = 200,
        confirm_resolve_timeout = 80,
    },

    matching = {
        disallow_fuzzy_matching = false,
        disallow_fullfuzzy_matching = false,
        disallow_partial_fuzzy_matching = false,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = false,
    },

    window = {
        completion = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu",
            border = "rounded",
            max_width = 81,
            max_height = 20,
        }),

        documentation = cmp.config.window.bordered({
            winhighlight = "Normal:NormalFloat,FloatBorder:NormalFloat",
            border = "rounded",
            max_width = 81,
            max_height = 20,
        }),
    },

    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            maxheight = 25,
            ellipsis_char = "…",
            show_labelDetails = true,
        }),
    },

    mapping = {
        ["<C-f>"] = cmp.mapping.complete(),
        ["<Esc>"] = cmp.mapping.abort(),
        ["<C-q>"] = cmp.mapping.select_prev_item(),
        ["<C-e>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
        }),
    },

    sources = cmp.config.sources({
        {
            name = "nvim_lsp",
            priority = 1000,
        },
        {
            name = "path",
            priority = 500,
        },
        {
            name = "buffer",
            priority = 250,
        },
    })
})

vim.lsp.config("clangd", {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
        "clangd",
        "--clang-tidy",
        "--header-insertion=never",
        "--background-index=false",
        "--completion-style=detailed",
    },

    root_markers = {
        "compile_commands.json",
        "compile_flags.txt",
        "CMakeLists.txt",
        "Makefile",
        ".git",
    },
})

vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.config("jdtls", {
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.config("glsl_analyzer", {
    on_attach = on_attach,
    capabilities = capabilities,
})

vim.lsp.enable({
    "clangd",
    "jdtls",
    "lua_ls",
    "glsl_analyzer",
})