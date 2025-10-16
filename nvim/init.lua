
vim.opt.compatible = false

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.foldmethod="marker"
vim.opt.guicursor = "a:block"
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.path = { ".", vim.env.HOME .. "/.config/**", vim.env.HOME .. "/lib", vim.env.HOME .. "/doc/**", vim.env.HOME .. "/rep/rbs/**", "" }
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.shiftwidth = 4
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.smartcase = true
vim.opt.smarttab = false
vim.opt.softtabstop = -1
vim.opt.swapfile = false
vim.opt.textwidth = 0
vim.opt.wildmenu = true

vim.cmd.colorscheme("industry")
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.g.mapleader = " "

vim.keymap.set("", "<leader>h", ":set hlsearch!<CR>")
vim.keymap.set("", "<leader>s", ":write<CR>")
vim.keymap.set("", "<leader>w", ":set wrap!<CR>")

vim.keymap.set("", "<C-M-Left>", ":bprev<CR>")
vim.keymap.set("", "<C-M-Right>", ":bnext<CR>")

vim.keymap.set("", "<C-Left>", "<C-W>h")
vim.keymap.set("", "<C-Down>", "<C-W>j")
vim.keymap.set("", "<C-Up>", "<C-W>k")
vim.keymap.set("", "<C-Right>", "<C-W>l")

vim.keymap.set("", "<M-Left>", ":vertical :resize -1<CR>")
vim.keymap.set("", "<M-Down>", ":resize -1<CR>")
vim.keymap.set("", "<M-Up>", ":resize +1<CR>")
vim.keymap.set("", "<M-Right>", ":vertical :resize +1<CR>")

vim.g.RbsBookFile = vim.env.HOME .. "/doc/rbs/book43.lua"

