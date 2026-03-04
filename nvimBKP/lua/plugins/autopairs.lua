local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

npairs.setup({
    check_ts = true, -- usa treesitter
    ts_config = {
        lua = {'string'},
        javascript = {'template_string'},
        java = false,
    }
})

-- Se você quiser adicionar regras específicas, pode fazê-lo aqui.
-- Mas a configuração básica já deve funcionar.

-- Integração com nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)
