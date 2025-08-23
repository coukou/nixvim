{
  plugins.codecompanion = {
    enable = true;

    settings = {
      strategies = {
        agent = {
          adapter = "copilot";
        };
        chat = {
          adapter = "copilot";
        };
        inline = {
          adapter = "copilot";
        };
      };
    };
  };

  keymaps = [
    {
      key = "<leader>ac";
      action = "<CMD>CodeCompanionChat<CR>";
      options.desc = "Open codecompanion chat";
    }
    {
      key = "<leader>aa";
      action = "<CMD>CodeCompanionActions<CR>";
      options.desc = "Open codecompanion action";
    }
  ];
}
