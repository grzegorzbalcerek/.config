
vim.opt.compatible = false

vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.hidden = false
vim.opt.swapfile = false

vim.opt.guicursor = "a:block"
vim.opt.mouse = "a"
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.wildmenu = true

vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.keymap.set("", "gg", ":nohlsearch<CR>")

vim.opt.path = {
  ".",
  "~/.config/**",
  "~/lib",
  "~/doc/**",
  "~/rep/rbsapp/**",
  ""
}

