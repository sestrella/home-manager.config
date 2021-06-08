{ pkgs }:

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
  # plenary (required by todo-comments)
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
      nnoremap <C-p> <cmd>Telescope find_files<cr>
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
