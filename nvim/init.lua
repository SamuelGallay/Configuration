local packer = require('packer')

packer.startup(function(use)
  -- LaTeX
  use 'lervag/vimtex'

  -- Syntax highlighting
  use 'nvim-treesitter/nvim-treesitter'

  -- Language Server Protocol
  use 'neovim/nvim-lspconfig'

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  --use 'hrsh7th/cmp-buffer'
  --use 'hrsh7th/cmp-path'
  --use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-omni' -- For LaTeX completion
  use 'hrsh7th/nvim-cmp' -- For Completion

  -- Snippets
  use 'L3MON4D3/LuaSnip'

  -- File explorer
  use 'ms-jpq/chadtree'

  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

   -- Misc
  use 'jghauser/mkdir.nvim'
  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
        "nvim-lua/plenary.nvim",
    },
  })
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'karb94/neoscroll.nvim'


  -- Themes
  use 'folke/tokyonight.nvim'
  --use 'navarasu/onedark.nvim'
  --use "EdenEast/nightfox.nvim"
  --use "sainnhe/edge"
  --use "mhartington/oceanic-next"
  --use 'glepnir/zephyr-nvim'
end)

--------- Key Bindings ----------
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local opt = { noremap = true, silent = false }

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

keymap('n', '<leader>rc', ':luafile ~/.config/nvim/init.lua<CR>', opt)
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>t', ':VimtexCompile<CR>', opts)
keymap('n', '<leader>ps', ':PackerSync<CR>', opts)
keymap('n', '<leader>e', ':CHADopen<CR>', opts)
keymap('n', '<leader>fr', ':w<CR>:!latexindent -s -m -w %<CR>', opts)
keymap('n', '<leader>gg', ':LazyGit<CR>', opts)
--keymap('n', '<leader>f', ':Telescope find_files<CR>', opts)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
keymap('n', '<leader>s', ':set spell!<CR>', opt)
keymap('n', '<leader>z', ':lua vim.lsp.buf.hover()<CR>', opts)

vim.cmd [[set mouse=a]]
vim.cmd [[set clipboard+=unnamedplus]]

vim.cmd [[set spellsuggest=best,9]]
vim.cmd [[set spelllang=en]]

-- Sanitize Insane Clipboard Defaults
vim.cmd [[ xnoremap <expr> p 'pgv"'.v:register.'y`>'
           xnoremap <expr> P 'Pgv"'.v:register.'y`>']]

--------- Themes ----------
vim.cmd[[if (has("termguicolors"))
 set termguicolors
endif]]
require('tokyonight').load()
require('lualine').setup{}

-- Scrolling
require('neoscroll').setup()

-- Indent
vim.o.expandtab = true
vim.o.smartindent = false
vim.o.autoindent = false
vim.o.indentexpr = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.cmd [[autocmd FileType plaintex,tex,context setlocal indentexpr=]]

-- VimTex
<<<<<<< HEAD
vim.cmd [[let g:vimtex_view_method = 'zathura']]
vim.cmd [[let g:vimtex_quickfix_ignore_filters = ['Underfull','Overfull',] ]]
vim.cmd [[let g:vimtex_delim_toggle_mod_list = [ ['\Bigl', '\Bigr'], ] ]]
vim.cmd [[let g:vimtex_indent_enabled   = 0]]
=======
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_ignore_filters = {'Underfull','Overfull',}
vim.g.vimtex_delim_toggle_mod_list = { {'\\Bigl', '\\Bigr'}, }
vim.g.vimtex_indent_enabled = 0
vim.g.vimtex_syntax_enabled = 0
vim.g.tex_indent_braces = 0
>>>>>>> 68f0b94 (LuaSnip, etc.)

---------- LaTeX Snippets ----------
vim.cmd [[
" Expand or jump in insert mode
<<<<<<< HEAD
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<c-g>u<Plug>luasnip-expand-or-jump' : '<Tab>' 
=======
" imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<c-g>u<Plug>luasnip-expand-or-jump' : '<Tab>' 
  imap <silent><expr> jk luasnip#expand_or_jumpable() ? '<c-g>u<Plug>luasnip-expand-or-jump' : '<Tab>' 
>>>>>>> 68f0b94 (LuaSnip, etc.)

" Jump forward through tabstops in visual mode
" smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
]]

-- Somewhere in your Neovim startup, e.g. init.lua
require("luasnip").config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
<<<<<<< HEAD
  store_selection_keys = "<Tab>",
=======
  --store_selection_keys = "<Tab>",
>>>>>>> 68f0b94 (LuaSnip, etc.)

  update_events = 'TextChanged,TextChangedI',
})

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

---------- TreeSitter ----------
require("nvim-treesitter.configs").setup {
    ensure_installed = "all" ,
    highlight = {
            enable = true,
    },
    indent = {
            enable = false,
    },
}


-- Auto Indent
vim.cmd [[autocmd BufWritePre *.ml lua vim.lsp.buf.format()]]


---------- LSP ----------
-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require 'lspconfig'.ocamllsp.setup {
  capabilities = capabilities
}
require 'lspconfig'.clangd.setup {
  capabilities = capabilities
}
require 'lspconfig'.pyright.setup {
  capabilities = capabilities
}
---------- Completion ----------
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'omni'},
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

