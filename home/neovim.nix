{ config, pkgs, ... }:

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
          local on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, bufopts)
          end

          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

          local lspconfig = require("lspconfig")

          lspconfig["rnix"].setup({
            cmd = { "${pkgs.rnix-lsp}/bin/rnix-lsp" },
            on_attach = on_attach,
            capabilities = capabilities
          })

          lspconfig["terraformls"].setup({
            cmd = { "${pkgs.terraform-ls}/bin/terraform-ls", "serve" },
            on_attach = on_attach,
            capabilities = capabilities
          })

          lspconfig["yamlls"].setup({
            cmd = { "${pkgs.yaml-language-server}/bin/yaml-language-server", "--stdio" },
            on_attach = on_attach,
            capabilities = capabilities,
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
        type = "lua";
      }
      {
        plugin = pkgs.vimPlugins.nvim-treesitter;
        config = ''
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
        type = "lua";
      }
      {
        plugin = pkgs.vimPlugins.telescope-nvim;
        config = ''
          local builtin = require("telescope.builtin")
          vim.keymap.set("n", "<c-p>", builtin.find_files, {})
        '';
        type = "lua";
      }
      pkgs.vimPlugins.vim-vsnip
    ];
    viAlias = true;
    vimAlias = true;
  };
}
