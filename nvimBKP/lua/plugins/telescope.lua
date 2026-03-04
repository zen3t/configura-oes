return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim',
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                    ".git/",
                    "__pycache__",
                    "venv",
                    ".venv",
                    "dist",
                    "build",
                },
            },
        })
        pcall(require('telescope').load_extension, 'fzf')
    end,
}
