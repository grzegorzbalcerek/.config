
vim.opt.compatible = false

vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.clipboard = "unnamed"
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
vim.opt.path = { ".", vim.env.HOME .. "/.config/**", vim.env.HOME .. "/lib", vim.env.HOME .. "/doc/**", vim.env.HOME .. "/rep/zk/zkvault", vim.env.HOME .. "/rep/rbs/**", "" }
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
vim.keymap.set("", "<leader>w", ":write<CR>")
vim.keymap.set("", "<leader>r", ":set wrap!<CR>")

vim.keymap.set("", "<M-Left>", "<C-W>h")
vim.keymap.set("", "<M-Down>", "<C-W>j")
vim.keymap.set("", "<M-Up>", "<C-W>k")
vim.keymap.set("", "<M-Right>", "<C-W>l")

vim.keymap.set("", "<S-Left>", "zh")
vim.keymap.set("", "<S-Down>", "<C-E>")
vim.keymap.set("", "<S-Up>", "<C-Y>")
vim.keymap.set("", "<S-Right>", "zl")

vim.keymap.set("", "<C-M-Left>", ":bprev<CR>")
vim.keymap.set("", "<C-M-Down>", ":ls<CR>")
vim.keymap.set("", "<C-M-Up>", ":Explore<CR>")
vim.keymap.set("", "<C-M-Right>", ":bnext<CR>")

vim.keymap.set("", "<C-S-M-Left>", ":vertical :resize -1<CR>")
vim.keymap.set("", "<C-S-M-Down>", ":resize -1<CR>")
vim.keymap.set("", "<C-S-M-Up>", ":resize +1<CR>")
vim.keymap.set("", "<C-S-M-Right>", ":vertical :resize +1<CR>")

vim.keymap.set("i", "<C-B>", "<C-o>0")
vim.keymap.set("i", "<C-F>", "<C-o>$")

vim.g.OgntPath = vim.env.HOME .. "/doc/rbs/ognt"
vim.g.OgntBook = 43

