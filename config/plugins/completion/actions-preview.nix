{ ... }: {
  plugins.actions-preview = {
    enable = true;
  };

  keymaps = [
    {
      key = "<C-.>";
      action.__raw = ''require("actions-preview").code_actions'';
      options.desc = "Code actions";
    }
  ];
}
