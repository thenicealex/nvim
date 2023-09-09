local module = {
	"options",
	"mappings",
	"autocmds",
	"lazy",
}
for _, source in ipairs(module) do
	local status_ok, fault = pcall(require, "core." .. source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
	end
end

-- load neovide config
if require("core.config").neovide then
	require("core.neovide")
end
require("tabufline.lazyload")
