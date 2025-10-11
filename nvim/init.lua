
vim.opt.compatible = false

vim.cmd.colorscheme("industry")
vim.opt.encoding = "utf-8"
vim.opt.hidden = false
vim.opt.swapfile = false
vim.opt.cursorline = true

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
vim.keymap.set("", "g/", ":nohlsearch<CR>")

vim.opt.expandtab = true
vim.opt.smarttab = false
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.textwidth = 100

vim.opt.path = { "." }
vim.opt.path:append(vim.env.HOME .. "/.config/**")
vim.opt.path:append(vim.env.HOME .. "/lib")
vim.opt.path:append(vim.env.HOME .. "/doc/**")
vim.opt.path:append(vim.env.HOME .. "/rep/rbs/**")
vim.opt.path:append(",,")

