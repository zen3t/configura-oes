require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright",
        "ruff",
        "lua_ls",
        "pyright",
        "html",
        "cssls",

    }
})

