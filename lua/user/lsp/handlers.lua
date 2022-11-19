local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" }, { name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false, -- disable virtual text
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
	local keymap = vim.keymap.set
	keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
	keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
	keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
	keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
	keymap("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
	keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format { async = true }<cr>", bufopts)
	keymap("n", "<leader>li", "<cmd>LspInfo<cr>", bufopts)
	keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", bufopts)
	keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", bufopts)
	keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", bufopts)
	keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", bufopts)
	keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", bufopts)
	keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", bufopts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
  		return
	end
	illuminate.on_attach(client)
end

return M
