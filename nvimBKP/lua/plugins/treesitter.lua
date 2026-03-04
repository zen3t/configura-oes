-- lua/plugins/treesitter.lua
-- Configuração do Treesitter

require("nvim-treesitter").setup({
    -- Instalar parsers automaticamente
    auto_install = true,
    
    -- Parsers garantidos (instalados via :TSInstall)
    ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "python",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "markdown",
        "bash",
    },
    
    -- Highlight
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    
    -- Indentação baseada em treesitter
    indent = {
        enable = true,
    },
    
    -- Incremental selection (expandir seleção)
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<M-space>",
        },
    },
    
    -- Text objects (requer nvim-treesitter-textobjects, opcional)
    textobjects = {
        select = {
            enable = false, -- mude para true se instalar textobjects
        },
    },
})
