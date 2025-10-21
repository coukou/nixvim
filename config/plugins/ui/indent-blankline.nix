{
  plugins.indent-blankline = {
    enable = true;

    settings = {
      scope = {
        enabled = false;
      };
      exclude = {
        filetypes = [
          ""
          "checkhealth"
          "help"
          "lspinfo"
          "packer"
          "TelescopePrompt"
          "TelescopeResults"
          "yaml"
        ];
        buftypes = [
          "terminal"
          "quickfix"
        ];
      };
    };
  };
}
