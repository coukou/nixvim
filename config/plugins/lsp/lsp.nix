{ pkgs, ... }: {
  plugins.lsp = {
    enable = true;
    inlayHints = true;

    servers = {
      nil_ls = {
        enable = true;

        settings = {
          formatting = {
            command = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
          };
        };
      };

      rust_analyzer = {
        enable = true;

        installRustc = false;
        installCargo = false;
      };

      ts_ls = {
        enable = true;
      };
    };

    keymaps = {
      silent = true;
      lspBuf = {
        gd = {
          action = "definition";
          desc = "Goto definition";
        };
        K = {
          action = "hover";
          desc = " Hover";
        };
      };
    };

    postConfig = ''
      local _border = "rounded"

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = _border
        }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = _border
        }
      )

      vim.diagnostic.config{
        float={border=_border}
      };

      -- require('lspconfig.ui.windows').default_options = {
      --   border = _border
      -- }
    '';
  };
}
