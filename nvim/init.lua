packer = require('packer')

packer.startup(function()
	-- use 'wbthomason/packer.nvim'

	-- LaTeX
  	use 'lervag/vimtex'
	
	-- Syntax highlighting
    	use 'nvim-treesitter/nvim-treesitter'
    	
	-- Completion
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-omni'
	use 'hrsh7th/nvim-cmp'

	-- Themes
	use 'folke/tokyonight.nvim'
end)

--------- Key Bindings ----------
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Map Dot to Semicolon
keymap("n", ".", ":", { noremap = true })

-- Remap 'q' to ':q'
keymap("n", "q", "<Nop>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap('n', '<leader>r', ':so<CR>', opts)
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>t', ':VimtexCompile<CR>', opts)

--------- Themes ----------
vim.g.tokyonight_style = "night"
vim.cmd[[colorscheme tokyonight]]

---------- Completion ---------- 
cmp = require('cmp')
cmp.setup {
	sources = cmp.config.sources { 
		{ name = 'nvim_lsp' }, 
		{ name = 'omni', }, 
		{ name = 'buffer' }, 
	},

}

---------- TreeSitter ---------- 
require'nvim-treesitter.configs'.setup {
	ensure_installed = "all",
	highlight = {
		enable = true,
	},
}
