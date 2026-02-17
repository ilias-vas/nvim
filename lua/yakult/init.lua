require("yakult.remap")
require("yakult.set")
local vim = vim

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- General Plugins
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('mbbill/undotree')
Plug('nvim-treesitter/nvim-treesitter', {["do"] = ':TSUpdate'})
Plug('kdheepak/lazygit.nvim')
Plug('m4xshen/autoclose.nvim')
Plug('akinsho/toggleterm.nvim', {['tag'] = '*'})
Plug('nvim-lualine/lualine.nvim')
Plug('jiriks74/presence.nvim')
Plug('windwp/nvim-ts-autotag')
Plug('ThePrimeagen/harpoon', {['branch'] = 'harpoon2'})
Plug('lervag/vimtex')
Plug('HoNamDuong/hybrid.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('gelguy/wilder.nvim')
Plug('kkharji/sqlite.lua')
Plug('numToStr/Comment.nvim')
Plug('max397574/better-escape.nvim')
Plug('kawre/leetcode.nvim')
Plug('ferdinandrau/lavish.nvim')
Plug('MunifTanjim/nui.nvim')
Plug('xeluxee/competitest.nvim')
Plug('mikavilpas/yazi.nvim')

-- Java Setup
Plug('nvim-java/lua-async-await')
Plug('nvim-java/nvim-java-refactor')
Plug('nvim-java/nvim-java-core')
Plug('nvim-java/nvim-java-test')
Plug('nvim-java/nvim-java-dap')
Plug('JavaHello/spring-boot.nvim')
Plug('MunifTanjim/nui.nvim')
Plug('nvim-java/nvim-java')

-- DAP Debugging
Plug('mfussenegger/nvim-dap')
Plug('nvim-neotest/nvim-nio')
Plug('jay-babu/mason-nvim-dap.nvim')
Plug('rcarriga/nvim-dap-ui')

--- Themes
Plug('comfysage/evergarden')
Plug('rebelot/kanagawa.nvim')
Plug('Mofiqul/dracula.nvim')
Plug('folke/tokyonight.nvim')
Plug('nyoom-engineering/oxocarbon.nvim')
Plug('glepnir/zephyr-nvim')
Plug('Th3Whit3Wolf/space-nvim')
Plug('neanias/everforest-nvim', {['branch'] = 'main'})
Plug('ellisonleao/gruvbox.nvim')
Plug('sainnhe/gruvbox-material')
Plug('aktersnurra/no-clown-fiesta.nvim')
Plug('zaldih/themery.nvim')
Plug('wtfox/jellybeans.nvim')

-- LSP Support
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('VonHeikemen/lsp-zero.nvim', {["branch"] = 'v3.x'})
Plug('nvimtools/none-ls.nvim')

-- Autocompletion
Plug('saghen/blink.cmp', { ['tag'] = 'v1.*' })

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

require('tokyonight').setup({
    style = 'moon',
    transparent = true
})

vim.g.space_nvim_transparent_bg = true

require('everforest').setup({
    transparent_background_level = 2
})

require('hybrid').setup({
    transparent = 'true'
})

require('gruvbox').setup({
    transparent_mode = true
})

require("no-clown-fiesta").setup({
    transparent = true
})

require("lavish").setup({
    style = {
        transparent = true,
    },
})

-- CP Testing
require('competitest').setup() -- to use default configuration

-- LSP SETTINGS
local lsp_zero = require('lsp-zero')

-- LSP Setup
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({
    opts = {
        ensure_installed = {
            "clang-format",
        }
    }
})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here 
  -- with the ones you want to install
  ensure_installed = {'tsserver', 'jdtls', 'rust_analyzer', 'lua_ls', 'jedi_language_server', 'bashls', 'arduino_language_server', 'marksman', 'html', 'cssls', 'emmet_ls',},
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

require('mason-nvim-dap').setup({
    event = "VeryLazy",
})

-- snippets and autocomplete
require('blink.cmp').setup({
  keymap = { preset = 'enter' },

  appearance = {
    nerd_font_variant = 'mono'
  },

  completion = {
    menu = {
        border = "single"
    },
    documentation = { window = { border = "rounded" }, auto_show = false }
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning"
  }
})
