{ config, pkgs, ... }:

let
  nodePackages = pkgs.callPackage ../nodePackages {
    nodejs = pkgs.nodejs-14_x;
  };
  ansibleLanguageServer = pkgs.stdenv.mkDerivation rec {
    pname = "ansible-language-server";
    version = "0.10.3";
    src = builtins.fetchTarball {
      url = "https://github.com/ansible/ansible-language-server/archive/refs/tags/v${version}.tar.gz";
      sha256 = "1ydj0fiwvb48hf3nsqyg2038mihxlyazmwapgir2kx3nfzwslskv";
    };
    nativeBuildInputs = [
      pkgs.nodejs
      pkgs.nodePackages.npm
    ];
    buildPhase = ''
      HOME=. npm ci
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp -r node_modules $out/
      cp -r out $out/
      cp bin/ansible-language-server $out/bin
      cp package.json $out/
    '';
    fixupPhase = ''
      patchShebangs $out/bin/ansible-language-server
    '';
  };
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      lua << EOF
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
      EOF
    '';
    plugins = [
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-vsnip
      {
        plugin = pkgs.vimPlugins.null-ls-nvim;
        config = ''
          local null_ls = require("null-ls")
          null_ls.setup({
            sources = {
              null_ls.builtins.formatting.shfmt.with({
                command = "${pkgs.shfmt}/bin/shfmt"
              })
            }
          })
        '';
        type = "lua";
      }
      {
        plugin = pkgs.vimPlugins.nvim-cmp;
        config = ''
          local cmp = require("cmp")
          cmp.setup({
            snippet = {
              expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
              end
            },
            mapping = cmp.mapping.preset.insert({
              ["<Tab>"] = cmp.mapping.confirm({ select = true })
            }),
            sources = cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "vsnip" }
            })
          })
        '';
        type = "lua";
      }
      {
        plugin = pkgs.vimPlugins.nvim-lspconfig;
        config = ''
          local servers = {
            ansiblels = {
              cmd = { "${ansibleLanguageServer}/bin/ansible-language-server", "--stdio" },
            },
            bashls = {
              cmd = { "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server", "start" }
            },
            rnix = {
              cmd = { "${pkgs.rnix-lsp}/bin/rnix-lsp" }
            },
            rust_analyzer = {
              cmd = { "${pkgs.rust-analyzer}/bin/rust-analyzer" }
            },
            terraformls = {
              cmd = { "${pkgs.terraform-ls}/bin/terraform-ls", "serve" }
            },
            yamlls = {
              cmd = { "${pkgs.yaml-language-server}/bin/yaml-language-server", "--stdio" },
              settings = {
                yaml = {
                  schemas = {
                    ["https://json.schemastore.org/circleciconfig.json"] = "/.circleci/config.yml",
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.yml"
                  }
                }
              }
            }
          }

          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

          local on_attach = function(_client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
          end

          local lspconfig = require("lspconfig")
          for server, options in pairs(servers) do
            lspconfig[server].setup(vim.tbl_extend("keep", options, {
              capabilities = capabilities,
              on_attach = on_attach
            }))
          end
        '';
        type = "lua";
      }
      {
        plugin = pkgs.vimPlugins.nvim-treesitter;
        # https://github.com/nvim-treesitter/nvim-treesitter#changing-the-parser-install-directory
        config = ''
          local parser_installed_dir = "~/.local/share/nvim-treesitter"
          require("nvim-treesitter.configs").setup({
            auto_install = true,
            parser_install_dir = parser_installed_dir,
            highlight = {
              enable = true
            }
          })
          vim.opt.runtimepath:append(parser_installed_dir)
        '';
        type = "lua";
      }
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = ''
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<c-p>", builtin.git_files, {})
        '';
        type = "lua";
      }
      pkgs.vimPlugins.vim-vsnip
    ];
    viAlias = true;
    vimAlias = true;
  };

  # TODO: open an issue about passing the file path as an argument
  xdg.configFile."nvim/init.lua".onChange = ''
    ${pkgs.luaPackages.luacheck}/bin/luacheck \
      --config ~/.config/nixpkgs/.luacheckrc \
      ~/.config/nvim/init.lua
  '';
}
