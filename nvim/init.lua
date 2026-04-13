vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

require("vim._core.ui2").enable({})

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true
vim.opt.wrap = true
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = true
vim.opt.confirm = true

vim.opt.shell = "pwsh"
vim.keymap.set("n", "<leader>T", "<CMD> split | term<CR>i<space>clear<CR>", { desc = "Open [T]erminal" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
	-- timeout = 300,
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
})
vim.opt.hlsearch = true
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>")
vim.opt.inccommand = "split"

vim.opt.termguicolors = true
vim.cmd.colorscheme("catppuccin")

vim.opt.autocomplete = true

-- vim.pack.add({
-- 	'https://github.com/neovim/nvim-lspconfig',
-- })
