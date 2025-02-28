vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true

-- Definir <space> como leader key (igual ao Kickstart)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Plugin Manager (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "prettier/vim-prettier", build = "npm install --frozen-lockfile --production" },
  { "tpope/vim-fugitive" },
  { "Mofiqul/dracula.nvim" },
  { "aca/emmet-ls" },
  { "windwp/nvim-autopairs" },
  { "preservim/nerdtree" },
  -- Novos plugins adicionados
  { "lewis6991/gitsigns.nvim" },          -- Integração com Git (sinais na gutter)
  { "nvim-lualine/lualine.nvim" },        -- Barra de status
  { "numToStr/Comment.nvim" },            -- Comentários fáceis
})

-- Configuração do Tema Dracula
vim.cmd("colorscheme dracula")

-- Configuração robusta de LSP (inspirada no Kickstart)
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, 'LSP: Rename')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'LSP: Code Action')
  nmap('gd', vim.lsp.buf.definition, 'LSP: Goto Definition')
  nmap('gr', vim.lsp.buf.references, 'LSP: Goto References')
  nmap('K', vim.lsp.buf.hover, 'LSP: Hover Documentation')

  -- Comando para formatar o buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configuração dos servidores LSP
local servers = {
  ts_ls = {},
  html = {},
  cssls = {},
  jsonls = {},
  eslint = {},
  emmet_ls = {},
  pyright = {},
}
for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_extend("force", {
    capabilities = capabilities,
    on_attach = on_attach,
  }, config))
end

-- Configuração do Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(servers),
})

-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "javascript", "typescript", "html", "css", "json", "lua", "python" },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Autoformat com Prettier
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.js,*.ts,*.jsx,*.tsx,*.json,*.html,*.css,*.py",
  callback = function()
    vim.cmd("Prettier")
  end,
})

-- Autocompletar
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- Fechamento automático de aspas e parênteses
require("nvim-autopairs").setup({})

-- NERDTree
vim.api.nvim_set_keymap("n", "<leader>n", ":NERDTreeToggle<CR>", { noremap = true, silent = true })

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':!node %<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':tabnew<Space>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<Tab>', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':tabprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Configuração do Gitsigns (sinais Git na gutter)
require("gitsigns").setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navegação entre hunks
    map('n', ']c', gs.next_hunk, { desc = 'Next Git hunk' })
    map('n', '[c', gs.prev_hunk, { desc = 'Previous Git hunk' })
    -- Ações
    map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage Git hunk' })
    map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset Git hunk' })
    map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage Git buffer' })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
  end,
})

-- Configuração da Lualine (barra de status)
require("lualine").setup({
  options = {
    theme = 'dracula', -- Integra com seu tema Dracula
    section_separators = '',
    component_separators = '|',
  },
})

-- Configuração do Comment.nvim (comentários fáceis)
require("Comment").setup({
  toggler = {
    line = 'gcc',  -- Comentar/descomentar linha
    block = 'gbc', -- Comentar/descomentar bloco
  },
  opleader = {
    line = 'gc',
    block = 'gb',
  },
})
