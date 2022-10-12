{ config, pkgs, ... }:

let
  nodePackages = pkgs.callPackage ../node-packages {
    nodejs = pkgs.nodejs-14_x;
  };
  ansibleLanguageServer = nodePackages."@ansible/ansible-language-server-1.x";
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

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
        # https://github.com/neovim/nvim-lspconfig#suggested-configuration
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
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "<space>f", function()
              vim.lsp.buf.format { async = true }
            end, bufopts)
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
      #  Use vim.lsp.buf.format { async = true } instead
      {
        # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md#treesitter
        plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins
          (plugins: [
            plugins.tree-sitter-dockerfile
            plugins.tree-sitter-haskell
            plugins.tree-sitter-hcl
            plugins.tree-sitter-markdown
            plugins.tree-sitter-nix
            plugins.tree-sitter-rust
            plugins.tree-sitter-yaml
          ]);
        config = ''
          require("nvim-treesitter.configs").setup({
            highlight = {
              enable = true
            }
          })
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

  xdg.configFile."nvim/init.lua".onChange = ''
    ${pkgs.luaPackages.luacheck}/bin/luacheck \
      ~/.config/nvim/init.lua \
      --codes \
      --globals vim \
      --ignore 631
  '';
}
