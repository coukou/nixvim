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
      key = "<leader>cc";
      action = "<CMD>CodeCompanionChat<CR>";
      options.desc = "Open codecompanion chat";
    }
    {
      key = "<leader>ca";
      action = "<CMD>CodeCompanionActions<CR>";
      options.desc = "Open codecompanion action";
    }
  ];
}
