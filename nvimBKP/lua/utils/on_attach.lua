return function(_, bufnr)
    local map = vim.keymap.set
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
end

