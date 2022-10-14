{ config, pkgs, ... }@args:

{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua << EOF
      vim.o.cmdheight = 0
      vim.o.colorcolumn = "80"
      vim.o.cursorline = true
      vim.o.expandtab = true
      vim.o.ignorecase = true
      vim.o.laststatus = 0
      vim.o.number = true
      vim.o.shiftwidth = 2
      vim.o.softtabstop = 2
      vim.o.splitbelow = true
      vim.o.splitright = true
      vim.o.tabstop = 2
      vim.o.winbar= "%f"
      EOF
    '';
    plugins = map
      (plugin: (import plugin { inherit pkgs; }))
      [
        ./neovim/cmp.nix
        ./neovim/dark-notify.nix
        ./neovim/lspconfig.nix
        ./neovim/null-ls.nix
        ./neovim/solarized.nix
        ./neovim/telescope.nix
        ./neovim/treesitter.nix
      ] ++ [
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-vsnip
      pkgs.vimPlugins.vim-vsnip
    ];
    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim/init.lua".onChange = ''
    ${pkgs.luaPackages.luacheck}/bin/luacheck \
      ~/.config/nvim/init.lua \
      --codes \
      --globals vim \
      --ignore 631
  '';
}
