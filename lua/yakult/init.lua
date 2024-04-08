require("yakult.remap")
require("yakult.set")

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- General Plugins
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-treesitter/nvim-treesitter', {["do"] = ':TSUpdate'})
Plug('mbbill/undotree')
Plug('kdheepak/lazygit.nvim')
Plug('m4xshen/autoclose.nvim')
Plug('akinsho/toggleterm.nvim', {['tag'] = '*'})
Plug('nvim-lualine/lualine.nvim')
Plug('jiriks74/presence.nvim')

-- Themes
Plug('comfysage/evergarden')
Plug('rebelot/kanagawa.nvim')
Plug('Mofiqul/dracula.nvim')

-- LSP Support
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('VonHeikemen/lsp-zero.nvim', {["branch"] = 'v3.x'})

-- Autocompletion
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('saadparwaiz1/cmp_luasnip')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-nvim-lua')

-- Snippets
Plug('L3MON4D3/LuaSnip')
Plug('rafamadriz/friendly-snippets')

vim.call('plug#end')

-- THEME SETTINGS
require 'evergarden'.setup {
    transparent_background = true
}

require 'kanagawa'.setup {
    transparent = true,
    colors = {
        theme = {
            all = {
                ui = {
                    bg_gutter = "none"
                }
            }
        }
    }
}

require 'dracula'.setup {
    transparent_bg = true
}

vim.cmd[[colorscheme kanagawa]]

-- LSP SETTINGS
local lsp_zero = require('lsp-zero')

-- LSP Setup
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  ensure_installed = {'tsserver', 'rust_analyzer', 'jdtls', 'lua_ls', 'jedi_language_server', 'bashls', 'arduino_language_server', 'marksman'},
  handlers = {
    lsp_zero.default_setup,

    ["lua_ls"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup {
            settings = {
                Lua = {
                    diagnositcs = {
                        globals = { "vim" }
                    }
                }
            }
        }
    end,
  }
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

-- Making CMP Window transparent
vim.api.nvim_set_hl(0, 'CmpItemAbbr', { bg = "NONE" })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', {bg = "NONE"})
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', {bg = "NONE"})
vim.api.nvim_set_hl(0, 'FloatBorder', {link = 'Normal'})

cmp.setup({
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})






