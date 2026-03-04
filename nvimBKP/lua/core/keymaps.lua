-- lua/core/keymaps.lua
-- Atalhos personalizados

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- ==========================================
-- GERAL
-- ==========================================
-- Salvar com Ctrl+S
keymap({ "i", "n" }, "<C-s>", "<cmd>w<CR>", opts)

-- Sair com Ctrl+Q
keymap("n", "<C-q>", "<cmd>q<CR>", opts)

-- Desfazer no insert mode
keymap("i", "<C-z>", "<C-o>u", opts)

-- ==========================================
    -- NAVEGAÇÃO
-- ==========================================
-- Mover entre janelas
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Redimensionar janelas
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- ==========================================
-- EDIÇÃO
-- ==========================================
-- Indentar no modo visual
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Mover linhas no modo visual
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Copiar para clipboard do sistema
keymap({ "n", "v" }, "<leader>y", '"+y', opts)
keymap("n", "<leader>Y", '"+Y', opts)

-- Colar do clipboard sem perder o registro
keymap("v", "<leader>p", '"_dP', opts)

-- ==========================================
-- TELESCOPE (busca)
-- ==========================================
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- ==========================================
-- LSP
-- ==========================================
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap("n", "<leader>f", vim.lsp.buf.format, { desc = "Format code" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- ==========================================
-- CODE RUNNER (executar código)
-- ==========================================
keymap("n", "<leader>r", ":RunCode<CR>", { desc = "Run code" })
keymap("n", "<leader>rf", ":RunFile<CR>", { desc = "Run file" })
keymap("n", "<leader>rft", ":RunFile tab<CR>", { desc = "Run file in tab" })
keymap("n", "<leader>rp", ":RunProject<CR>", { desc = "Run project" })
keymap("n", "<leader>rc", ":RunClose<CR>", { desc = "Close runner" })
