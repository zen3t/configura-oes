-- lua/plugins/lsp.lua
return {
    "neovim/nvim-lspconfig", -- Ainda necessário para cmd/infos dos servers
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- Configurações nativas do Neovim 0.11+
        vim.lsp.config("ruff", {
            on_attach = function(client, bufnr)
                client.server_capabilities.hoverProvider = false
            end,
        })

        vim.lsp.config("pyright", {})
        
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
        })

        vim.lsp.config("html", {})
        vim.lsp.config("cssls", {})
        
        -- NOTA: tsserver foi renomeado para ts_ls!
        vim.lsp.config("ts_ls", {})

        -- Habilitar os servers
        vim.lsp.enable({ "ruff", "pyright", "lua_ls", "html", "cssls", "ts_ls" })
    end,
}
