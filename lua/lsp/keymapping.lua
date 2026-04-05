vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local keymap = vim.keymap
        local lsp = vim.lsp

        keymap.set("n", "gd", lsp.buf.definition, { buffer = event.buf, desc = "LSP: Goto Definition" })
        keymap.set("n", "gD", lsp.buf.declaration, { buffer = event.buf, desc = "LSP: Goto Declaration" })
        keymap.set("n", "<leader>lr", lsp.buf.rename, { buffer = event.buf, desc = "LSP: Rename" })
        keymap.set("n", "K", lsp.buf.hover, { buffer = event.buf, desc = "LSP: Hover" })
        keymap.set("n", "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
        end, { buffer = event.buf, desc = "LSP: Format" })
        keymap.set("n", "<leader>ld", function()
            vim.diagnostic.open_float({ source = true })
        end, { buffer = event.buf, desc = "LSP: Show Diagnostic" })

        keymap.set("n", "<leader>la", function()
            require("lspsaga.codeaction"):code_action()
        end, { buffer = event.buf, desc = "Saga: Code Action" })
        keymap.set("n", "gr", function()
            require("lspsaga.rename"):rename()
        end, { buffer = event.buf, desc = "Saga: Rename" })
        keymap.set("n", "gp", function()
            require("lspsaga.definition"):peek_definition()
        end, { buffer = event.buf, desc = "Saga: Peek Definition" })
        keymap.set("n", "[e", function()
            require("lspsaga.diagnostic"):goto_prev()
        end, { buffer = event.buf, desc = "Saga: Goto Prev" })
        keymap.set("n", "]e", function()
            require("lspsaga.diagnostic"):goto_next()
        end, { buffer = event.buf, desc = "Saga: Goto Next" })

        -- [folding]
        if client and client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})
