local packer = require('packer')

packer.startup(function(use)
  -- LaTeX
  use 'lervag/vimtex'

  -- Syntax highlighting
  --use 'nvim-treesitter/nvim-treesitter'

  -- Language Server Protocol
  use 'neovim/nvim-lspconfig'

  -- Completion
  --use 'hrsh7th/cmp-nvim-lsp'
  --use 'hrsh7th/cmp-buffer'
  --use 'hrsh7th/cmp-path'
  --use 'hrsh7th/cmp-cmdline'
  --use 'hrsh7th/cmp-omni' -- For LaTeX completion
  --use 'hrsh7th/nvim-cmp' -- For Completion

  -- Snippets
  -- use 'SirVer/ultisnips'
  -- use 'quangnguyen30192/cmp-nvim-ultisnips'
  use "L3MON4D3/LuaSnip"

  -- File explorer
  use 'ms-jpq/chadtree'

  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- GitHub Copilot
  -- use 'github/copilot.vim'

  -- Themes
  use 'folke/tokyonight.nvim'
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
--keymap('n', '<leader>rs', ':call UltiSnips#RefreshSnippets()<CR>', opt)
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>t', ':VimtexCompile<CR>', opts)
keymap('n', '<leader>ps', ':PackerSync<CR>', opts)
keymap('n', '<leader>e', ':CHADopen<CR>', opts)
keymap('n', '<leader>g', ':lua vim.lsp.buf.formatting()<CR>', opts)
keymap('n', '<leader>f', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>s', ':set spell!<CR>', opt)
keymap('n', '<leader>z', ':lua vim.lsp.buf.hover()<CR>', opts)

vim.cmd [[set mouse=a]]
vim.cmd [[set clipboard+=unnamedplus]]

vim.cmd [[set spellsuggest=best,9]]
vim.cmd [[set spelllang=en,fr]]

-- Sanitize Insane Clipboard Defaults
vim.cmd [[ xnoremap <expr> p 'pgv"'.v:register.'y`>'
           xnoremap <expr> P 'Pgv"'.v:register.'y`>']]

-- Copilot
--vim.g.copilot_no_tab_map = true
-- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })


--------- Themes ----------
vim.g.tokyonight_style = "night"
vim.cmd [[colorscheme tokyonight]]

-- Indent
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- VimTex
vim.cmd [[let g:vimtex_view_method = 'zathura']]
vim.cmd [[let g:vimtex_quickfix_ignore_filters = ['Underfull','Overfull',] ]]
vim.cmd [[
let g:vimtex_delim_toggle_mod_list = [
  \ ['\Bigl', '\Bigr'],
  \]
  ]]
---------- LaTeX Snippets ----------
vim.cmd [[
" Expand or jump in insert mode
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 

" Jump forward through tabstops in visual mode
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
]]

-- Somewhere in your Neovim startup, e.g. init.lua
require("luasnip").config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

---------- Completion ----------
--[[
local cmp = require('cmp')
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup {
  mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['§'] = cmp.mapping(function(fallback)
      cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
    end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
        ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources {
    --{ name = 'ultisnips' },
    { name = 'nvim_lsp' },
    --{ name = 'omni', },
    --{ name = 'buffer' },
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
}
]]

---------- TreeSitter ----------
--[[
require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = false,
    disable = { "latex" },
  },
}
]]

-- Auto Indent
--vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
vim.cmd [[autocmd BufWritePre *.ml lua vim.lsp.buf.format()]]
--vim.cmd [[autocmd FileWritePre <buffer> lua vim.lsp.buf.format()]]


---------- LSP ----------
require'lspconfig'.lua_ls.setup {
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
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
require 'lspconfig'.ocamllsp.setup {}
require 'lspconfig'.clangd.setup {}
require 'lspconfig'.pyright.setup {}

