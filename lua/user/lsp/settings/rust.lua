local rt = require("rust-tools")

rt.setup({
    tools = { -- rust-tools options
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

	server = {
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<Leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>p", rt.parent_module.parent_module, { buffer = bufnr })
            vim.keymap.set("n", "<Leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", { buffer = bufnr })
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = bufnr })
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = bufnr })
            vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr })
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = bufnr })
            vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer = bufnr })
            vim.keymap.set("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr })
            vim.keymap.set("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { buffer = bufnr })

		end,
	},
})
