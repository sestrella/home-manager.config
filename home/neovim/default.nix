{ pkgs, ... }:

let
  sources = import ../../nix/sources.nix {};
  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
  lspConfigs = {
    rnix = pkgs.rnix-lsp;
    terraformls = pkgs.terraform-ls;
    tflint = pkgs.tflint;
    yamlls = pkgs.yaml-language-server;
  };
in {
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = builtins.attrValues lspConfigs;

  programs.neovim = {
    enable = true;
    # config
    extraConfig = ''
      set number
      set colorcolumn=80

      set expandtab
      set shiftwidth=2
      set softtabstop=2
      set tabstop=2

      set splitbelow
      set splitright

      set spell
      set spelllang=en

      set termguicolors

      let mapleader = "\<Space>"
      let maplocalleader = ','
    '';
    package = pkgs.neovim-nightly;
    # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md#what-if-your-favourite-vim-plugin-isnt-already-packaged
    plugins = (import ./plugins.nix {
      vimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
      sources = sources;
    });
      #{
        #plugin = nvim-lspconfig;
        #config = let
          #names = builtins.attrNames lspConfigs;
          #servers = builtins.map (name: "require'lspconfig'.${name}.setup{}") names;
        #in ''

        #'';
        #in ''
          #lua <<EOF
            #require'lspconfig'.yamlls.setup{
              #settings = {
                #yaml = {
                  #schemas = {
                    #["https://json.schemastore.org/circleciconfig.json"] = ".circleci/config.yml"
                  #}
                #}
              #}
            #}
          #EOF
        #'';
      #}
      #vim-jinja
      #vim-jsx-typescript
      #vim-repeat
      #vim-sensible
      #vim-snippets
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim/UltiSnips".source = ./ultisnips;
}
