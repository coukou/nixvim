{ helpers, ... }: {
  plugins.conform-nvim = {
    enable = true;

    settings = {
      formatters_by_ft = {
        lua = [ "stylua" ];
        javascript = [ "biome" "biome-organize-imports" ];
        typescript = [ "biome" "biome-organize-imports" ];
        typescriptreact = [ "biome" "biome-organize-imports" ];
      };

      format_after_save = helpers.toLuaObject {
        timeout_ms = 500;
        lsp_format = "fallback";
      };

      notify_on_error = true;
    };
  };
}
