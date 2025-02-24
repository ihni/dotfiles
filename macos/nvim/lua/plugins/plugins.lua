return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use { "ellisonleao/gruvbox.nvim" }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use "stevearc/oil.nvim"

end)
