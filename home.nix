{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sestrella";
  home.homeDirectory = "/Users/sestrella";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Custom configuration
  home.sessionVariables = {
    EDITOR = "nvim";
    # https://nix-community.github.io/home-manager/index.html#sec-install-standalone
    NIX_PATH = "$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:+:$NIX_PATH}";
  };

  home.packages = [
    pkgs.aws-vault
    pkgs.awscli2
    pkgs.jq
    pkgs.ripgrep
    pkgs.terraform
    pkgs.tmate
    pkgs.tree
  ];

  programs.autojump.enable = true;

  programs.direnv.enable = true;

  programs.fish = {
    enable = true;
    shellAbbrs = {
      "gc!" = "git commit -v --amend";
      "gp!" = "git push --force";
      # git - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
      ga = "git add";
      gaa = "git add --all";
      gb = "git branch";
      gc = "git commit -v";
      gco = "git checkout";
      gd = "git diff";
      gl = "git pull";
      gp = "git push";
      gst = "git status";
      # home-manager
      hmo = "home-manager option";
      hms = "home-manager switch";
      # tmux - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
      ta = "tmux attach -t";
      tkss = "tmux kill-session -t";
      tksv = "tmux kill-server";
      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
    };
    shellInit = ''
      /opt/homebrew/bin/brew shellenv | source
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';
  };

  programs.fzf.enable = true;

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "git";
    };
  };

  programs.neovim =
    let
      mkLuaConfig = config: ''
        lua << EOF
        ${config}
        EOF
      '';
    in
    {
      enable = true;
      extraConfig = mkLuaConfig ''
        vim.o.colorcolumn = "80"
        vim.o.cursorline = true
        vim.o.expandtab = true
        vim.o.ignorecase = true
        vim.o.laststatus = 3
        vim.o.number = true
        vim.o.shiftwidth = 2
        vim.o.softtabstop = 2
        vim.o.splitbelow = true
        vim.o.splitright = true
        vim.o.tabstop = 2
      '';
      plugins = [
        {
          plugin = pkgs.vimPlugins.nvim-lspconfig;
          config = mkLuaConfig ''
            local on_attach = function(client, bufnr)
              local bufopts = { noremap = true, silent = true, buffer = bufnr }
              vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
            end

            local lspconfig = require("lspconfig")

            lspconfig["rnix"].setup({
              cmd = { "${pkgs.rnix-lsp}/bin/rnix-lsp" },
              on_attach = on_attach
            })

            lspconfig["terraformls"].setup({
              cmd = { "${pkgs.terraform-ls}/bin/terraform-ls", "serve" },
              on_attach = on_attach
            })

            lspconfig["yamlls"].setup({
              cmd = { "${pkgs.yaml-language-server}/bin/yaml-language-server", "--stdio" },
              on_attach = on_attach,
              settings = {
                yaml = {
                  schemas = {
                    ["https://json.schemastore.org/circleciconfig.json"] = "/.circleci/config.yml",
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.yml"
                  }
                }
              }
            })
          '';
        }
        {
          plugin = pkgs.vimPlugins.nvim-treesitter;
          config = mkLuaConfig ''
            local parser_installed_dir = "~/.local/share/nvim-treesitter"
            vim.opt.runtimepath:append(parser_installed_dir)
            require("nvim-treesitter.configs").setup({
              auto_install = true,
              parser_install_dir = parser_installed_dir,
              highlight = {
                enable = true
              }
            })
          '';
        }
        {
          plugin = pkgs.vimPlugins.telescope-nvim;
          config = mkLuaConfig ''
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<c-p>", builtin.find_files, {})
          '';
        }
      ];
      viAlias = true;
      vimAlias = true;
    };

  programs.starship.enable = true;

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    prefix = "C-a";
  };
}
