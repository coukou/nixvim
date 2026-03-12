{ pkgs, ... }:

{
  extraPackages = with pkgs; [
    lsof
  ];

  extraPlugins = [
    (
      pkgs.vimUtils.buildVimPlugin rec {
        pname = "opencode.nvim";
        version = "47f92ab676bf1c3d00a40100429c7b089f81a5fc";
        src = pkgs.fetchFromGitHub {
          owner = "NickvanDyke";
          repo = "opencode.nvim";
          rev = version;
          sha256 = "sha256-xxB6TKn0Nv9GoYc7Mz+rhAUX8OXaHSkD3zZzFgSSHkQ=";
        };
        meta.homepage = "https://github.com/NickvanDyke/opencode.nvim/";
        meta.hydraPlatforms = [ ];
      }
    )
  ];

  plugins.snacks = {
    settings = {
      picker = {
        enabled = true;
      };
    };
  };

  keymaps = [
    {
      key = "<leader>oa";
      action.__raw = ''function() require("opencode").ask("@this: ", { submit = true }) end'';
      options.desc = "Ask opencode";
    }
    {
      key = "<leader>ox";
      action.__raw = ''function() require("opencode").select() end'';
      options.desc = "Execute opencode action";
    }
    {
      key = "<leader>ot";
      action.__raw = ''function() require("opencode").toggle() end'';
      options.desc = "Toggle opencode";
    }
  ];

  opts = {
    autoread = true;
  };
}
