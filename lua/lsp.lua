-- Remove Global Default Key mapping
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gO")

-- Create keymapping
-- LspAttach: After an LSP Client performs "initialize" and attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp-attaach', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local keymap = vim.keymap
        local lsp = vim.lsp
        -- local bufopts = { noremap = true, silent = true }

        keymap.set("n", "gd", lsp.buf.definition, { buffer = event.buf, desc = 'LSP: Goto Definition' })
        keymap.set("n", "gD", lsp.buf.declaration, { buffer = event.buf, desc = 'LSP: Goto Declaration' })
        keymap.set("n", "<leader>lr", lsp.buf.rename, { buffer = event.buf, desc = 'LSP: Remane Argument' })
        keymap.set("n", "K", lsp.buf.hover, { buffer = event.buf, desc = "LSP:Check Argumen" })
        keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
        end, { buffer = event.buf, desc = 'LSP: Code formatting' })

        vim.diagnostic.config {
            virtual_text = true,
        }

        --- <C-W><C-D>: show diagnostic float window
        keymap.set("n", "<leader>ld", function()
            vim.diagnostic.open_float { source = true }
        end, { buffer = event.buf, desc = 'LSP: Show Diagnostic' })
    end,
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('pylsp')
vim.lsp.enable('taplo')
vim.lsp.enable('clangd')
vim.lsp.enable('ts_ls')
vim.lsp.enable('cssls')
