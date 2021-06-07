{ pkgs }:

let
  mkPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
  sources = import ./nix/sources.nix {};
in [
  # compe
  {
    plugin = mkPlugin {
      name = "compe";
      src = sources.compe;
    };
  }
  # lspconfig
  {
    plugin = mkPlugin {
      name = "lspconfig";
      src = sources.lspconfig;
    };
  }
  # neon
  {
    plugin = mkPlugin {
      name = "neon";
      src = sources.neon;
    };
    config = ''
      lua vim.cmd[[colorscheme neon]]
    '';
  }
  # nix
  {
    plugin = mkPlugin {
      name = "nix";
      src = sources.nix;
    };
  }
  # projectionist
  {
    plugin = mkPlugin {
      name = "projectionist";
      src = sources.projectionist;
    };
  }
  # rails
  {
    plugin = mkPlugin {
      name = "rails";
      src = sources.rails;
    };
  }
  # surround
  {
    plugin = mkPlugin {
      name = "surround";
      src = sources.surround;
    };
  }
  # telescope
  {
    plugin = mkPlugin {
      name = "telescope";
      src = sources.telescope;
    };
    config = ''
      nnoremap <C-p> <cmd>Telescope find_files<cr>
    '';
  }
  # trailing-whitespace
  {
    plugin = mkPlugin {
      name = "trailing-whitespace";
      src = sources.trailing-whitespace;
    };
  }
  # tree
  {
    plugin = mkPlugin {
      name = "tree";
      src = sources.tree;
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
      src = sources.typescript;
    };
  }
]
