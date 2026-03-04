-- lua/plugins/cmp.lua
-- Autocomplete configuration com sugestões de palavras

local cmp = require("cmp")
local luasnip = require("luasnip")

-- Carrega snippets amigáveis
require("luasnip.loaders.from_vscode").lazy_load()

-- Verifica se tem palavra antes do cursor (para sugestões inteligentes)
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    
    window = {
        completion = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
    },
    
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        
        -- Tab inteligente: snippet → sugestão → indentação
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    
    -- ==========================================
    -- SOURCES: De onde vêm as sugestões
    -- ==========================================
    sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },     -- LSP (mais importante)
        { name = "luasnip", priority = 750 },       -- Snippets
    }, {
        { name = "buffer", priority = 500, keyword_length = 3 },  -- ✅ Palavras do buffer
        { name = "path", priority = 250 },          -- ✅ Caminhos de arquivo
    }),
    
    -- ==========================================
    -- FORMATAÇÃO COM ÍCONES
    -- ==========================================
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind_icons = {
                Text = " ",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
            }
            
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Texto]",
                path = "[Arquivo]",
            })[entry.source.name]
            
            return vim_item
        end,
    },
    
    -- Comportamento
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    experimental = {
        ghost_text = true, -- Mostra texto fantasma da sugestão
    },
})

-- Busca com autocomplete (/ e ?)
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

-- Comandos com autocomplete (:)
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
})
