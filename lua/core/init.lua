local load = function(name)
  package.loaded[name] = nil
  require(name)
end
local module = {
	"options",
	"mappings",
	"autocmds",
	"neovide",
}
for _, v in ipairs(module) do
	require("core." .. v)
	-- load("core." .. v)
end

local plugins_ok, _ = pcall(require, "core.lazy")
if not plugins_ok then
	return
end
require("tabufline.lazyload")
