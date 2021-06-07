{ vimPlugin }:

let
  sources = import ./nix/sources.nix {};
in [
  # compe
  {
    plugin = vimPlugin {
      name = "compe";
      src = sources.compe;
    };
  }
  # lspconfig
  {
    plugin = vimPlugin {
      name = "lspconfig";
      src = sources.lspconfig;
    };
  }
  # neon
  {
    plugin = vimPlugin {
      name = "neon";
      src = sources.neon;
    };
    config = ''
      lua vim.cmd[[colorscheme neon]]
    '';
  }
  # nix
  {
    plugin = vimPlugin {
      name = "nix";
      src = sources.nix;
    };
  }
  # projectionist
  {
    plugin = vimPlugin {
      name = "projectionist";
      src = sources.projectionist;
    };
  }
  # rails
  {
    plugin = vimPlugin {
      name = "rails";
      src = sources.rails;
    };
  }
  # surround
  {
    plugin = vimPlugin {
      name = "surround";
      src = sources.surround;
    };
  }
  # telescope
  {
    plugin = vimPlugin {
      name = "telescope";
      src = sources.telescope;
    };
    config = ''
      nnoremap <C-p> <cmd>Telescope find_files<cr>
    '';
  }
  # trailing-whitespace
  {
    plugin = vimPlugin {
      name = "trailing-whitespace";
      src = sources.trailing-whitespace;
    };
  }
  # tree
  {
    plugin = vimPlugin {
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
    plugin = vimPlugin {
      name = "typescript";
      src = sources.typescript;
    };
  }
]
