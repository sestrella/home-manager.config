-- INFO: Sync background with system appearance (only works on macOS)
local handle = io.popen("defaults read -g AppleInterfaceStyle 2> /dev/null", "r")
local result = handle:read("*a")
handle:close()

if result == "Dark\n" then
  vim.o.background = "dark"
else
  vim.o.background = "light"
end

vim.cmd("colorscheme NeoSolarized")
