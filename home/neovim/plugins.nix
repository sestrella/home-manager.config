{ pkgs }:

# The following link contains instructions about how to add custom plugins:
#
# https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md#what-if-your-favourite-vim-plugin-isnt-already-packaged
#
# The following link contains a list of awesome Neovim plugins:
#
# https://github.com/rockerBOO/awesome-neovim
let
  sources = import ./nix/sources.nix {};
  mkPlugin = ({ name } : pkgs.vimUtils.buildVimPluginFrom2Nix {
    inherit name;
    src = sources."${name}";
  });
in [
  # compe
  {
    plugin = mkPlugin {
      name = "compe";
    };
    config = ''
      lua <<EOF
        require'compe'.setup {
          enabled = true;
          autocomplete = true;
          debug = false;
          min_length = 1;
          preselect = 'enable';
          throttle_time = 80;
          source_timeout = 200;
          incomplete_delay = 400;
          max_abbr_width = 100;
          max_kind_width = 100;
          max_menu_width = 100;
          documentation = true;

          source = {
            path = true;
            buffer = true;
            calc = true;
            nvim_lsp = true;
            nvim_lua = true;
            vsnip = true;
            ultisnips = true;
          };
        }
      EOF
    '';
  }
  # kommentary
  {
    plugin = mkPlugin {
      name = "kommentary";
    };
  }
  # lspconfig
  {
    plugin = mkPlugin {
      name = "lspconfig";
    };
    # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
    config = ''
      lua <<EOF
        require'lspconfig'.terraformls.setup{}
        require'lspconfig'.yamlls.setup{}
      EOF
    '';
  }
  # lualine
  {
    plugin = mkPlugin {
      name = "lualine";
    };
    config = ''
      lua <<EOF
        require('lualine').setup({
          options = {
            theme = 'neon'
          }
        })
      EOF
    '';
  }
  # neon
  {
    plugin = mkPlugin {
      name = "neon";
    };
    config = ''
      lua vim.cmd[[colorscheme neon]]
    '';
  }
  # nix
  {
    plugin = mkPlugin {
      name = "nix";
    };
  }
  # popup (required by telescope)
  {
    plugin = mkPlugin {
      name = "popup";
    };
  }
  # plenary (required by telescope and todo-comments)
  {
    plugin = mkPlugin {
      name = "plenary";
    };
  }
  # projectionist
  {
    plugin = mkPlugin {
      name = "projectionist";
    };
  }
  # rails
  {
    plugin = mkPlugin {
      name = "rails";
    };
  }
  # surround
  {
    plugin = mkPlugin {
      name = "surround";
    };
  }
  # telescope
  {
    plugin = mkPlugin {
      name = "telescope";
    };
    config = ''
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    '';
  }
  # todo-comments
  {
    plugin = mkPlugin {
      name = "todo-comments";
    };
    config = ''
      lua require("todo-comments").setup()
    '';
  }
  # trailing-whitespace
  {
    plugin = mkPlugin {
      name = "trailing-whitespace";
    };
  }
  # tree
  {
    plugin = mkPlugin {
      name = "tree";
    };
    config = ''
      highlight NvimTreeFolderIcon guibg=blue

      nnoremap <C-n> :NvimTreeToggle<CR>
    '';
  }
  # typescript
  {
    plugin = mkPlugin {
      name = "typescript";
    };
  }
]
