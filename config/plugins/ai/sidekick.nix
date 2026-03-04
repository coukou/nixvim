{ pkgs, ... }:
{

  extraPackages = with pkgs; [
    lsof
  ];

  plugins.sidekick = {
    enable = true;

    settings = {
      cli = {
        mux = {
          enabled = true;
          backend = "tmux";
        };
      };

      nes = {
        enabled = true;
      };
    };
  };

  plugins.lualine.settings = {
    sections.lualine_c = [
      {
        __unkeyed-1.__raw = ''
          function()
            return " "
          end
        '';
        color.__raw = ''
          function()
            local status = require("sidekick.status").get()
            if status then
              return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
            end
          end
        '';
        cond.__raw = ''
          function()
            local status = require("sidekick.status")
            return status.get() ~= nil
          end
        '';
      }
    ];
  };

  keymaps = [
    {
      key = "<tab>";
      action.__raw = ''
        function()
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end
      '';
      options.desc = "Goto/Apply Next Edit Suggestion";
    }
    {
      key = "<leader>aa";
      action.__raw = ''function() require("sidekick.cli").toggle() end'';
      mode = [ "n" "t" "i" "x" ];
      options.desc = "Sidekick Toggle CLI";
    }
    {
      key = "<leader>at";
      action.__raw = ''function() require("sidekick.cli").send({ msg = "{this}" }) end'';
      mode = [ "x" "n" ];
      options.desc = "Sidekick Send this";
    }
    {
      key = "<leader>av";
      action.__raw = ''function() require("sidekick.cli").send({ msg = "{selection}" }) end'';
      mode = [ "x" ];
      options.desc = "Sidekick Send Visual Selection";
    }
    {
      key = "<leader>ap";
      action.__raw = ''function() require("sidekick.cli").prompt() end'';
      options.desc = "Sidekick Select Prompt";
    }
  ];
}
