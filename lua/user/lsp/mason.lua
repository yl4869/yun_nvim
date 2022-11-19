local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not lspconfig_status_ok then
	return
end

mason.setup()
mason_lspconfig.setup({
	automatic_installation = true,
	ensure_installed = {
		"cmake",
		"rust_analyzer",
		"marksman",
		"clangd",
		"sumneko_lua",
		"cssls",
		"html",
		"tsserver",
		"pyright",
		"bashls",
		"jsonls",
		"yamlls",
		"svls",
		"svlangserver",
	},
})

mason_lspconfig.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			on_attach = require("user.lsp.handlers").on_attach(),
      capabilities = require("user.lsp.handlers").capabilities
		})
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	["rust_analyzer"] = function()
		require("user.lsp.settings.rust")
	end,
})
