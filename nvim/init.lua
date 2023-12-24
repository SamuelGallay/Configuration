local packer = require('packer')

packer.startup(function(use)
  -- LaTeX
  use 'lervag/vimtex'
  --[[use { 'andymass/vim-matchup',
    setup = function()
      vim.g.matchup_override_vimtex = 1
      vim.g.matchup_matchparen_deferred = 1
    end
  }]]

  -- Syntax highlighting
  use 'nvim-treesitter/nvim-treesitter'
  --use 'danielo515/nvim-treesitter-reason'

  -- ctags
  use 'ludovicchabant/vim-gutentags'

  -- Language Server Protocol
  use 'neovim/nvim-lspconfig'

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  --use 'hrsh7th/cmp-path'
  --use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-omni' -- For LaTeX completion
  use 'hrsh7th/nvim-cmp' -- For Completion
  use { 'saadparwaiz1/cmp_luasnip' }

  use("simrat39/rust-tools.nvim")

  use("nvim-tree/nvim-web-devicons")
  use { "folke/trouble.nvim", requires = { "nvim-tree/nvim-web-devicons" } }

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
keymap('n', '<leader>fr', ':w<CR>:!latexindent -c=/home/samuel/.cache/latexindent -s -m -w %<CR>', opts)
keymap('n', '<leader>rr', ':w<CR>:e<CR>', opts)
keymap('n', '<leader>gg', ':LazyGit<CR>', opts)
--keymap('n', '<leader>m', '<Plug>(vimtex-env-change-math)\\[<CR>', opts)
keymap('n', '<leader>m', ':VimtexTocOpen<CR>', opts)
--keymap('n', '<leader>f', ':Telescope find_files<CR>', opts)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)
keymap('n', '<leader>s', ':set spell!<CR>', opt)
keymap('n', '<leader>z', ':lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<leader>ll', "<cmd>lua vim.lsp.buf.format()<CR>", opts)
vim.cmd [[inoremap <C-x><C-o> <Cmd>lua require('cmp').complete()<CR>]]

vim.cmd [[set mouse=a]]
vim.cmd [[set clipboard+=unnamedplus]]

vim.cmd [[set spellsuggest=best,9]]
vim.cmd [[set spelllang=en]]

-- Sanitize Insane Clipboard Defaults
vim.cmd [[ xnoremap <expr> p 'pgv"'.v:register.'y`>'
           xnoremap <expr> P 'Pgv"'.v:register.'y`>']]

--------- Themes ----------
vim.cmd [[if (has("termguicolors"))
 set termguicolors
endif]]
require('tokyonight').load()
require('lualine').setup {}

-- Scrolling
--require('neoscroll').setup()

-- Indent
vim.o.expandtab = true
vim.o.shiftwidth = 2

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.smartindent = false
    vim.opt_local.autoindent = false
    vim.opt_local.indentexpr = ""
  end
})


-- VimTex
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_ignore_filters = { 'Underfull', 'Overfull', 'Token not allowed' }
vim.g.vimtex_delim_toggle_mod_list = { { '\\Bigl', '\\Bigr' }, }
vim.g.vimtex_indent_enabled = 0
vim.g.vimtex_syntax_enabled = 1
vim.g.tex_indent_braces = 0
vim.g.tex_flavor = "latex"
vim.g.vimtex_matchparen_enable = 1


---------- LaTeX Snippets ----------
vim.cmd [[imap <silent><expr> jk luasnip#expand_or_locally_jumpable() ? '<c-g>u<Plug>luasnip-expand-or-jump' : '' ]]

require("luasnip").config.set_config({
  enable_autosnippets = true,
  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "",
  update_events = 'TextChanged,TextChangedI',
})

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })

---------- TreeSitter ----------

require("nvim-treesitter.configs").setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = { "latex" },
  },
  indent = {
    enable = true,
    disable = { "latex" }
  },
}

-- Auto Indent
vim.cmd [[autocmd BufWritePre *.ml,*.re lua vim.lsp.buf.format()]]
vim.cmd [[autocmd BufNewFile,BufRead *.re set filetype=reason]]


---------- LSP ----------
-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require 'lspconfig'.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim', 'tex', 'luatexbase' },
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
  capabilities = capabilities,
  settings = {
    filetypes =
    { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" }
  }
}
require 'lspconfig'.clangd.setup {
  capabilities = capabilities
}
require 'lspconfig'.pyright.setup {
  capabilities = capabilities
}
--- Huge Rust config
local function on_attach(client, buffer)
  -- This callback is called when the LSP is atttached/enabled for this buffer
  -- we could set keymaps related to LSP, etc here.
end
local rust_opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}
require("rust-tools").setup(rust_opts)

---------- Completion ----------
vim.o.completeopt = "menuone,noinsert,noselect"
vim.opt.shortmess = vim.opt.shortmess + "c"

local cmp = require 'cmp'
local luasnip = require 'luasnip'
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        --elseif luasnip.expand_or_jumpable() then
        --  luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'luasnip' }, -- For luasnip users. Doesn't work...
    { name = 'omni' },
    { name = 'nvim_lsp' },
  }, {
    --{ name = 'buffer' },
  })
})
vim.cmd [[ let &inccommand = ""]]
vim.g.gutentags_cache_dir = "~/.cache/ctags"

-- Function to check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
vim.o.updatetime = 300
function OpenDiagnosticIfNoFloat()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      return
    end
  end
  -- THIS IS FOR BUILTIN LSP
  vim.diagnostic.open_float(0, {
    scope = "cursor",
    focusable = false,
    close_events = {
      "CursorMoved",
      "CursorMovedI",
      "BufHidden",
      "InsertCharPre",
      "WinLeave",
    },
  })
end

-- Show diagnostics under the cursor when holding position
--[[vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  command = "lua OpenDiagnosticIfNoFloat()",
  group = "lsp_diagnostics_hold",
})
]]
