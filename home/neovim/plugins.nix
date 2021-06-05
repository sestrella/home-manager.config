{ vimPlugin, sources }:

[
  # compe
  {
    plugin = vimPlugin {
      name = "compe";
      src = sources."vim/compe";
    };
  }
  # lspconfig
  {
    plugin = vimPlugin {
      name = "lspconfig";
      src = sources."vim/lspconfig";
    };
  }
  # nix
  {
    plugin = vimPlugin {
      name = "nix";
      src = sources."vim/nix";
    };
  }
  # projectionist
  {
    plugin = vimPlugin {
      name = "projectionist";
      src = sources."vim/projectionist";
    };
  }
  # rails
  {
    plugin = vimPlugin {
      name = "rails";
      src = sources."vim/rails";
    };
  }
  # surround
  {
    plugin = vimPlugin {
      name = "surround";
      src = sources."vim/surround";
    };
  }
  # telescope
  {
    plugin = vimPlugin {
      name = "telescope";
      src = sources."vim/telescope";
    };
    config = ''
      nnoremap <C-p> <cmd>Telescope find_files<cr>
    '';
  }
  # trailing-whitespace
  {
    plugin = vimPlugin {
      name = "trailing-whitespace";
      src = sources."vim/trailing-whitespace";
    };
  }
  # tree
  {
    plugin = vimPlugin {
      name = "tree";
      src = sources."vim/tree";
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
      src = sources."vim/typescript";
    };
  }
]
