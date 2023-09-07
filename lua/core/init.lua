local module = {
	"options",
	"mappings",
	"autocmds",
}
for _, v in ipairs(module) do
	require("core." .. v)
end

-- load neovide config
if require("core.config").neovide then
	require("core.neovide")
end

local plugins_ok, _ = pcall(require, "core.lazy")
if not plugins_ok then
	return
end
require("tabufline.lazyload")
