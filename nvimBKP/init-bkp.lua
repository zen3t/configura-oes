-- Quais funcoes colocar a mais para poder usar o telescope nessa configuracao
-- 🧠 Configuração SIMPLIFICADA do Neovim
-----------------------------------------------------------

-- 🧩 Opções básicas
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true

-- 🎯 Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-----------------------------------------------------------
-- 📦 Gerenciador de plugins: Lazy.nvim
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Tema e UI
  { "Mofiqul/dracula.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "preservim/nerdtree" },
  
  -- Ferramentas essenciais
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "windwp/nvim-autopairs" },
  { "numToStr/Comment.nvim" },
  { "lewis6991/gitsigns.nvim" },
  
  -- Treesitter (sintaxe)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})

-----------------------------------------------------------
-- 🎨 Tema
-----------------------------------------------------------
vim.cmd("colorscheme dracula")

-----------------------------------------------------------
-- 🧰 Configurações básicas
-----------------------------------------------------------
require("lualine").setup({
  options = {
    theme = "dracula",
    section_separators = "",
    component_separators = "|"
  }
})

require("nvim-autopairs").setup({})
require("Comment").setup()
require("gitsigns").setup()

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "cpp", "bash", "python" },
  highlight = { enable = true },
})

-----------------------------------------------------------
-- 🔭 Telescope
-----------------------------------------------------------
local telescope = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Buscar Arquivos' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Buscar Texto' })

-----------------------------------------------------------
-- 🧰 Atalhos gerais
-----------------------------------------------------------
vim.keymap.set('n', '<leader>t', ':terminal<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Atalhos de execução
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set('n', '<F5>', ':w<CR>:terminal python %<CR>', { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.keymap.set('n', '<F5>', ':w<CR>:terminal g++ -std=c++11 % -o %:r && ./%:r<CR>', { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.keymap.set('n', '<F5>', ':w<CR>:terminal bash %<CR>', { buffer = true })
  end,
})
