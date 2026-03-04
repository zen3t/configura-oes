-- init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.options")
require("core.keymaps")   -- <--- garante que o arquivo acima será carregado
require("plugins")

